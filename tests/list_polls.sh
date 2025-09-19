#!/bin/bash

source ./config.sh

echo -e "${YELLOW}Testing List Polls API...${NC}"
check_api

# Get all polls
echo -e "${YELLOW}Fetching all polls...${NC}"
RESPONSE=$(curl -s "$API_URL/polls")

if validate_json "$RESPONSE"; then
    print_response "$RESPONSE"
    POLL_COUNT=$(echo "$RESPONSE" | jq '. | length')
    echo -e "${GREEN}Retrieved $POLL_COUNT polls successfully${NC}"
else
    echo -e "${RED}Failed to fetch polls${NC}"
    exit 1
fi