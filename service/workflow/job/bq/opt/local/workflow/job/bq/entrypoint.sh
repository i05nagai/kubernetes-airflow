#!/bin/bash

export PYTHONPATH="/opt/local/workflow/job/bq:${PYTHONPATH}"
exec "$@"

