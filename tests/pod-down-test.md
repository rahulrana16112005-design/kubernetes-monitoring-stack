# PodDown Alert Validation (First-Time Testing)

## Objective
Check if PodDown alert triggers after 2 minutes.

## First Attempt

kubectl delete pod demo-app-xxxxx

Result:
Pod came back immediately.

Alert did NOT fire.

At first I thought alert expression was wrong.

## What I Realized

Deployment controller auto-recreates pods.
So pod was never actually down for 2 minutes.

## Fix I Applied

Scaled deployment to 0:

kubectl scale deployment demo-app --replicas=0

Waited 2+ minutes.

## Observed Result

- PodDown alert fired (severity=critical).
- Alert resolved after scaling back to 1 replica.

## What I Learned

Kubernetes self-healing can prevent alerts from triggering during simple deletes.
Need to control replicas for proper SLO testing.
