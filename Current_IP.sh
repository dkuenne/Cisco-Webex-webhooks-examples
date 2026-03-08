#!/bin/bash
############################################################################
#
# Current IP to Webex v0.01
#
# Bash script for retrieving current IP and post it into a Cisco Webex Space
#
# Author: Dominik Künne
#
############################################################################

curl -X POST -H "Content-Type: application/json" -d '{"text" : "Aktuelle IP: '$(curl -s https://api.ipify.org)'"}' "https://api.ciscospark.com/v1/webhooks/incoming/<INSERT-WEBHOOK-HERE>"