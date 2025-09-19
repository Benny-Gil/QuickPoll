#!/bin/bash

source ./config.sh

echo -e "${YELLOW}Testing Vote API...${NC}"
check_api

# Get last created poll ID
POLL_ID=$(get_last_poll_id)
if [ -z "$POLL_ID" ]; then
    echo -e "${RED}No poll ID found. Run create_poll.sh first.${NC}"
    exit 1
fi

# Get poll details to find an option ID
echo -e "${YELLOW}Getting poll details...${NC}"
POLL_RESPONSE=$(curl -s "$API_URL/polls/$POLL_ID")

if validate_json "$POLL_RESPONSE"; then
    # Extract first option ID
    OPTION_ID=$(echo "$POLL_RESPONSE" | jq -r '.options[0].id')
    if [ -z "$OPTION_ID" ] || [ "$OPTION_ID" == "null" ]; then
        echo -e "${RED}No options found for poll${NC}"
        exit 1
    fi

    # Cast a vote
    echo -e "${YELLOW}Casting vote for option $OPTION_ID...${NC}"
    RESPONSE=$(curl -s -X POST "$API_URL/polls/$POLL_ID/vote/$OPTION_ID")

    if validate_json "$RESPONSE"; then
        print_response "$RESPONSE"
        echo -e "${GREEN}Vote cast successfully${NC}"
    else
        echo -e "${RED}Failed to cast vote${NC}"
        exit 1
    fi
else
    echo -e "${RED}Failed to get poll details${NC}"
    exit 1
fi