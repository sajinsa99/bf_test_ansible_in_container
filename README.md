# Ansible in Docker - SLES 15 SP7

This project sets up Ansible testing environment in Docker containers using SUSE Linux Enterprise Server 15 Service Pack 7.

## Structure

```
.
├── docker/
│   └── Dockerfile                      # SLES 15 SP7 with Ansible and ansible-lint
├── ansible/
│   ├── playbooks/
│   │   ├── main.yaml                   # Main playbook - includes all tasks
│   │   ├── install_vim.yml             # Vim installation playbook
│   │   └── test_playbook.yml           # System information test playbook
│   ├── inventory/
│   │   └── hosts.ini                   # Inventory configuration
│   ├── roles/                          # Ansible roles (placeholder)
│   └── ansible.cfg                     # Ansible configuration
├── scripts/
│   ├── build.sh                        # Build Docker image
│   └── run.sh                          # Start containers
├── docker-compose.yml                  # Docker Compose configuration
├── .dockerignore                       # Docker build exclusions
├── .gitignore                          # Git exclusions
└── README.md                           # This file
```

## Prerequisites

- Docker
- Docker Compose

## Quick Start

### 1. Build the Docker Image

```bash
docker-compose build
```

Or use the helper script:
```bash
bash scripts/build.sh
```

### 2. Start the Containers

```bash
docker-compose up -d
```

Or use the helper script:
```bash
bash scripts/run.sh
```

### 3. Access the Ansible Controller

```bash
docker-compose exec ansible bash
```

### 4. Run Playbooks

Inside the container:

#### Run the main playbook (includes all configured tasks)
```bash
ansible-playbook -i inventory/hosts.ini playbooks/main.yaml
```

#### Run specific playbooks
```bash
# Install Vim
ansible-playbook -i inventory/hosts.ini playbooks/install_vim.yml

# Test system information
ansible-playbook -i inventory/hosts.ini playbooks/test_playbook.yml
```

#### Lint playbooks
```bash
# Check syntax and best practices
ansible-lint playbooks/main.yaml
ansible-lint playbooks/install_vim.yml
```

## Container Services

### ansible
- **Role**: Ansible control node
- **User**: ansible
- **Working Directory**: /home/ansible
- **Mounted Volumes**:
  - ./ansible/playbooks → /home/ansible/playbooks
  - ./ansible/inventory → /home/ansible/inventory
  - ./ansible/roles → /home/ansible/roles
  - ~/.ssh → /home/ansible/.ssh (read-only)

### target (optional)
- **Role**: Target host for testing
- **User**: ansible
- **Hostname**: target

## Useful Commands

### View Logs
```bash
docker-compose logs -f ansible
```

### Stop Containers
```bash
docker-compose down
```

### Remove Everything
```bash
docker-compose down -v
```

### Check Container Status
```bash
docker-compose ps
```

## Configuration

### Ansible Settings

- **Host Key Checking**: Disabled (ANSIBLE_HOST_KEY_CHECKING=False)
- **Python Interpreter**: /usr/bin/python3

### SSH Setup (for target connections)

If you need SSH access between containers:

1. Generate SSH keys (if not exists):
```bash
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
```

2. Copy public key to target:
```bash
docker-compose exec target bash
# Inside target container
mkdir -p ~/.ssh
# Paste your public key content
```

## Adding Your Own Playbooks

Place your playbooks in the `ansible/playbooks/` directory. They will be automatically available in the container.

## Available Playbooks

### main.yaml
Main orchestration playbook that includes all configured tasks:
- Gathers system facts
- Includes vim installation tasks
- Displays completion status

Run with:
```bash
ansible-playbook -i inventory/hosts.ini playbooks/main.yaml
```

### install_vim.yml
Installs vim editor on target hosts using zypper (SLES package manager):
- Updates package cache
- Installs vim
- Displays installation status and version

Run with:
```bash
ansible-playbook -i inventory/hosts.ini playbooks/install_vim.yml
```

### test_playbook.yml
Tests Ansible connectivity and gathers system information:
- Displays system facts
- Shows Python version
- Lists home directory contents
- Shows Ansible version

Run with:
```bash
ansible-playbook -i inventory/hosts.ini playbooks/test_playbook.yml
```

## Installed Tools

### Ansible
- **Version**: Latest via pip3
- **Location**: /usr/bin/ansible
- **Configuration**: `/etc/ansible/ansible.cfg`

### ansible-lint
- **Version**: Latest via pip3
- **Usage**: Validates playbook syntax and best practices
- **Command**: `ansible-lint <playbook.yml>`

### System Packages
- Python 3
- OpenSSH (SSH client and server)
- Git
- curl
- wget
- sudo
