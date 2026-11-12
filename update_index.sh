#!/bin/bash
TASKS_FILE="$1"
TEST_FILE="$2"
HTML="/app/index.html"

TODO=$(sed -n '/^ToDo Tasks:/,/^Done Tasks:/p' "$TASKS_FILE" | grep -v -e '^ToDo Tasks:' -e '^Done Tasks:')
DONE=$(awk '/^Done Tasks:/{f=1;next} f' "$TASKS_FILE")
TESTS=$(cat "$TEST_FILE")

update_pre() {
  ID="$1" CONTENT="$2" perl -0pi -e 's|(<pre id="$ENV{ID}">).*?(</pre>)|$1$ENV{CONTENT}$2|s' "$3"
}

update_pre todo  "$TODO"  "$HTML"
update_pre done  "$DONE"  "$HTML"
update_pre tests "$TESTS" "$HTML"

git config --global user.email "${GITHUB_USER}@users.noreply.github.com"
git config --global user.name "${GITHUB_USER}"
git add "$HTML"
git commit -m "Update index.html with tasks and test results"
git push
