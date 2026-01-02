#!/bin/bash

# Setup and run script - builds Docker image and starts containers

set -e

echo "=========================================="
echo "Ansible Docker Environment - Setup & Run"
echo "=========================================="
echo ""

# Run build script
echo "[1/3] Building Docker image..."
bash scripts/build.sh

echo ""
echo "[2/3] Running ansible-lint..."
docker-compose run --rm ansible ansible-lint ansible/playbooks/

echo ""
echo "[3/3] Starting containers..."
bash scripts/run.sh

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Access the ansible controller:"
echo "   docker-compose exec ansible bash"
echo ""
echo "2. Run a playbook:"
echo "   ansible-playbook -i inventory/hosts.ini playbooks/main.yaml"
echo ""
echo "3. View logs:"
echo "   docker-compose logs -f"
echo ""
echo "4. Stop containers:"
echo "   docker-compose down"
echo ""
