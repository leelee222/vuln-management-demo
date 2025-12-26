#!/bin/bash

set -e

echo "🔧 Installing Trivy vulnerability scanner..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux"
    
    wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
    echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
    sudo apt-get update
    sudo apt-get install -y trivy
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew not found. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    brew install trivy
else
    echo "❌ Unsupported OS: $OSTYPE"
    echo "Please install manually: https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    exit 1
fi

echo ""
echo "✅ Trivy installed successfully!"
trivy --version
