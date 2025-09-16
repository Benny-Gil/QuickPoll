#!/bin/bash

source ./config.sh

echo "Testing List Polls API..."
check_api

# Get all polls
RESPONSE=$(curl -s "$API_URL/polls")

print_response "$RESPONSE"