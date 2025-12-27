#!/bin/bash

set -e

echo "🔧 Installing Trivy vulnerability scanner..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux"
    
    TRIVY_VERSION=$(curl -s "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
    echo "Installing Trivy version ${TRIVY_VERSION}..."
    
    wget -q https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.deb
    sudo dpkg -i trivy_${TRIVY_VERSION}_Linux-64bit.deb
    rm trivy_${TRIVY_VERSION}_Linux-64bit.deb
    
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Please install Homebrew first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    brew install trivy
else
    echo "Unsupported OS: $OSTYPE"
    echo "Please install manually: https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    exit 1
fi

echo ""
echo "Trivy installed successfully!"
trivy --version
