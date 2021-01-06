#!/usr/bin/env bash

export PYTHONPATH=django_asgi

function runtest() {
  # declares
  TEST_NAME=$1
  SERVER_COMMAND="poetry run gunicorn $2 -b 0.0.0.0:8000 -p /tmp/django_test.pid -D"
  WRK_COMMAND="wrk -t 2 -c 200 http://127.0.0.1:8000/polls/ 2>&1"

  # Kill server first
  if [ -f /tmp/django_test.pid ]; then
    echo "Kill previous server"
    xargs kill < /tmp/django_test.pid
    sleep 3
  fi

  echo "Run test $TEST_NAME"
  if ! $SERVER_COMMAND; then
    echo "Run server error, command: $SERVER_COMMAND"
    return 1
  fi

  sleep 3

  echo "Run test: $WRK_COMMAND"

  if ! OUTPUT=$($WRK_COMMAND); then
    echo "Run wrk failed"
    return 2
  fi

  echo "$TEST_NAME"
  echo "$OUTPUT"

  if ! xargs kill < /tmp/django_test.pid; then
    echo "Failed to kill server"
  fi
  sleep 3
}

runtest 'sync' 'wsgi:application -k sync'
runtest 'gthread' 'wsgi:application -k gthread --threads 10'
runtest 'ASGI' 'asgi:application -k uvicorn.workers.UvicornWorker'
