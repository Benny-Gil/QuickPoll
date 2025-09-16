#!/bin/bash

source ./config.sh

echo "Running all API tests..."
check_api

echo -e "\n1. Creating a new poll..."
./create_poll.sh

echo -e "\n2. Casting votes..."
./vote.sh
./vote.sh # Cast second vote

echo -e "\n3. Getting poll results..."
./get_results.sh

echo -e "\n4. Listing all polls..."
./list_polls.sh

echo -e "\n${GREEN}All tests completed!${NC}"