#!/bin/bash

set -e

echo "🚀 Creating namespace (if not exists)..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "📦 Adding Helm repo..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 2>/dev/null || true
helm repo update

echo "⚙️ Installing / Upgrading kube-prometheus-stack..."
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f helm/values.yaml

echo "📊 Applying custom alert rules..."
kubectl apply -f manifests/

echo "✅ Monitoring stack deployed successfully!"
