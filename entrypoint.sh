#!/bin/bash
set -e
echo "entering entrypoint"
# Remove a potentially pre-existing server.pid for Rails.
if [ -f  /artifacts_data_api/tmp/pids/server.pid ]; then
  echo "===== Removing existing pid ======="
  rm  /artifacts_data_api/tmp/pids/server.pid
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec bundle exec "$@"
