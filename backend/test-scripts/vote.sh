#!/bin/bash

source ./config.sh

echo "Testing Vote API..."
check_api

# Get last created poll ID
POLL_ID=$(cat .last_poll_id)
if [ -z "$POLL_ID" ]; then
    echo -e "${RED}No poll ID found. Run create_poll.sh first.${NC}"
    exit 1
fi

# Get options for the poll
POLL_OPTIONS=$(curl -s "$API_URL/polls/$POLL_ID" | jq -r '.options[0].id')
OPTION_ID=$POLL_OPTIONS

# Cast a vote
RESPONSE=$(curl -s -X POST "$API_URL/polls/$POLL_ID/vote" \
    -H "Content-Type: application/json" \
    -d "{\"optionId\": $OPTION_ID}")

print_response "$RESPONSE"