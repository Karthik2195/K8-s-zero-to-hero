# Understanding Pod Lifecycle

## Pod Phases

Kubernetes pods go through several phases during their lifecycle:

- **Pending**: Pod accepted but not yet scheduled
- **Running**: Pod scheduled and running
- **Succeeded**: All containers terminated successfully
- **Failed**: All containers terminated with failure
- **Unknown**: State unknown

## Troubleshooting Pod Phases

### Pending Pods

```bash
kubectl get pods -n <namespace>
kubectl describe pod <pod-name> -n <namespace>
```

Look for:
- Insufficient resources
- Node selector mismatches
- Affinity/anti-affinity rules
- Taints and tolerations

### Running but Unhealthy Pods

Check readiness and liveness probes:

```bash
kubectl describe pod <pod-name> -n <namespace> | grep -A 5 Probes
```

### Failed Pods

Check logs and events:

```bash
kubectl logs <pod-name> -n <namespace> --previous
kubectl get events -n <namespace> --sort-by=.metadata.creationTimestamp
```

## Container States

- **Waiting**: Container waiting to start
- **Running**: Container running
- **Terminated**: Container stopped

## Restart Policies

- **Always**: Restart always (default for most workloads)
- **OnFailure**: Restart only on failure
- **Never**: Never restart

## Best Practices

- Use readiness probes for traffic routing
- Use liveness probes for health checks
- Set appropriate resource limits
- Monitor pod events regularly