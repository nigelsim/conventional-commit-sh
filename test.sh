#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

for test_ in tests/* ; do
	PARTS=($(echo $test_ | sed -e 's/tests\///g' | tr "-" "\n"))
	EXPECTED_OUTCOME=${PARTS[0]}
	TYPE=${PARTS[1]}

	RESPONSE=$(./conventional-commit-message.sh $test_)
	OUTCOME=$?

	echo -e "$BLUE$TYPE$NC ${PARTS[@]:2}"
	if [[ "$EXPECTED_OUTCOME" == "pass" && "$OUTCOME" == "0" || "$EXPECTED_OUTCOME" == "fail" && "$OUTCOME" == "1" ]] ; then
		echo -e "${GREEN}pass${NC}"
	else
		echo -e "${RED}fail${NC} $test_ $EXPECTED_OUTCOME $OUTCOME"
		echo -e $RESPONSE
	fi
done


