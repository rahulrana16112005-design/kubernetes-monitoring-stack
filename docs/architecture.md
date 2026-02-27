# Architecture Overview

Kubernetes cluster is monitored using kube-prometheus-stack.

Metrics Flow:
Kubernetes → Prometheus → Alertmanager → Slack
                         ↓
                      Grafana

Custom alerts:
- CPU threshold alert
- Pod restart alert
- SLO-based PodDown alert
