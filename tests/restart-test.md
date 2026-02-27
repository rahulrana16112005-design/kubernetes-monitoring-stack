# Pod Restart Alert Validation

## Objective
Validate restart alert when restarts >3 in 5 minutes.

## Initial Mistake

I assumed restarting pod 3 times manually would trigger alert immediately.

It did not.

## Why It Didn't Work

increase(kube_pod_container_status_restarts_total[5m]) depends on time window.

Restarts must happen inside 5-minute window.

## Second Attempt

Triggered rapid crash loop by breaking container command.

Observed restart count increasing quickly.

## Final Result

- Alert triggered after threshold crossed.
- Alert resolved once pod stabilized.

## What I Learned

increase() function measures change over time.
Threshold alerts depend on timing, not just count.
