#!/bin/bash

# Bluetooth Pairing Test Script
# Usage: ./pair-bluetooth.sh <DEVICE_MAC_ADDRESS>

if [ -z "$1" ]; then
    echo "Usage: $0 <DEVICE_MAC_ADDRESS>"
    echo "Example: $0 AA:BB:CC:DD:EE:FF"
    exit 1
fi

DEVICE_ADDRESS="$1"

echo "Starting Bluetooth pairing process for device: $DEVICE_ADDRESS"
echo "================================================"

{
	echo "agent on"
    	sleep 0.5
    	echo "default-agent"
    	sleep 0.5
    	echo "pair $DEVICE_ADDRESS"
    	sleep 5
    	echo "trust $DEVICE_ADDRESS"
    	sleep 2
    	echo "connect $DEVICE_ADDRESS"
    	sleep 5
} | bluetoothctl
