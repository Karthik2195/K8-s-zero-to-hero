# Advanced Cluster Debugging

## Control Plane Components

### API Server

Check health:

```bash
kubectl get componentstatuses
```

Logs:

```bash
kubectl logs <api-server-pod> -n kube-system
```

### etcd

Backup and restore critical.

Check health:

```bash
kubectl exec -n kube-system etcd-<node> -- etcdctl cluster-health
```

### Controller Manager

```bash
kubectl logs <controller-manager-pod> -n kube-system
```

### Scheduler

```bash
kubectl logs <scheduler-pod> -n kube-system
```

## Node Issues

### Node Not Ready

```bash
kubectl describe node <node-name>
```

Check:
- Kubelet status
- Network connectivity
- Resource exhaustion

### Kubelet Issues

```bash
systemctl status kubelet
journalctl -u kubelet -f
```

## Certificate Issues

Check certificate expiration:

```bash
kubectl get secrets -n kube-system | grep cert
openssl x509 -in <cert-file> -text -noout | grep "Not After"
```

## RBAC Issues

Check permissions:

```bash
kubectl auth can-i <verb> <resource> --as <user>
```

## Network Debugging

### CNI Plugin Issues

```bash
kubectl get pods -n kube-system | grep cni
kubectl logs <cni-pod> -n kube-system
```

### Service Mesh (if applicable)

Check Istio, Linkerd logs.

## Performance Issues

### API Server Performance

```bash
kubectl top nodes
kubectl top pods -A
```

### etcd Performance

Monitor latency and throughput.

## Cluster Upgrades

- Check compatibility
- Backup etcd
- Upgrade control plane first
- Then worker nodes

## Disaster Recovery

- etcd snapshots
- Backup strategies
- Multi-region setups

## Monitoring and Logging

- Prometheus metrics
- ELK stack for logs
- Alerting rules

## Best Practices

- Regular backups
- Monitor cluster health
- Keep components updated
- Implement proper logging
- Use cluster autoscaling