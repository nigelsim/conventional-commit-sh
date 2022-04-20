#!/bin/bash

MESSAGE="quis nostrud exercitation ullamco laboris nisi ut aliquip"
BODY="line1\nline2"

rm tests/*

for type_ in build chore ci docs feat fix perf refactor revert style test ; do
	printf "$type_: $MESSAGE" > tests/pass-$type_-no-scope-single-line
	printf "$type_!: $MESSAGE" > tests/pass-$type_-no-scope-breaking-change-single-line
	printf "$type_(module): $MESSAGE" > tests/pass-$type_-valid-scope-single-line
	printf "$type_(module)!: $MESSAGE" > tests/pass-$type_-valid-scope-breaking-change-single-line
	printf "$type_(long scope): $MESSAGE" > tests/pass-$type_-long-scope-single-line
	printf "$type_(long scope)!: $MESSAGE" > tests/pass-$type_-long-scope-breaking-change-single-line

	printf "$type_: $MESSAGE\n\n$BODY" > tests/pass-$type_-no-scope-multi-line
	printf "$type_!: $MESSAGE\n\n$BODY" > tests/pass-$type_-no-scope-breaking-change-multi-line
	printf "$type_(module): $MESSAGE\n\n$BODY" > tests/pass-$type_-valid-scope-multi-line
	printf "$type_(module)!: $MESSAGE\n\n$BODY" > tests/pass-$type_-valid-scope-breaking-change-multi-line

	printf "$type_: $MESSAGE\n$BODY" > tests/fail-$type_-no-scope-multi-line-without-break
	printf "$type_!: $MESSAGE\n$BODY" > tests/fail-$type_-no-scope-breaking-change-multi-line-without-break
	printf "$type_(module): $MESSAGE\n$BODY" > tests/fail-$type_-valid-scope-multi-line-without-break
	printf "$type_(module)!: $MESSAGE\n$BODY" > tests/fail-$type_-valid-scope-breaking-change-multi-line-without-break
done


for type_ in invalid types ; do
	printf "$type_: $MESSAGE" > tests/fail-$type_-no-scope-single-line
	printf "$type_!: $MESSAGE" > tests/fail-$type_-no-scope-breaking-change-single-line
	printf "$type_(module): $MESSAGE" > tests/fail-$type_-valid-scope-single-line
	printf "$type_(module)!: $MESSAGE" > tests/fail-$type_-valid-scope-breaking-change-single-line
	printf "$type_(long scope): $MESSAGE" > tests/fail-$type_-long-scope-single-line
	printf "$type_(long scope)!: $MESSAGE" > tests/fail-$type_-long-scope-breaking-change-single-line
done

