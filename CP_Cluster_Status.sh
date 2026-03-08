#!/bin/bash
#################################################################################################
#
# Check Point cluster status to Webex v0.01
#
# Bash script for retrieving HA status from two nodes and post it into a Cisco Webex Space
# Needs to be run on the management, e. g. via cronjob
#
# Author: Dominik Künne
#
#################################################################################################

STATE1=$(cphaprob stat | sed -n '6p' | cut -c44-50)
STATE2=$(cphaprob stat | sed -n '7p' | cut -c44-50)

echo '{' > webexdata.json
echo ' "text" : "Check Point Cluster Status\nNode 1: '$STATE1'\nNode 2: '$STATE2'"' >> webexdata.json
echo '}' >> webexdata.json

curl_cli --insecure -X POST -H "Content-Type: application/json" -d @webexdata.json "https://api.ciscospark.com/v1/webhooks/incoming/<INSERT-WEBHOOK-HERE>"