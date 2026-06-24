#!/bin/bash

echo "=== Docker Install Script ==="

if command -v docker &>/dev/null; then
    echo "✅ Docker is already installed."
    docker --version
    exit 0
fi

echo "Docker not found. Installing..."

if command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

elif command -v dnf &>/dev/null; then
    sudo dnf -y install dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

elif command -v yum &>/dev/null; then
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

else
    echo "❌ Could not detect a supported package manager (apt/yum/dnf)."
    exit 1
fi

# Start and enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Add current user to docker group (so you don't need sudo for docker commands)
sudo usermod -aG docker "$USER"

if command -v docker &>/dev/null; then
    echo "✅ Docker installed successfully."
    docker --version
    echo "⚠️  Log out and back in (or run 'newgrp docker') for group changes to take effect."
else
    echo "❌ Docker installation failed."
    exit 1
fi
