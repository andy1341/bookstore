#!/bin/bash

# Exit on fail
set -e

rm -f $APP_HOME/tmp/pids/server.pid
rm -f $APP_HOME/tmp/pids/sidekiq.pid

bundle check || bundle install --jobs $(nproc) --retry 5

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

exec "$@"
