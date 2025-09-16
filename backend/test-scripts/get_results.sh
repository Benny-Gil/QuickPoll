#!/bin/bash

source ./config.sh

echo "Testing Get Poll Results API..."
check_api

# Get last created poll ID
POLL_ID=$(cat .last_poll_id)
if [ -z "$POLL_ID" ]; then
    echo -e "${RED}No poll ID found. Run create_poll.sh first.${NC}"
    exit 1
fi

# Get poll results
RESPONSE=$(curl -s "$API_URL/polls/$POLL_ID/results")

print_response "$RESPONSE"