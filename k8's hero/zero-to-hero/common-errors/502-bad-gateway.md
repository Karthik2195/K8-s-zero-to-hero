# Troubleshooting 502 Bad Gateway

## Overview

A 502 Bad Gateway error occurs when a gateway or proxy (like an Ingress controller) receives an invalid response from an upstream server.

## Symptoms

- HTTP 502 status code
- "Bad Gateway" error in browser/logs
- Service appears down

## Common Causes

1. **Backend Service Issues**
   - Backend pods not running
   - Pods not ready
   - Application crashes

2. **Service Configuration**
   - Incorrect service selectors
   - No endpoints available
   - Service port mismatch

3. **Network Problems**
   - Connectivity issues between ingress and service
   - DNS resolution failures
   - Firewall rules

4. **Ingress Controller Issues**
   - Controller pod problems
   - Configuration errors
   - Resource constraints

## Troubleshooting Steps

### 1. Check Backend Pods

```bash
kubectl get pods -n <namespace>
kubectl describe pod <pod-name> -n <namespace>
```

### 2. Verify Service Endpoints

```bash
kubectl get endpoints -n <namespace>
kubectl describe service <service-name> -n <namespace>
```

### 3. Test Service Connectivity

```bash
# Port forward to service
kubectl port-forward svc/<service-name> <local-port>:<service-port> -n <namespace>

# Test locally
curl http://localhost:<local-port>
```

### 4. Check Ingress Controller

```bash
kubectl get pods -n <ingress-namespace>
kubectl logs <ingress-pod> -n <ingress-namespace>
```

### 5. Verify Ingress Configuration

```bash
kubectl get ingress -n <namespace>
kubectl describe ingress <ingress-name> -n <namespace>
```

## Fixes

### For Backend Issues

- Ensure pods are running and healthy
- Check readiness probes
- Scale deployment if needed

### For Service Problems

Verify selectors match:

```bash
kubectl get deployment <deployment-name> -n <namespace> -o yaml | grep labels
kubectl describe service <service-name> -n <namespace>
```

### For Network Issues

- Check network policies
- Verify DNS configuration
- Test pod-to-pod communication

### For Ingress Issues

- Check ingress controller logs
- Verify ingress class
- Update ingress annotations if needed

## Prevention

- Implement proper health checks
- Use readiness probes
- Monitor service endpoints
- Configure proper timeouts
- Use service mesh for observability

## Screenshot

![502 Error](screenshots/502-error.png) (Placeholder - replace with actual screenshot)