#!/bin/bash

source ./config.sh

echo -e "${YELLOW}Running all API tests...${NC}"

# Initial API check
check_api

echo -e "\n${YELLOW}1. Testing Create Poll API${NC}"
./create_poll.sh

echo -e "\n${YELLOW}2. Testing Vote API${NC}"
./vote.sh
echo -e "\n${YELLOW}Testing second vote...${NC}"
./vote.sh

echo -e "\n${YELLOW}3. Testing Get Poll Results${NC}"
./get_results.sh

echo -e "\n${YELLOW}4. Testing List Polls${NC}"
./list_polls.sh

echo -e "\n${GREEN}All tests completed!${NC}"