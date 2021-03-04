# pez-k8s
Personal GKE kubernetes stack

## Structure
```
.
├── README.md
├── skaffold.yml
└── <module name>
    ├── manifests
    │   ├── ...
    │   └── <any kind of k8s yaml>
    └── src
        ├── ...
        ├── <supporting files/folders for image>
        └── Dockerfile
```

## Modules
|Module|Status|Description|
|---|---|---|
|`pez.sh`|Implemented|Personal website/portfolio|
|`file-storage`|Implemented|Personal cloud storage (AFP)|
|`redis`|Implemented|redis service for future projects|
|`cloudprober`|Implemented|Provide uptime monitoring for pez.sh|
|`grafana`|Implemented|Grafana stuff|
|`prometheus`|Implemented|Prometheus|
|`service-mesh`|Implemented|Istio control plane, gateway on pez.sh pointing to various virtual-services|