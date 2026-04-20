# Kubernetes Troubleshooting Basics

## Introduction

This section covers the fundamental concepts and commands for troubleshooting Kubernetes clusters.

## Prerequisites

- A running Kubernetes cluster
- kubectl installed and configured

## Basic Commands

### Check cluster status

```bash
kubectl cluster-info
```

### List nodes

```bash
kubectl get nodes
```

### List pods

```bash
kubectl get pods --all-namespaces
```

### Check pod status

```bash
kubectl describe pod <pod-name> -n <namespace>
```

### View logs

```bash
kubectl logs <pod-name> -n <namespace>
```

## Common Issues

### Pod in Pending state

- Check resource availability
- Check node capacity
- Check taints and tolerations

### Pod in CrashLoopBackOff

- Check logs for errors
- Verify environment variables
- Check image availability

For detailed troubleshooting, see [CrashLoopBackOff guide](../common-errors/crashloop-backoff.md)

### Pod in ImagePullBackOff

- Verify image name and tag
- Check registry access
- Check image pull secrets

For detailed troubleshooting, see [ImagePullBackOff guide](../common-errors/image-pull-backoff.md)

## Next Steps

Move to intermediate troubleshooting for more complex scenarios.