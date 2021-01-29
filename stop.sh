#!/bin/bash

# # # # # # # HELPERS FUNCTIONS # # # # # # # #

function error() {
  echo "❌ $1" >&2
  exit 1
}

# # # # # # # # CORE FUNCTIONS # # # # # # # #

stop() {
  echo '⌛ Stopping environment...'
  if docker-compose down; then
    echo "✋ Environment stopped successfully !"
  else
    error "Something goes wrong while stopping Docker environment"
  fi
}

stop
