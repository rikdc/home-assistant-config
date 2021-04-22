# Hardware

This page will contain a list of the hardware used within the smarthome.

## Home Servers

The network is comprosed of three servers, multiple personal devices and various IoT devices.

## Wifi Network

The Wifi network uses Unifi hardware, which at the time was both affordable and very powerful in terms of functionality.

| Device      | Quantity | Notes |
| :---------- | :------: | :---- |
| AP Lite     |    2     |       |
| Switch      |    2     |       |
| EdgeRouterX |    1     |       |

## Cameras

A core focal point of the smarthome is privacy, and at the time euFy were offering the most private solution I could afford. I didn't want to rewire my house with POE cameras, though I can't deny that might well happen soon. Their offline recording was a big bonus.

Overall I am happy with euFy cameras, though I was dissapointed to learn that they need cloud connectivity to work still. It's a sunk cost, so I will keep these cameras until they stop working. I don't plan to buy more, but I will when the time is ready switch to POE.

In reality, I also didn't want my home to feel like some max security complex or have the watchful eye of Big Brother, so the rules are simple. 1) No indoor cameras.

### Cameras

| Device              | Quantity | Notes                                 |
| :------------------ | :------: | :------------------------------------ |
| 1 Eufy Base Station |    1     | Required to connect to the cameras    |
| eufyCam             |    2     |                                       |
| WyzeCam             |    1     | Used to detect activity in the garage |
| Wyze Doorbell       |    1     |                                       |

## Z-Wave Network

I spent a long time deciding between Z-Wave and Zigbee devices, and although more expensive I ultimately landed on Z-Wave for a number of reasons.

### Devices

| Device                                | Quantity | Notes                                                                    |
| :------------------------------------ | :------: | :----------------------------------------------------------------------- |
| [Zooz S2 Controller][zooz-controller] |    1     | Main Z-Wave Controller Stick                                             |
| [Zen27][zooz-motion]                  |    2     | Detecting motions in both rooms, with additional temperature monitoring. |
| [Zen26][zooz-motion2]                 |    1     | Controlling lights, scenes and modes                                     |
| [Zen34][zooz-zen34]                   |    2     | Used to control bathroom lights & fans                                   |
| [Zooz Zen25][zooz-zen25]              |    1     | Simple switch used for nightstands                                       |
| [Zen34 Scene Controller][zooz-zen34]  |    1     | Scene Controller used for each floor                                     |
| [Zen76 On/Off][zooz-zen76]            |    2     |                                                                          |

<!-- Devices -->

[zooz-controller]: https://www.thesmartesthouse.com/collections/gateway-controllers/products/zooz-usb-z-wave-plus-s2-stick-zst10
[zooz-motion]: https://www.thesmartesthouse.com/collections/multisensors/products/zooz-z-wave-plus-4-in-1-sensor-zse40
[zooz-zse11]: https://www.thesmartesthouse.com/collections/multisensors/products/zooz-z-wave-plus-q-sensor-zse11-motion-temp-humidity-light
[zooz-zen21]: https://www.thesmartesthouse.com/collections/zooz/products/zooz-z-wave-plus-on-off-light-switch-zen21
[zooz-zen27]: https://www.thesmartesthouse.com/collections/zooz/products/zooz-z-wave-plus-s2-dimmer-switch-zen27-with-simple-direct-3-way-4-way
[zooz-zen32]: https://www.thesmartesthouse.com/collections/zooz/products/zooz-z-wave-plus-s2-double-switch-zen30-white-for-light-fan-combo
[zooz-zen34]: https://www.thesmartesthouse.com/collections/zooz/products/zooz-z-wave-plus-700-series-remote-switch-zen34-battery-powered
[zooz-zen25]: https://www.thesmartesthouse.com/collections/zooz/products/zooz-z-wave-plus-s2-double-plug-zen25-with-usb-port
