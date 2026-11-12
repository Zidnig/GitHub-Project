#!/bin/bash
cd /app/.github/scripts
python3 todo.py      | tee /tmp/tasks.txt
python3 todo-test.py | tee /tmp/tests.txt
bash /app/.github/scripts/update_index.sh /tmp/tasks.txt /tmp/tests.txt
