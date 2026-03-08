#!/bin/bash
###########################################################################
#
# Temperature and humidity to Webex v0.01
#
# Bash script for posting temperature + humidity into a Cisco Webex space.
# The sensor reading script was from Adafruit:
# https://github.com/adafruit/Adafruit_Python_DHT
# It was then used in combination with a DHT22 on a Raspberry Pi on GPIO 4.
# Additionally it provided a timestamp which isn't used.
# 
#
# Author: Dominik Künne
#
###########################################################################

SENSORDATA=$(python /home/pi/sensor.py 22 4)

DATE=$(echo $SENSORDATA | cut -d';' -f1)
TEMP=$(echo $SENSORDATA | cut -d';' -f3)
HUM=$(echo $SENSORDATA | cut -d';' -f4)

echo '{' > webexdata.json
echo ' "text" : "Temperatur: '$TEMP'\nLuftfeuchtigkeit: '$HUM'"' >> webexdata.json
echo '}' >> webexdata.json

curl -X POST -H "Content-Type: application/json" -d @webexdata.json "https://api.ciscospark.com/v1/webhooks/incoming/<INSERT-WEBHOOK-HERE>"