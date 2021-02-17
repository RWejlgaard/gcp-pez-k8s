# pez-k8s
Personal GKE kubernetes stack

## Structure
```
.
├── README.md
└── <module name>
    ├── deploy.sh     # deploy script for module
    ├── k8s
    │   ├── ...
    │   └── <any kind of k8s yaml>
    └── src
        ├── ...
        ├── <supporting files/folders for image>
        └── Dockerfile
```
