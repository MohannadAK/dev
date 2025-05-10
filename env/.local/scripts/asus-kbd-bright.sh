#!/bin/bash

# Custom wrapper for asusctl that modifies brightness cycling behavior
# For ROG Strix G15 laptops running Arch Linux

# Function to show usage information
show_help() {
    echo "Custom asusctl wrapper for ROG Strix G15"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help             Show this help message"
    echo "  -n, --next-kbd-bright  Cycle to next keyboard brightness (stops at high)"
    echo "  -p, --prev-kbd-bright  Cycle to previous keyboard brightness (stops at off)"
    echo "  --pass-through         Pass all arguments directly to asusctl"
    echo ""
    echo "All other asusctl commands can be accessed via the --pass-through option"
    echo "Example: $0 --pass-through aura static -c blue"
}

# Get current keyboard brightness
get_current_brightness() {
    # Check if we have stored the current brightness
    if [ -f "$BRIGHTNESS_FILE" ]; then
        cat "$BRIGHTNESS_FILE"
    else
        # Default to 'off' if we don't know the current state
        echo "off"
    fi
}

# Set keyboard brightness and store the new state
set_brightness() {
    local new_brightness="$1"
    asusctl -k "$new_brightness" > /dev/null 2>&1
    echo "$new_brightness" > "$BRIGHTNESS_FILE"
}

# Path to store the current brightness state
BRIGHTNESS_FILE="$HOME/.asusctl_brightness"

# Create the file if it doesn't exist
if [ ! -f "$BRIGHTNESS_FILE" ]; then
    echo "off" > "$BRIGHTNESS_FILE"
fi

# Process the arguments
if [ $# -eq 0 ]; then
    # If no arguments, show asusctl output
    asusctl
else
    case "$1" in
        -h|--help)
            show_help
            ;;
        -n|--next-kbd-bright)
            current=$(get_current_brightness)
            case "$current" in
                "off")
                    set_brightness "low"
                    echo "Keyboard brightness set to low"
                    ;;
                "low")
                    set_brightness "med"
                    echo "Keyboard brightness set to medium"
                    ;;
                "med")
                    set_brightness "high"
                    echo "Keyboard brightness set to high"
                    ;;
                "high")
                    # Stop at high, don't cycle back to off
                    echo "Keyboard brightness already at maximum (high)"
                    ;;
                *)
                    # If the stored state is invalid, reset to off
                    set_brightness "off"
                    echo "Keyboard brightness reset to off"
                    ;;
            esac
            ;;
        -p|--prev-kbd-bright)
            current=$(get_current_brightness)
            case "$current" in
                "high")
                    set_brightness "med"
                    echo "Keyboard brightness set to medium"
                    ;;
                "med")
                    set_brightness "low"
                    echo "Keyboard brightness set to low"
                    ;;
                "low")
                    set_brightness "off"
                    echo "Keyboard brightness turned off"
                    ;;
                "off")
                    # Stop at off, don't cycle back to high
                    echo "Keyboard brightness already at minimum (off)"
                    ;;
                *)
                    # If the stored state is invalid, reset to off
                    set_brightness "off"
                    echo "Keyboard brightness reset to off"
                    ;;
            esac
            ;;
        --pass-through)
            # Pass all remaining arguments directly to asusctl
            shift
            asusctl "$@"
            ;;
        *)
            # For any other commands, pass directly to asusctl
            asusctl "$@"
            ;;
    esac
fi
