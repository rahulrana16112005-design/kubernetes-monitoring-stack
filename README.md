##  Kubernetes Monitoring Stack 

This project demonstrates a production-style Kubernetes monitoring stack using the kube-prometheus-stack Helm chart.

It includes:

Prometheus for metrics collection

Grafana for visualization

Alertmanager for alert routing

Custom Prometheus alert rules

SLO-based availability monitoring

Dashboard export and validation

Failure simulation testing

Architecture Overview

Metrics Flow:

Kubernetes
→ Prometheus (collects metrics)
→ Alertmanager (processes alerts)
→ Notification channels

Prometheus
→ Grafana (visual dashboards)

Components deployed via Helm:

Prometheus

Alertmanager

Grafana

kube-state-metrics

node-exporter

Project Structure
kubernetes-monitoring-stack/
├── dashboards/
│   └── k8s-cluster-overview.json
├── screenshots/
│   ├── dashboard-overview.png
│   ├── alertmanager-firing.png
│   └── prometheus-alerts.png
├── manifests/
│   └── alerts/
│       ├── cpu-alert.yaml
│       ├── pod-restart-alert.yaml
│       └── pod-down-slo.yaml
├── helm/
│   └── values.yaml
├── scripts/
│   ├── install.sh
│   └── access.sh
├── tests/
│   ├── cpu-test.md
│   ├── pod-down-test.md
│   └── restart-test.md
├── docs/
│   └── architecture.md
└── README.md
Prerequisites

Docker

Minikube

kubectl

Helm

Verify:

docker --version
kubectl version --client
helm version
Installation Steps
1. Start Minikube
minikube start --driver=docker
2. Create Namespace
kubectl create namespace monitoring
3. Add Helm Repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
4. Install Monitoring Stack
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f helm/values.yaml
Accessing Services
Grafana
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80

Open:
http://localhost:3000

Prometheus
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090
Alertmanager
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-alertmanager 9093:9093
Custom Alerts Implemented
High CPU Alert

Triggers when node CPU usage exceeds 80% for more than 1 minute.

Pod Restart Alert

Triggers when a pod restarts more than 3 times within 5 minutes.

SLO-Based PodDown Alert

Triggers when a pod remains not running for more than 2 minutes.

Custom Grafana Dashboard

Dashboard includes:

Total Pods

Running Pods

Critical Alerts

Total Nodes

Node CPU Percentage

Node Memory Percentage

Pod CPU Usage

Pod Restart Count

Active Alerts Table

Dashboard JSON is available in:

dashboards/k8s-cluster-overview.json
Failure Simulation and Validation
CPU Stress Test
kubectl run stress --image=busybox -it --rm -- sh
while true; do :; done

Observed:

CPU spike visible in Grafana

Alert fired when threshold exceeded

Pod Down Simulation
kubectl scale deployment demo-app --replicas=0

Observed:

Running pod count decreased

PodDown alert triggered

Reflected in Alertmanager and dashboard

Restore:

kubectl scale deployment demo-app --replicas=1
Screenshots

Dashboard Overview
screenshots/dashboard-overview.png

Alertmanager (Firing Alert)
screenshots/alertmanager-firing.png

Prometheus Alerts Page
screenshots/prometheus-alerts.png

Repository Practices

Log files excluded via .gitignore

Structured folder hierarchy

Version-controlled dashboard JSON

Documented validation tests

Automated installation script

What This Project Demonstrates

Real-time Kubernetes monitoring

Custom PromQL alert design

SLO-based availability monitoring

Failure simulation and validation

Helm-based deployment workflow

Clean DevOps repository structure

Author

Rahul Rana
DevOps | Kubernetes | Monitoring | Automation
