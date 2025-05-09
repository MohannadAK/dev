#!/bin/bash

sleep 1
bluetoothctl power on
bluetoothctl trust 40:72:18:3B:F1:F4
bluetoothctl connect 40:72:18:3B:F1:F4
