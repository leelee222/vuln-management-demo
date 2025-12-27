#!/bin/bash

set -e

echo "🔒 Starting local vulnerability scan..."
echo ""

if ! command -v trivy &> /dev/null; then
    echo "❌ Trivy not found. Installing..."
    echo "Please install Trivy: https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    exit 1
fi

echo "📁 Scanning filesystem dependencies..."
trivy fs ./app --severity CRITICAL,HIGH --format table

echo ""
echo "🐳 Building Docker image..."
cd app
docker build -t vuln-demo:local -f Dockerfile .
cd ..

echo ""
echo "🔍 Scanning Docker image..."
trivy image vuln-demo:local --severity CRITICAL,HIGH --format table

echo ""
echo "✅ Local scan complete!"
echo ""
echo "To view detailed results:"
echo "  trivy fs ./app --format json > scan-results.json"
echo "  trivy image vuln-demo:local --format json > image-results.json"
