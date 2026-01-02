#!/bin/bash

# Run script for Ansible Docker environment

set -e

echo "Starting Ansible Docker environment..."
docker-compose up -d

echo ""
echo "Containers started!"
echo ""
echo "Access ansible controller:"
echo "docker-compose exec ansible bash"
echo ""
echo "View logs:"
echo "docker-compose logs -f"
