#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
# Seeds are idempotent: they only add missing starter content and never delete data
bundle exec rake db:seed
