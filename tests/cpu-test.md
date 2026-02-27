# CPU Alert Validation Test (First Attempt Experience)

## Objective
Check if HighCPUUsage alert works when CPU goes above 80%.

## What I Did

First I tried:

kubectl run stress --image=busybox -it --rm -- sh

Inside container:

while true; do :; done

## What Went Wrong Initially

- I was checking pod CPU instead of node CPU.
- Alert did not trigger immediately.
- I thought alert was broken.

Then I checked Grafana properly and realized:

- Alert is based on node_cpu_seconds_total
- rate() uses 5m window
- Alert has for: 1m

So total delay ≈ 1–2 minutes.

## Second Attempt

Kept stress running longer.
Monitored node CPU panel instead of pod panel.

## Observed Result

- Alert fired after ~75 seconds.
- Alert appeared in Alertmanager.
- Slack message received.

## What I Learned

- rate() works on time window.
- Alert delay is normal behavior.
- Node metrics ≠ pod metrics.
