# Services and Networking Troubleshooting

## Service Types

- **ClusterIP**: Internal cluster access
- **NodePort**: External access via node ports
- **LoadBalancer**: Cloud provider load balancer
- **ExternalName**: DNS alias

## Checking Services

```bash
kubectl get services -n <namespace>
kubectl describe service <service-name> -n <namespace>
```

## Endpoints

Services connect to pods via endpoints:

```bash
kubectl get endpoints -n <namespace>
```

If endpoints are empty:
- Check pod selectors
- Verify pods are running and ready
- Check service labels match pod labels

## DNS Issues

Kubernetes uses CoreDNS for service discovery:

```bash
kubectl get pods -n kube-system | grep dns
kubectl logs <dns-pod> -n kube-system
```

Test DNS resolution:

```bash
kubectl run test --image=busybox --rm -it -- nslookup <service-name>.<namespace>.svc.cluster.local
```

## Network Policies

If traffic is blocked:

```bash
kubectl get networkpolicies -n <namespace>
```

## Common Networking Issues

- Service not accessible externally
- Pods can't communicate
- DNS resolution failures
- Network policy blocking traffic

### HTTP Errors (502, 500)

For detailed troubleshooting of HTTP errors, see:
- [502 Bad Gateway](../common-errors/502-bad-gateway.md)
- [500 Internal Server Error](../common-errors/500-internal-server-error.md)

- `kubectl port-forward` for testing connectivity
- `kubectl exec` to run network tools inside pods
- Check cluster network plugin (Calico, Flannel, etc.)