#!/usr/bin/env bash

# Create the log file
log_file="${LOGGING_DIRECTORY}/greetingd.log"
touch "${log_file}"

greet() {
  sleep "${GREETING_INTERVAL}"
  echo "[$(date -u)] ${GREETING_MESSAGE}" >> "${log_file}"
  greet
}

greet
