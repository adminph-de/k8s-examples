# AzureFiles as persistent storage mount (Static)

## Folder Structure

```bash
├── README.md
├── azf-ps-static-secret.yaml
├── azf-ps-static.yaml
├── commands.sh
└── setup-storrage-account.sh
```

## Usage

### Clone the Repository

```bash
git clone https://github.com/adminph-de/k8s-examples.git
```

### Create the storage account

> Modify Variables:
```bash
AKS_PERS_RESOURCE_GROUP=MyResourceGroup
AKS_PERS_LOCATION=westeurope
AKS_PERS_SHARE_NAME=myshare
```

> Run the script:
```bash
> .create.sh
```

> Script output (example):
```bash
* Storage account name: k8s27459
* Storage account key : 1JIUQD+YB0kJ0Dl2Yq+OiUUc61ZpiTppqgPWtx28CymfFgtIuLkWEe4evK7iv+oP0bhEgz3D1jUPCTOALanc4SQ==
```

### Modfiy *afs-ps-static-secret.yaml* (=Kubernetes Secret)

> Convert Storage Account Name and Key into *base64* string:
```bash
echo -n 'k8s27459' | base64
* OUTPUT: azhzMjc0NTk=
echo -n '1JIUQD+YB0kJ0Dl2Yq+OiUUc61ZpiTppqgPWtx28CymfFgtIuLkWEe4evK7iv+oP0bhEgz3D1jUPCTOALanc4SQ==' | base64
* OUTPUT: MUpJVVFEK1lCMGtKMERsMllxK09pVVVjNjFacGlUcHBxZ1BXdHgyOEN5bWZGZ3RJdUxrV0VlNGV2SzdpditvUDBiaEVnejNEMWpVUENUT0FMYW5jNFNRPT0=
```

>  Insert the Output of the commants (above) into *afs-ps-static-secret.yaml* file:
```bash
data:
  azurestorageaccountname: azhzMjc0NTk=
  azurestorageaccountkey: MUpJVVFEK1lCMGtKMERsMllxK09pVVVjNjFacGlUcHBxZ1BXdHgyOEN5bWZGZ3RJdUxrV0VlNGV2SzdpditvUDBiaEVnejNEMWpVUENUT0FMYW5jNFNRPT0=
```

### Deploy the YAML to your K8s cluster

```bash
> kubectl apply -f afs-ps-static-secret.yaml
```

```bash
> kubectl apply -f azf-ps-static.yaml
```


### Checking the deployment

```bash
> kubectl get all


NAME                               READY   STATUS    RESTARTS   AGE
pod/azfs-ps-dep-859db88c56-t5gw4   1/1     Running   0          106m

NAME                 TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
service/azfs-ps-lb   LoadBalancer   10.0.177.19   52.157.223.218   80:31439/TCP   106m
service/azfs-ps-np   NodePort       10.0.55.62    <none>           80:30803/TCP   106m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/azfs-ps-dep   1/1     1            1           106m

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/azfs-ps-dep-859db88c56   1         1         1       106m
```