#!/usr/bin/env bash
# exit on error
set -o errexit

bundle installs
bundle exec rake db:migrate
