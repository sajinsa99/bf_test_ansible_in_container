#!/bin/bash

# Build script for Ansible Docker environment

set -e

echo "Building Ansible Docker environment..."
docker-compose build

echo ""
echo "Build completed successfully!"
echo ""
echo "Next steps:"
echo "1. Start containers: docker-compose up -d"
echo "2. Access ansible container: docker-compose exec ansible bash"
echo "3. Run playbook: ansible-playbook -i inventory/hosts.ini playbooks/test_playbook.yml"
