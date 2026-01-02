FROM opensuse/leap:15.5

# Install required packages
RUN zypper refresh && \
    zypper install -y \
    python3 \
    python3-pip \
    python3-devel \
    gcc \
    gcc-c++ \
    make \
    openssh \
    openssh-clients \
    git \
    curl \
    wget \
    sudo && \
    zypper clean -a

# Upgrade pip and setuptools for better wheel building
RUN pip3 install --upgrade pip setuptools wheel

# Create ansible user first
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Ansible via pip
RUN pip3 install ansible ansible-lint

# Configure SSH for Ansible
RUN mkdir -p /home/ansible/.ssh && \
    chmod 700 /home/ansible/.ssh && \
    chown -R ansible:ansible /home/ansible/.ssh

# Create directories for Ansible
RUN mkdir -p /etc/ansible && \
    mkdir -p /home/ansible/playbooks && \
    mkdir -p /home/ansible/inventory && \
    chown -R ansible:ansible /home/ansible/playbooks && \
    chown -R ansible:ansible /home/ansible/inventory

# Set working directory
WORKDIR /home/ansible

# Switch to ansible user
USER ansible

CMD ["/bin/bash"]
