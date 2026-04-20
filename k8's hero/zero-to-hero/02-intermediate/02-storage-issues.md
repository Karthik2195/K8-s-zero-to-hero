# Storage Troubleshooting

## Persistent Volumes and Claims

### Check PVC Status

```bash
kubectl get pvc -n <namespace>
kubectl describe pvc <pvc-name> -n <namespace>
```

PVC states:
- **Pending**: Waiting for PV
- **Bound**: Successfully bound to PV
- **Lost**: PV deleted while in use

### Check PV Status

```bash
kubectl get pv
kubectl describe pv <pv-name>
```

PV states:
- **Available**: Free and available
- **Bound**: Bound to PVC
- **Released**: PVC deleted, PV released
- **Failed**: Automatic provisioning failed

## Storage Classes

```bash
kubectl get storageclasses
kubectl describe storageclass <sc-name>
```

## Common Storage Issues

### PVC Stuck in Pending

- No matching PV available
- Storage class not found
- Insufficient storage capacity
- Access mode mismatch

### Pod Can't Mount Volume

```bash
kubectl describe pod <pod-name> -n <namespace> | grep -A 10 Volumes
```

Check:
- Volume mount paths
- Permissions
- Storage provider issues

### Data Loss

- Check backup strategies
- Verify PV reclaim policy
- Monitor storage health

## Storage Providers

### Local Storage

- Node-specific
- No high availability

### Network Storage (NFS, Ceph)

- Shared across nodes
- Potential network issues

### Cloud Storage

- Provider-specific issues
- Access credentials

## Debugging Commands

```bash
# Check mount points in pod
kubectl exec <pod-name> -n <namespace> -- df -h

# Check volume attachments
kubectl get volumeattachments

# Storage provisioner logs
kubectl logs <provisioner-pod> -n kube-system
```

## Best Practices

- Use appropriate storage classes
- Set proper access modes
- Monitor storage usage
- Implement backup solutions
- Test storage failover scenarios