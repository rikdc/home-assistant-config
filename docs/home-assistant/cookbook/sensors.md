# Sensors

This page contains example sensors

## Sensors Online

If your use case is to understand which sensors might have stopped working, the following templates may help.

Define a group of the sensors you wish to monitor

```
group:
  dws_sensors:
    # Contact
    - binary_sensor.frontdoor_access_control_window_door_is_open
    ...
    # Motion
    - binary_sensor.frontdoor_motion_home_security_motion_detection
    ...
```

The following code snippet assumes a sensor with no update after 3 days is considered 'offline':

```

sensor:
  - platform: template
    sensors:
      dws_sensors_online:
        value_template: >-
          {% set t = strptime(((now().timestamp() - 780) | timestamp_utc) ~ '+00:00', '%Y-%m-%d %H:%M:%S%z') %}
          {{
            expand('group.dws_sensors')
            | selectattr('last_changed', '<=' , t)
            | map(attribute='name')
            | list
            | count
          }}

```

First is to set the time window, the variable `t` provides the latest reasonable time a sensor would have given a signal.

```
% set t = strptime(((now().timestamp() - 780) | timestamp_utc) ~ '+00:00', '%Y-%m-%d %H:%M:%S%z') %}
```

Then the group of sensors created earlier can be expanded and filtered by passing `t` to the `selectattr` filter.

For more eye candy on the dashboards, it would be nice to view the availability as a percentage and as a 'x of y' label.

The full code is available here:

## Database

Keep an eye on your database size with this template sensor:

```
  - platform: sql
    db_url: !secret db_url
    queries:
      - name: HASS DB size
        query: 'SELECT table_schema "database", ROUND(SUM(data_length + index_length) / 1048576, 2) "value" FROM information_schema.tables WHERE table_schema="homeassistant" GROUP BY table_schema;'
        column: 'value'
        unit_of_measurement: MB
```
