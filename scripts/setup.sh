#!/bin/bash

# Setup and run script - builds Docker image and starts containers

set -e

echo "=========================================="
echo "Ansible Docker Environment - Setup & Run"
echo "=========================================="
echo ""

# Run build script
echo "[1/4] Building Docker image..."
bash scripts/build.sh

echo ""
echo "[2/4] Running ansible-lint..."
docker-compose run --rm ansible ansible-lint ansible/playbooks/

echo ""
echo "[3/4] Starting containers..."
bash scripts/run.sh

echo ""
echo "Waiting for containers to be ready..."
sleep 3

echo ""
echo "[4/4] Running Ansible playbook..."
docker-compose exec -T ansible ansible-playbook -i inventory/hosts.ini playbooks/main.yaml

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "KDE is now installing. Please wait for the RDP server to be ready."
echo ""
echo "Next steps:"
echo "1. Connect via Remote Desktop:"
echo "   Address: localhost:3389"
echo "   Username: ansible"
echo ""
echo "2. View logs:"
echo "   docker-compose logs -f"
echo ""
echo "3. Stop containers:"
echo "   docker-compose down"
echo ""
