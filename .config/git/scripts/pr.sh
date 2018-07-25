#!/bin/bash

tmp=$(mktemp)
cat <<EOF >>$tmp
What does this do?
==================

# Provide a brief summary about what this pull request is for.

Why do this?
============

# Provide a brief summary as to why we need this.

Details
=======

EOF

git diff --name-status $(cat .git/refs/remotes/origin/HEAD | awk -F'/' '{printf "%s/%s..",$(NF-1),$NF}') | awk '{printf "* `%s` - \n",$NF}' >>$tmp

cat <<EOF >>$tmp

Sample Output
=============

\`\`\`
EOF

terraform show -no-color infrastructure/environment/plan.out >>$tmp

cat <<EOF >>$tmp
\`\`\`

Related Commits
===============

EOF

git log $(cat .git/refs/remotes/origin/HEAD | awk -F'/' '{printf "%s/%s..",$(NF-1),$NF}') --format='format:* `%h` %s' >>$tmp

vim -c 'set ft=markdown' -c 'set tw&' $tmp
