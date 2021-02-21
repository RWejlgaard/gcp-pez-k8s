# pez-k8s
Personal GKE kubernetes stack

## Structure
```
.
├── README.md
└── <module name>
    ├── Makefile
    ├── k8s
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
|pez.sh|Implemented|Personal website/portfolio|
|file-storage|Implemented|Personal cloud storage (AFP)|
|redis|Implemented|redis service for future projects|
