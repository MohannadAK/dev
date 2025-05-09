#!/bin/bash
# Kill any existing nm-applet instances to avoid duplicates
killall nm-applet 2>/dev/null
# Launch nm-applet in the background
nm-applet &
# Wait for a short period (e.g., 30 seconds) or until interaction
sleep 10
# Kill nm-applet after timeout
killall nm-applet 2>/dev/null
