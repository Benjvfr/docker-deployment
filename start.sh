#!/bin/bash

# # # # # # # HELPERS FUNCTIONS # # # # # # # #

function error() {
  echo "❌ $1" >&2
  exit 1
}

function success() {
  echo "✅ $1"
}

function loading() {
  echo "⌛ $1"
}


# # # # # # # # CORE FUNCTIONS # # # # # # # #

function checkDockerDependency() {
  if ! [ -x "$(command -v docker)" ]; then
    error "docker dependency : please install Docker on your machine"
  else
    success "docker dependency is installed"
  fi
}

function checkDockerComposeDependency() {
  if ! [ -x "$(command -v docker-compose)" ]; then
    error "docker-compose dependency : please install docker-compose on your machine"
  else
    success "docker-compose dependency is installed"
  fi
}

function setupEnvironmentVariables() {
  if ! [[ -f ".env" ]]; then
    error ".env not found"
  else
    success "Environment file loaded successfully"
  fi

  loading "Parsing environment variables..."
    set -a
    source .env
    set +a
  success "Environment variables parsed successfully"
}

function infos() {
  echo "🚀 Environment ready !"
  echo "💡 App is running on http://localhost:$HAPROXY_EXPOSED_PORT/hello-world/"
}

function startContainers() {
  loading "Starting all Docker containers..."
  if docker-compose up --build -d; then
    sleep 5 # wait, just to be sure...
    success "Containers started successfully"
  else
    error "Something goes wrong while starting Docker containers"
  fi
}

main() {
  # 0. Load environment variables
  echo "# # # # # SET UP ENV VARIABLES # # # # #"
  setupEnvironmentVariables
  echo ""

  # 1. Check dependencies
  echo "# # # # CHECKING EXTERNAL DEPENDENCIES # # # #"
  checkDockerDependency
  checkDockerComposeDependency
  echo ""

  # 2. Run docker-compose
  echo "# # # # # # # STARTING CONTAINERS # # # # # # #"
  startContainers
  echo ""

  # 3. Give some additional informations
  echo "# # # # # ADDITIONAL INFORMATIONS # # # # # # #"
  infos
}

main
