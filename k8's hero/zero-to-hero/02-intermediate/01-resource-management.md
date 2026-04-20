# Resource Management and Limits

## Resource Types

- **CPU**: Measured in cores or millicores
- **Memory**: Measured in bytes (Mi, Gi)
- **Storage**: Persistent volumes

## Setting Resource Requests and Limits

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
spec:
  containers:
  - name: app
    image: nginx
    resources:
      requests:
        memory: "64Mi"
        cpu: "250m"
      limits:
        memory: "128Mi"
        cpu: "500m"
```

## Troubleshooting Resource Issues

### OOM Killed

```bash
kubectl get pods -n <namespace>
kubectl describe pod <pod-name> -n <namespace> | grep -A 10 "Containers"
```

Look for:
- OOMKilled in last state
- Memory limits too low
- Memory leaks in application

### CPU Throttling

```bash
kubectl top pods -n <namespace>
```

Check CPU usage vs limits.

### Insufficient Resources

```bash
kubectl describe nodes
```

Check allocatable resources.

## Quality of Service Classes

- **Guaranteed**: requests = limits
- **Burstable**: requests < limits
- **BestEffort**: no requests/limits

## Resource Quotas

```bash
kubectl get resourcequotas -n <namespace>
kubectl describe resourcequota <quota-name> -n <namespace>
```

## Limit Ranges

```bash
kubectl get limitranges -n <namespace>
```

## Best Practices

- Set appropriate requests and limits
- Monitor resource usage
- Use Horizontal Pod Autoscaler for scaling
- Implement resource quotas per namespace