One thing that is particularly troublesome is identifying when the cat needs to be fed. But hear me out, this is because we never know who fed the cat and automated feeders aren't going to work for various reasons not important to this post.

## Setup

### Define the Problem

_dipshit_ needs to be fed _twice daily_ by _someone_ between _6 and 9 in the morning_ and _6 and 8 in the evening._ All household members should be alerted that the cat needs feeding, and alerted when the cat has been fed so not to double feed him. (He tries it on!)

## Sensors

To create this automation, two sensors are required. The first indicates how long its been since the cat has been fed and the second is a helper sensor to indicate if it's time to feed the cat.

```
sensor:
  - platform: template
    sensors:
      cat_last_fed:
        friendly_name: 'Cat last fed'
        unit_of_measurement: 'hours(s) ago'
        value_template: >
          {{ ((now().timestamp() - state_attr('input_datetime.cat_last_fed','timestamp'))/(60*60)) | round(0, 'floor') |int }}

binary_sensor:
  - platform: template
    sensors:
      cat_needs_feeding:
        friendly_name: "Cat needs feeding"
        value_template: >
          {{ states('sensor.cat_last_fed')|int >= 9 and ((now().hour <= 9 and now().hour >= 7) or (now().hour >= 18 and now().hour <= 20)) }}
```

## Automation

There are two automations to complete the use case. The first is a nagging notification that, if the cat has not been fed will send an alert every 30 minutes. Frankly, this isn't needed because the cat makes sure we know its feeding time. The purpose of this notification is really to make a quick access button on our phones.

The automation trigger is simple, check the binary state:

```
  - id: '1610928666132'
    alias: Has the cat been fed yet?
    description: ''
    trigger:
    - platform: state
      entity_id: binary_sensor.cat_needs_feeding
      to: 'on'
    condition: []
```

Repeating the automation every 30 minutes for a max of 3 times is also trivial to do:

```
    action:
    - repeat:
        count: 3
        sequence:
        - condition: template
          value_template: '{{ is_state(''binary_sensor.cat_needs_feeding'', ''on'')}}'
        # Call Services Here
        - wait_for_trigger:
          - platform: template
            value_template: '{{ not is_state(''binary_sensor.cat_needs_feeding'', ''on'')}}'
          timeout: 1800 # 30 Minutes
```

The next thing to do is send the mobile alert. To do this on iPhones the notification category has to be defined first:

```
ios:
  push:
    categories:
      - name: Cat
        identifier: 'cat_feeding'
        actions:
          - identifier: 'HAS_BEEN_FED'
            title: 'Yes'
            behavior: 'default'
          - identifier: 'NOT_BEEN_FED'
            title: 'No'
            behavior: 'default'
```

Here, I have the alert to simply ask if the cat has been fed and a button to confirm or deny this.

To send the notification we call the notify service:

```
        - service: notify.iphone
          data:
            title: "Animal Welfare"
            message: "Have you fed Dipshit?"
            data:
              push:
                badge: 5
                category: "cat_feeding" # Needs to match the top level identifier you used in the ios configuration
```

And presto! It works. Now, there's a problem. I don't want to get 3 stacked notifications and instead prefer to have the same notification reshow on my phone. This can be done by adding the following tag to the data:

```
    apns_headers: {
        "apns-collapse-id": "cat_feeding", # This stops multiple of the same notification from being stacked.
    }
```

The final automation is to simply update the last fed time for the cat. To do this, we listen for the `mobile_app_notification_action` event as a trigger to the automation.

```
  - id: '1610928766081'
    alias: Cat has been fed
    description: Clears alerts when the cat has been fed
    trigger:
    - platform: event
      event_type: ios.notification_action_fired
      event_data:
        actionName: HAS_BEEN_FED
    condition: []
    action:
    - service: input_datetime.set_datetime
      data:
        datetime: '{{ now().isoformat() }}'
      entity_id: input_datetime.cat_last_fed
    - service: notify.all
      data_template:
        message: >
          {% if trigger is defined and trigger.event.context is defined %}
            Dipshit has been fed by {{ state_attr((states.person|selectattr('attributes.user_id','eq',trigger.event.context.user_id)|first or "system").entity_id, "friendly_name") }}
          {% else %}
            Dipshit has been fed by {{ context.user_id }}
          {% endif %}
    mode: single
```
