#!/bin/bash

source ./config.sh

echo "Testing Create Poll API..."
check_api

# Test data
POLL_DATA='{
    "question": "What is your favorite programming language?",
    "options": [
        "Java",
        "Python",
        "JavaScript",
        "Go"
    ]
}'

# Create a poll
RESPONSE=$(curl -s -X POST "$API_URL/polls" \
    -H "Content-Type: application/json" \
    -d "$POLL_DATA")

print_response "$RESPONSE"

# Store poll ID for other tests
POLL_ID=$(echo "$RESPONSE" | jq -r '.id')
echo $POLL_ID > .last_poll_id