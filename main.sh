#!/bin/bash

set -e

echo "==============================="
echo " Updating system packages"
echo "==============================="
sudo apt update && sudo apt upgrade -y

echo "==============================="
echo " Installing Docker"
echo "==============================="
sudo apt install docker.io -y

echo "==============================="
echo " Enabling + Starting Docker"
echo "==============================="
sudo systemctl enable docker
sudo systemctl start docker

echo "==============================="
echo " Docker Service Status"
echo "==============================="
sudo systemctl status docker --no-pager

echo "==============================="
echo " Adding ubuntu user to docker group"
echo "==============================="
sudo usermod -aG docker ubuntu

echo "==============================="
echo " Installing stress tool"
echo "==============================="
sudo apt install stress -y

CPU_COUNT=$(nproc)

echo "==============================="
echo " CPU cores detected: $CPU_COUNT"
echo "==============================="

echo ""
echo "Docker install complete."
echo "NOTE: Logout/login or reboot is required for docker group changes to apply."
echo ""

read -p "Type 'run stress' to start stress test (or anything else to exit): " INPUT

if [[ "$INPUT" == "run stress" ]]; then
    echo "==============================="
    echo " Running stress test using $CPU_COUNT CPUs for 300 seconds"
    echo "==============================="
    stress --cpu "$CPU_COUNT" --timeout 300
    echo "Stress test finished."
else
    echo "Skipping stress test. Exiting."
fi
