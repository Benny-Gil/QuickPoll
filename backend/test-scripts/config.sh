#!/bin/bash

# API base URL
API_URL="http://localhost:8080/api"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if the API is running
check_api() {
    curl -s -f "$API_URL/polls" > /dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ API is running${NC}"
    else
        echo -e "${RED}✗ API is not running${NC}"
        exit 1
    fi
}

# Function to print response in a nice format
print_response() {
    echo -e "${GREEN}Response:${NC}"
    echo "$1" | jq '.'
}