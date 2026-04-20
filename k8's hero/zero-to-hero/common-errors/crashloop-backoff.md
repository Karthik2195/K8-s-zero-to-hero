# Troubleshooting CrashLoopBackOff

## Overview

CrashLoopBackOff indicates that a container is repeatedly crashing and being restarted by Kubernetes. The system backs off the restart attempts to prevent overwhelming the cluster.

## Symptoms

- Pod status shows `CrashLoopBackOff`
- Container restarts frequently
- Application unavailable

## Common Causes

1. **Application Errors**
   - Code bugs causing crashes
   - Missing dependencies
   - Configuration errors

2. **Resource Issues**
   - Insufficient memory/CPU
   - OOM (Out of Memory) kills
   - Resource limits too low

3. **Health Check Failures**
   - Liveness probe failing
   - Readiness probe issues
   - Incorrect probe configuration

4. **Environment Problems**
   - Missing environment variables
   - Incorrect secrets/configmaps
   - Volume mount issues

## Troubleshooting Steps

### 1. Check Pod Logs

```bash
# Current logs
kubectl logs <pod-name> -n <namespace>

# Previous container logs
kubectl logs <pod-name> -n <namespace> --previous
```

### 2. Describe Pod

```bash
kubectl describe pod <pod-name> -n <namespace>
```

Look for:
- Container exit codes
- Restart count
- Last state and reason
- Events

### 3. Check Resource Usage

```bash
kubectl top pods -n <namespace>
kubectl describe pod <pod-name> -n <namespace> | grep -A 5 "Containers"
```

### 4. Verify Configuration

```bash
kubectl get configmap,secret -n <namespace>
kubectl describe configmap <configmap-name> -n <namespace>
```

## Fixes

### For Application Errors

- Fix code bugs
- Add missing dependencies
- Correct configuration

### For Resource Issues

Increase resource limits:

```yaml
resources:
  limits:
    memory: "512Mi"
    cpu: "500m"
  requests:
    memory: "256Mi"
    cpu: "250m"
```

### For Health Probes

Adjust probe settings:

```yaml
livenessProbe:
  httpGet:
    path: /health
    port: 8080
  initialDelaySeconds: 30
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 3
```

### For Environment Issues

- Add missing environment variables
- Mount correct volumes
- Verify secret data

## Prevention

- Implement proper error handling
- Set appropriate resource limits
- Configure health checks correctly
- Use init containers for setup
- Monitor application logs

## Screenshot

![CrashLoopBackOff](screenshots/crashloop-backoff.png) (Placeholder - replace with actual screenshot)