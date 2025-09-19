#!/bin/bash

source ./config.sh

echo -e "${YELLOW}Testing Get Poll Results API...${NC}"
check_api

# Get last created poll ID
POLL_ID=$(get_last_poll_id)
if [ -z "$POLL_ID" ]; then
    echo -e "${RED}No poll ID found. Run create_poll.sh first.${NC}"
    exit 1
fi

# Get poll results
echo -e "${YELLOW}Fetching results for poll $POLL_ID...${NC}"
RESPONSE=$(curl -s "$API_URL/polls/$POLL_ID")

if validate_json "$RESPONSE"; then
    print_response "$RESPONSE"
    
    # Display vote counts
    echo -e "\n${GREEN}Vote counts:${NC}"
    echo "$RESPONSE" | jq -r '.options[] | "  \(.text): \(.votes) votes"'
else
    echo -e "${RED}Failed to fetch poll results${NC}"
    exit 1
fi