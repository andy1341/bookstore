#!/bin/bash

# Exit on fail
set -e

bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

exec "$@"
