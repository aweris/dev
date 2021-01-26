# dev
Personal development environment

## How to use

```shell
Usage:
  make <target>

Targets:
  help                    shows this help message
  k3d_list                list cluster(s)
  k3d_create              create a new cluster
  k3d_delete              delete cluster
  k3d_start               start existing k3d cluster
  k3d_stop                stop existing k3d cluster
```

## Services

- http://traefik.k3d.localhost/dashboard/
- http://argocd.k3d.localhost/ , username=admin, password=admin

### ArgoCD cli cheatsheet

- login

```shell
argocd login localhost:9999 --insecure --username admin --password admin --plaintext
```

- add a repository using local ssh private key 

```shell
argocd repo add ssh://git@git.example.com:2222/repos/repo --ssh-private-key-path  ~/.ssh/id_rsa
```
