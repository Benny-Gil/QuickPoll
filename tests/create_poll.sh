#!/bin/bash

source ./config.sh

echo -e "${YELLOW}Testing Create Poll API...${NC}"
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
echo -e "${YELLOW}Creating a new poll...${NC}"
RESPONSE=$(curl -s -X POST "$API_URL/polls" \
    -H "Content-Type: application/json" \
    -d "$POLL_DATA")

if validate_json "$RESPONSE"; then
    print_response "$RESPONSE"
    
    # Extract and save poll ID
    POLL_ID=$(echo "$RESPONSE" | jq -r '.id')
    if [ ! -z "$POLL_ID" ] && [ "$POLL_ID" != "null" ]; then
        save_poll_id "$POLL_ID"
        echo -e "${GREEN}Poll created successfully with ID: $POLL_ID${NC}"
    else
        echo -e "${RED}Failed to extract poll ID${NC}"
        exit 1
    fi
else
    exit 1
fi