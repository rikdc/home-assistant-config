#!/bin/sh
/usr/lib/update-notifier/apt-check 2>&1 | tee /usr/share/hass/share/system_updates.out
