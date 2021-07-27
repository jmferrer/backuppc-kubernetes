# BackupPC

[BackupPC](https://backuppc.github.io/backuppc/) is a high-performance, enterprise-grade system for backing up Linux, Windows and macOS PCs and laptops to a server's disk. BackupPC is highly configurable and easy to install and maintain.

## TL;DR

```console
$ helm repo add fermosit https://harbor.fermosit.es/chartrepo/library
$ helm install my-release fermosit/backuppc
```

## Introduction

This chart bootstraps a [BackupPC](https://hub.docker.com/r/adferrand/backuppc) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

This chart is based on another awesome chart by bitnami.

## Prerequisites

- Kubernetes 1.12+
- Helm 3.1.0
- PV provisioner support in the underlying infrastructure
- ReadWriteOnce volumes

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release fermosit/backuppc
```

The command deploys BackupPC on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Common parameters

| Name                | Description                                        | Value           |
| ------------------- | -------------------------------------------------- | --------------- |
| `kubeVersion`       | Override Kubernetes version                        | `nil`           |
| `nameOverride`      | String to partially override common.names.fullname | `nil`           |
| `fullnameOverride`  | String to fully override common.names.fullname     | `nil`           |
| `commonLabels`      | Labels to add to all deployed objects              | `{}`            |
| `commonAnnotations` | Annotations to add to all deployed objects         | `{}`            |
| `clusterDomain`     | Kubernetes cluster domain name                     | `cluster.local` |
| `extraDeploy`       | Array of extra objects to deploy with the release  | `[]`            |

### BackupPC Image parameters

| Name                | Description                                          | Value                 |
| ------------------- | ---------------------------------------------------- | --------------------- |
| `image.registry`    | WordPress image registry                             | `docker.io`           |
| `image.repository`  | WordPress image repository                           | `adferrand/backuppc`   |
| `image.tag`         | WordPress image tag (immutable tags are recommended) | `4.4.0` |
| `image.pullPolicy`  | WordPress image pull policy                          | `IfNotPresent`        |
| `image.pullSecrets` | WordPress image pull secrets                         | `[]`                  |
| `image.debug`       | Enable image debug mode                              | `false`               |

### BackupPC Configuration parameters

| Name                                   | Description                                                                               | Value              |
| -------------------------------------- | ----------------------------------------------------------------------------------------- | ------------------ |
| `backuppcUuid`                         | BackupPC proccess UUID                                                                    | `1000`             |
| `backuppcGuid`                         | BackupPC proccess UUID                                                                    | `1000`             |
| `backuppcWebUser`                      | BackupPC Web Username                                                                     | `backuppc`         |
| `backuppcWebPasswd`                    | BackupPC Web Password                                                                     | `password`         |
| `tz`                                   | Timezone                                                                                  | `Europe/Paris`     |
| `backuppcScheme`                       | Container http scheme                                                                     | `http`             |
| `smtpHost`                             | SMTP server host                                                                          | `""`               |
| `smtpMailDomain`                       | SMTP server mail domain                                                                   | `""`               |


The above parameters map to the env variables defined in docker image [environment vars](https://hub.docker.com/r/adferrand/backuppc). For more information please refer to the [docker image](https://hub.docker.com/r/adferrand/backuppc) documentation.

### WordPress deployment parameters

| Name                                    | Description                                                                               | Value           |
| --------------------------------------- | ----------------------------------------------------------------------------------------- | --------------- |
| `schedulerName`                         | Alternate scheduler                                                                       | `nil`           |
| `serviceAccountName`                    | ServiceAccount name                                                                       | `default`       |
| `hostAliases`                           | *BackupPC pod host aliases                                                                | `[]`            |
| `extraVolumes`                          | Optionally specify extra list of additional volumes for WordPress pods                    | `[]`            |
| `extraVolumeMounts`                     | Optionally specify extra list of additional volumeMounts for WordPress container(s)       | `[]`            |
| `sidecars`                              | Add additional sidecar containers to the WordPress pod                                    | `{}`            |
| `initContainers`                        | Add additional init containers to the WordPress pods                                      | `{}`            |
| `podLabels`                             | Extra labels for WordPress pods                                                           | `{}`            |
| `podAnnotations`                        | Annotations for WordPress pods                                                            | `{}`            |
| `podAffinityPreset`                     | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`       | `""`            |
| `podAntiAffinityPreset`                 | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`  | `soft`          |
| `nodeAffinityPreset.type`               | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard` | `""`            |
| `nodeAffinityPreset.key`                | Node label key to match. Ignored if `affinity` is set                                     | `""`            |
| `nodeAffinityPreset.values`             | Node label values to match. Ignored if `affinity` is set                                  | `[]`            |
| `affinity`                              | Affinity for pod assignment                                                               | `{}`            |
| `nodeSelector`                          | Node labels for pod assignment                                                            | `{}`            |
| `tolerations`                           | Tolerations for pod assignment                                                            | `[]`            |
| `resources.limits`                      | The resources limits for the WordPress container                                          | `{}`            |
| `resources.requests`                    | The requested resources for the WordPress container                                       | `{}`            |
| `containerPorts.http`                   | WordPress HTTP container port                                                             | `8080`          |
| `containerPorts.https`                  | WordPress HTTPS container port                                                            | `8443`          |
| `podSecurityContext.enabled`            | Enabled WordPress pods' Security Context                                                  | `true`          |
| `podSecurityContext.fsGroup`            | Set WordPress pod's Security Context fsGroup                                              | `1001`          |
| `containerSecurityContext.enabled`      | Enabled WordPress containers' Security Context                                            | `true`          |
| `containerSecurityContext.runAsUser`    | Set WordPress container's Security Context runAsUser                                      | `1001`          |
| `containerSecurityContext.runAsNonRoot` | Set WordPress container's Security Context runAsNonRoot                                   | `true`          |
| `livenessProbe.enabled`                 | Enable livenessProbe                                                                      | `true`          |
| `livenessProbe.initialDelaySeconds`     | Initial delay seconds for livenessProbe                                                   | `120`           |
| `livenessProbe.periodSeconds`           | Period seconds for livenessProbe                                                          | `10`            |
| `livenessProbe.timeoutSeconds`          | Timeout seconds for livenessProbe                                                         | `5`             |
| `livenessProbe.failureThreshold`        | Failure threshold for livenessProbe                                                       | `6`             |
| `livenessProbe.successThreshold`        | Success threshold for livenessProbe                                                       | `1`             |
| `readinessProbe.enabled`                | Enable readinessProbe                                                                     | `true`          |
| `readinessProbe.initialDelaySeconds`    | Initial delay seconds for readinessProbe                                                  | `30`            |
| `readinessProbe.periodSeconds`          | Period seconds for readinessProbe                                                         | `10`            |
| `readinessProbe.timeoutSeconds`         | Timeout seconds for readinessProbe                                                        | `5`             |
| `readinessProbe.failureThreshold`       | Failure threshold for readinessProbe                                                      | `6`             |
| `readinessProbe.successThreshold`       | Success threshold for readinessProbe                                                      | `1`             |
| `customLivenessProbe`                   | Custom livenessProbe that overrides the default one                                       | `{}`            |
| `customReadinessProbe`                  | Custom readinessProbe that overrides the default one                                      | `{}`            |

### Traffic Exposure Parameters

| Name                               | Description                                                                                           | Value                    |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------- | ------------------------ |
| `service.type`                     | WordPress service type                                                                                | `LoadBalancer`           |
| `service.port`                     | WordPress service HTTP port                                                                           | `80`                     |
| `service.httpsPort`                | WordPress service HTTPS port                                                                          | `443`                    |
| `service.httpsTargetPort`          | Target port for HTTPS                                                                                 | `https`                  |
| `service.nodePorts.http`           | Node port for HTTP                                                                                    | `nil`                    |
| `service.nodePorts.https`          | Node port for HTTPS                                                                                   | `nil`                    |
| `service.clusterIP`                | WordPress service Cluster IP                                                                          | `nil`                    |
| `service.loadBalancerIP`           | WordPress service Load Balancer IP                                                                    | `nil`                    |
| `service.loadBalancerSourceRanges` | WordPress service Load Balancer sources                                                               | `[]`                     |
| `service.externalTrafficPolicy`    | WordPress service external traffic policy                                                             | `Cluster`                |
| `service.annotations`              | Additional custom annotations for WordPress service                                                   | `{}`                     |
| `service.extraPorts`               | Extra port to expose on WordPress service                                                             | `[]`                     |
| `ingress.enabled`                  | Enable ingress record generation for WordPress                                                        | `false`                  |
| `ingress.certManager`              | Add the corresponding annotations for cert-manager integration                                        | `false`                  |
| `ingress.pathType`                 | Ingress path type                                                                                     | `ImplementationSpecific` |
| `ingress.apiVersion`               | Force Ingress API version (automatically detected if not set)                                         | `nil`                    |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                         | `nil`                    |
| `ingress.hostname`                 | Default host for the ingress record                                                                   | `wordpress.local`        |
| `ingress.path`                     | Default path for the ingress record                                                                   | `/`                      |
| `ingress.annotations`              | Additional custom annotations for the ingress record                                                  | `{}`                     |
| `ingress.tls`                      | Enable TLS configuration for the host defined at `ingress.hostname` parameter                         | `false`                  |
| `ingress.extraHosts`               | An array with additional hostname(s) to be covered with the ingress record                            | `[]`                     |
| `ingress.extraPaths`               | An array with additional arbitrary paths that may need to be added to the ingress under the main host | `[]`                     |
| `ingress.extraTls`                 | TLS configuration for additional hostname(s) to be covered with this ingress record                   | `[]`                     |
| `ingress.secrets`                  | Custom TLS certificates as secrets                                                                    | `[]`                     |

### Persistence Parameters

| Name                                          | Description                                                                                     | Value                   |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------- | ----------------------- |
| `persistence.enabled`                         | Enable persistence using Persistent Volume Claims                                               | `true`                  |
| `persistence.storageClass`                    | Persistent Volume storage class                                                                 | `nil`                   |
| `persistence.accessModes`                     | Persistent Volume access modes                                                                  | `[ReadWriteOnce]`       |
| `persistence.accessMode`                      | Persistent Volume access mode (DEPRECATED: use `persistence.accessModes` instead)               | `ReadWriteOnce`         |
| `persistence.size`                            | Persistent Volume size                                                                          | `10Gi`                  |
| `persistence.dataSource`                      | Custom PVC data source                                                                          | `{}`                    |
| `persistence.existingClaim`                   | The name of an existing PVC to use for persistence                                              | `nil`                   |
| `volumePermissions.enabled`                   | Enable init container that changes the owner/group of the PV mount point to `runAsUser:fsGroup` | `true`                  |
| `volumePermissions.image.registry`            | Bitnami Shell image registry                                                                    | `docker.io`             |
| `volumePermissions.image.repository`          | Bitnami Shell image repository                                                                  | `bitnami/bitnami-shell` |
| `volumePermissions.image.tag`                 | Bitnami Shell image tag (immutable tags are recommended)                                        | `10`                    |
| `volumePermissions.image.pullPolicy`          | Bitnami Shell image pull policy                                                                 | `Always`                |
| `volumePermissions.image.pullSecrets`         | Bitnami Shell image pull secrets                                                                | `[]`                    |
| `volumePermissions.resources.limits`          | The resources limits for the init container                                                     | `{}`                    |
| `volumePermissions.resources.requests`        | The requested resources for the init container                                                  | `{}`                    |
| `volumePermissions.securityContext.runAsUser` | Set init container's Security Context runAsUser                                                 | `0`                     |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install my-release \
  --set backuppcWebUser=backuppc \
  --set backuppcWebPasswd=password \
  --set ingress.enabled=true \
  --set ingress.hostname=backuppc.127-0-0-1.nip.io \
  fermosit/backuppc
```

The above command sets the BackupPC administrator account username and password to `backuppc` and `password` respectively. Additionally, it creates a ingress to access app through http://backuppc.127-0-0-1.nip.io .

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml fermosit/backuppc
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling VS Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

### Ingress

This chart provides support for Ingress resources. If an Ingress controller, such as [nginx-ingress](https://kubeapps.com/charts/stable/nginx-ingress) or [traefik](https://kubeapps.com/charts/stable/traefik), that Ingress controller can be used to serve WordPress.

To enable Ingress integration, set `ingress.enabled` to `true`. The `ingress.hostname` property can be used to set the host name. The `ingress.tls` parameter can be used to add the TLS configuration for this host. It is also possible to have more than one host, with a separate TLS configuration for each host.

### TLS secrets

The chart also facilitates the creation of TLS secrets for use with the Ingress controller, with different options for certificate management.

## Persistence

The [BackupPC image](https://hub.docker.com/r/adferrand/backuppc) image stores the BackupPC data and configurations at the `/etc/backuppc`, `/home/backuppc` and `/data/backuppc` paths of the container. Persistent Volume Claim is used to keep the data across deployments.

If you encounter errors when working with persistent volumes, refer to our [troubleshooting guide for persistent volumes](https://docs.bitnami.com/kubernetes/faq/troubleshooting/troubleshooting-persistence-volumes/).

### Additional environment variables

In case you want to add extra environment variables (useful for advanced operations like custom init scripts), you can use the `extraEnvVars` property.

```yaml
backuppc:
  extraEnvVars:
    - name: LOG_LEVEL
      value: error
```

Alternatively, you can use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

### Sidecars

If additional containers are needed in the same pod as WordPress (such as additional metrics or logging exporters), they can be defined using the `sidecars` parameter. If these sidecars export extra ports, extra port definitions can be added using the `service.extraPorts` parameter. [Learn more about configuring and using sidecar containers](https://docs.bitnami.com/kubernetes/apps/wordpress/configuration/configure-sidecar-init-containers/).

### Pod affinity

This chart allows you to set your custom affinity using the `affinity` parameter. Find more information about Pod affinity in the [kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, use one of the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/master/bitnami/common#affinities) chart. To do so, set the `podAffinityPreset`, `podAntiAffinityPreset`, or `nodeAffinityPreset` parameters.
