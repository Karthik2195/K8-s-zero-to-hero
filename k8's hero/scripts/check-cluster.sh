#!/bin/bash

# Kubernetes Cluster Health Check Script
# Created by: Karthik Reddy Vadde
# This script performs basic health checks on a Kubernetes cluster
# Run with --help for usage information

if [ "$1" == "--help" ]; then
    echo "Kubernetes Cluster Health Check Script"
    echo "Usage: $0 [--help]"
    echo ""
    echo "This script runs various kubectl commands to check cluster health."
    echo "Review the output for any issues and refer to the troubleshooting guides."
    echo ""
    echo "Common issues and fixes:"
    echo "- Nodes NotReady: Check kubelet status, network, resources"
    echo "- Pods CrashLoopBackOff: Check logs, resources, image issues"
    echo "- ImagePullBackOff: Verify image name, registry access"
    echo "- Pending PVCs: Check storage classes, available PVs"
    echo "- 502/500 errors: Check backend pods, service endpoints"
    echo ""
    echo "For detailed troubleshooting, see the zero-to-hero/common-errors/ guides."
    exit 0
fi

echo "=== Kubernetes Cluster Health Check ==="
echo

# Check cluster info
# This verifies the cluster is accessible and shows API server endpoints
# If this fails: Cause - kubectl not configured or cluster unreachable
# Fix: Run 'kubectl config view' and check kubeconfig, or check cluster status
echo "Cluster Info:"
kubectl cluster-info
echo

# Check nodes
# Shows node status (Ready/NotReady)
# Issues: NotReady nodes
# Causes: Kubelet down, network issues, resource exhaustion
# Fixes: Check systemctl status kubelet, journalctl -u kubelet, free resources
echo "Nodes:"
kubectl get nodes
echo

# Check pods in all namespaces
# Shows pod status across all namespaces
# Issues: CrashLoopBackOff, Pending, ImagePullBackOff, etc.
# Causes: See specific pod troubleshooting guides
# Fixes: Describe pod, check logs, verify resources/images
echo "Pod Status (all namespaces):"
kubectl get pods --all-namespaces
echo

# Check component statuses
# Shows health of control plane components
# Issues: Unhealthy components
# Causes: etcd issues, API server problems, scheduler failures
# Fixes: Check component logs in kube-system namespace
echo "Component Statuses:"
kubectl get componentstatuses
echo

# Check events
# Recent cluster events, sorted by time
# Look for warnings/errors
# Causes: Various operational issues
# Fixes: Investigate specific events with kubectl describe
echo "Recent Events:"
kubectl get events --sort-by=.metadata.creationTimestamp | tail -20
echo

# Check resource usage
# Shows CPU/memory usage on nodes
# Issues: High usage
# Causes: Resource-intensive workloads, leaks
# Fixes: Scale pods, optimize applications, add resources
echo "Node Resource Usage:"
kubectl top nodes
echo

echo "Pod Resource Usage:"
kubectl top pods --all-namespaces
echo

# Check storage
# Persistent Volumes status
# Issues: Failed PVs
# Causes: Storage provider issues, configuration
# Fixes: Check storage class, provider logs
echo "Persistent Volumes:"
kubectl get pv
echo

# Persistent Volume Claims
# PVC status (Bound/Pending)
# Issues: Pending PVCs
# Causes: No matching PV, storage class issues
# Fixes: Create PVs, check storage classes
echo "Persistent Volume Claims:"
kubectl get pvc --all-namespaces
echo

# Check services
# Service status
# Issues: Services without endpoints
# Causes: No matching pods, selector issues
# Fixes: Check pod labels, service selectors
echo "Services:"
kubectl get services --all-namespaces
echo

echo "=== Check Complete ==="
echo "Review output above. For issues, see troubleshooting guides in zero-to-hero/common-errors/"