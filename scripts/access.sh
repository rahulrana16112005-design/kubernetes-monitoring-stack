#!/bin/bash

echo "🌐 Forwarding Grafana on http://localhost:3000"
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
