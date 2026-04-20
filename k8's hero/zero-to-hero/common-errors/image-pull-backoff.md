# Troubleshooting ImagePullBackOff

## Overview

ImagePullBackOff occurs when Kubernetes cannot pull the container image specified in the pod specification.

## Symptoms

- Pod status shows `ImagePullBackOff` or `ErrImagePull`
- Container fails to start
- Events show image pull failures

## Common Causes

1. **Incorrect Image Name/Tag**
   - Typo in image name
   - Non-existent tag
   - Case sensitivity issues

2. **Registry Access Issues**
   - Private registry without credentials
   - Invalid or expired credentials
   - Network restrictions

3. **Network Problems**
   - DNS resolution failures
   - Firewall blocking registry access
   - Registry server down

4. **Image Not Found**
   - Image deleted from registry
   - Repository permissions changed

## Troubleshooting Steps

### 1. Check Pod Details

```bash
kubectl describe pod <pod-name> -n <namespace>
```

Look for:
- Image name and pull policy
- Image pull events
- Error messages

### 2. Verify Image Exists

```bash
# For public images
docker pull <image-name>:<tag>

# Or check registry
curl -I https://registry-1.docker.io/v2/library/<image>/manifests/<tag>
```

### 3. Check Image Pull Secrets

```bash
kubectl get secrets -n <namespace>
kubectl describe secret <secret-name> -n <namespace>
```

### 4. Test Registry Access

```bash
kubectl run test --image=busybox --rm -it -- wget -O- <registry-url>
```

## Fixes

### For Incorrect Image Name

Update the deployment:

```bash
kubectl edit deployment <deployment-name> -n <namespace>
```

Change the image field to the correct name/tag.

### For Private Registry

Create image pull secret:

```bash
kubectl create secret docker-registry <secret-name> \
  --docker-server=<registry-server> \
  --docker-username=<username> \
  --docker-password=<password> \
  --docker-email=<email> -n <namespace>
```

Add to pod spec:

```yaml
spec:
  imagePullSecrets:
  - name: <secret-name>
```

### For Network Issues

- Check cluster network policies
- Verify DNS configuration
- Test connectivity from node

## Prevention

- Use specific image tags instead of `latest`
- Implement image scanning and validation
- Monitor registry availability
- Use image pull secrets appropriately

## Screenshot

![ImagePullBackOff](screenshots/image-pull-backoff.png) (Placeholder - replace with actual screenshot)