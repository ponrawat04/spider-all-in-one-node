#!/bin/bash

# Spider Node All-in-One Installer
# This script sets up Spider Node with Docker Compose

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if Docker is installed
print_header "Checking Docker Installation"
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed"
    echo "Please install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi
print_success "Docker is installed: $(docker --version)"

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed"
    echo "Please install Docker Compose from: https://docs.docker.com/compose/install/"
    exit 1
fi
print_success "Docker Compose is installed: $(docker-compose --version)"

# Check if Docker daemon is running
print_info "Checking Docker daemon..."
if ! docker info &> /dev/null; then
    print_error "Docker daemon is not running"
    echo "Please start Docker and try again"
    exit 1
fi
print_success "Docker daemon is running"

# Create directories if they don't exist
print_header "Setting Up Directories"
mkdir -p spider_data
print_success "Created spider_data directory"

# Download docker-compose.yml if it doesn't exist
print_header "Setting Up Docker Compose Configuration"
if [ ! -f "docker-compose.yml" ]; then
    print_info "Downloading docker-compose.yml..."
    curl -fsSL https://raw.githubusercontent.com/ponrawat04/spider-all-in-one-node/main/docker-compose.yml -o docker-compose.yml
    print_success "Downloaded docker-compose.yml"
else
    print_info "docker-compose.yml already exists"
fi

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    print_info "Creating .env file..."
    cat > .env << EOF
# Spider Node Configuration
NODE_ROLE=validator
P2P_BOOTSTRAP=/dnsaddr/bootstrap.spider-web3.net
LICENSE=MIT

# Container Configuration
CONTAINER_NAME=spider-node-core
RESTART_POLICY=always

# Port Configuration
HTTP_PORT=3000
P2P_PORT=4001

# Data Directory
DATA_DIR=./spider_data
EOF
    print_success "Created .env file"
else
    print_info ".env file already exists"
fi

# Start Docker containers
print_header "Starting Spider Node"
print_info "Pulling images and starting containers..."

if docker-compose up -d; then
    print_success "Spider Node started successfully"
    echo ""
    print_header "Service Information"
    echo -e "Container Name: ${GREEN}spider-node-core${NC}"
    echo -e "HTTP Port: ${GREEN}3000${NC}"
    echo -e "P2P Port: ${GREEN}4001${NC}"
    echo ""
    print_info "View logs: ${YELLOW}docker-compose logs -f${NC}"
    print_info "Stop service: ${YELLOW}docker-compose down${NC}"
    print_info "Check status: ${YELLOW}docker-compose ps${NC}"
else
    print_error "Failed to start Spider Node"
    exit 1
fi

echo ""
print_success "Installation completed!"
