#!/usr/bin/env bash
# FROM https://github.com/DanySK/gradle-pre-commit-git-hooks/blob/master/src/main/sh/org/danilopianini/gradle/git/hooks/conventional-commit-message.sh
# Checks the commit message file against the conventional commit style
# https://www.conventionalcommits.org/en/v1.0.0/
#
# The file is read into a variable in an escaped format which is easier to regex against

# the commit message file is the only argument
msg_file="$1"

# list of Conventional Commits types
r_types="(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)"
# optional (scope)
r_scope="(\([[:alnum:] \/-]+\))?"
# optional breaking change indicator and colon delimiter
r_delim='!?:'
# subject line
r_subject=" [[:alnum:] ]+"
# body, footer
r_body='($|(\\n(\\n[[:alnum:] ]+)+))'
# the full regex pattern
pattern="^$r_types$r_scope$r_delim$r_subject$r_body"

CONTENT=""
while IFS="" read -r line || [ "$line" ] ; do
	if [[ -z "$CONTENT" ]] ; then
		CONTENT=$line
	else
		CONTENT=$CONTENT\\\\n$line
	fi
done < $msg_file

# Check if commit is conventional commit
if printf "$CONTENT" | grep -P "$pattern" ; then
    exit 0
fi

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${RED}ERROR: Invalid commit message${NC}:
${PURPLE}$( cat "$msg_file" )${NC}
"
echo -e "
Your commit message does ${RED}not${NC} follow ${PURPLE}Conventional Commits${NC} formatting: ${BLUE}https://www.conventionalcommits.org/${NC}
Conventional Commits start with one of the following types:
    ${GREEN}$(IFS=' '; echo "${types[*]}")${NC}
followed by an ${PURPLE}optional scope within parentheses${NC},
followed by an ${RED}exclamation mark${NC} (${RED}!${NC}) in case of ${RED}breaking change${NC},
followed by a colon (:),
followed by the commit message.
Example commit message fixing a bug non-breaking backwards compatibility:
    ${GREEN}fix(module): fix bug #42${NC}
Example commit message adding a non-breaking feature:
    ${GREEN}feat(module): add new API${NC}
Example commit message with a breaking change:
    ${GREEN}refactor(module)!: remove infinite loop${NC}
"
exit 1
