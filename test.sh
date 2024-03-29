#!/bin/bash
# Setup and run extension tests. This script should be run in a _clean_ CKAN
# environment. e.g.:
#
#     $ docker-compose run --rm app ./test.sh
#

set -o errexit
set -o pipefail

TEST_CONFIG=/srv/app/test.ini

# Database is listening, but still unavailable. Just keep trying...
while ! ckan -c $TEST_CONFIG db init; do
  echo Retrying in 5 seconds...
  sleep 5
done

ckan -c $TEST_CONFIG harvester initdb

# start_ckan_development.sh &
pytest --ckan-ini=$TEST_CONFIG --cov=ckanext.datagovcatalog --disable-warnings /srv/app/ckanext/datagovcatalog/tests/
