#!/bin/bash

# API Gateway URL
API_URL="http://localhost/api"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if the API gateway is running
check_api() {
    echo -e "${YELLOW}Checking API Gateway...${NC}"
    curl -s -f "$API_URL/health" > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ API Gateway is running${NC}"
    else
        echo -e "${RED}✗ API Gateway is not running${NC}"
        echo -e "${YELLOW}Please ensure docker containers are running with: ./run_docker.sh${NC}"
        exit 1
    fi
}

# Function to print response in a nice format
print_response() {
    echo -e "${GREEN}Response:${NC}"
    echo "$1" | jq '.'
}

# Function to validate JSON response
validate_json() {
    if echo "$1" | jq '.' >/dev/null 2>&1; then
        return 0
    else
        echo -e "${RED}Invalid JSON response${NC}"
        return 1
    fi
}

# Store the last created poll ID
LAST_POLL_FILE=".last_poll_id"

# Function to save poll ID
save_poll_id() {
    echo "$1" > "$LAST_POLL_FILE"
}

# Function to get last poll ID
get_last_poll_id() {
    if [ -f "$LAST_POLL_FILE" ]; then
        cat "$LAST_POLL_FILE"
    else
        echo ""
    fi
}