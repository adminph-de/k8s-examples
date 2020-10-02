# AzureFiles as persistent storage mount (Static)

> This example creates an [Apache2](https://hub.docker.com/_/httpd) POD on your Kubernetes Cluster 
and attaches an Azure StorrageAccount's share (wwwroot) to the POD. 
It demonstrates a persistent volume mount to a static created Azure StorrageAccount. 
Check the [References](#References) at the end of the document for more information.

## Folder Structure

```bash
.
├── LICENSE
├── README.md
├── azf-ps-static-secret.yaml
├── azf-ps-static.yaml
├── create.sh
└── wwwroot
    ├── index.html
    ├── logo.png
    ├── script.js
    └── style.css

```

| FOLDER  | FILE                          | Desctiption                         | 
|:--------|:------------------------------|:------------------------------------|
| .       | **LICENSE**                   | [MIT](https://choosealicense.com/licenses/mit/) license file |
| .       | **README.md**                 | This Readme file                    |
| .       | **azf-ps-static-secret.yaml** | K8s Secret YAML file                |
| .       | **azf-ps-static.yaml**        | k8s Deployment YAML file            |
| .       | **create.sh**                 | Create new Azure Storrage Account   |
| wwwroot | **index.html**                | Examle content for Apache Webserver |
| wwwroot | **logo.png**                  | Examle content for Apache Webserver |
| wwwroot | **script.js**                 | Examle content for Apache Webserver |
| wwwroot | **style.css**                 | Examle content for Apache Webserver |


## Usage

### Clone the Repository

```bash
git clone https://github.com/adminph-de/k8s-examples.git
```

### Create the storage account and upload demo content

> Modify Variables
```bash
AKS_PERS_RESOURCE_GROUP=MyResourceGroup
AKS_PERS_LOCATION=westeurope
```

> Run the script
```bash
> .create.sh
```

> Script output (example)
```bash
* Storage account name: k8s27459
* Storage account key : 1JIUQD+YB0kJ0Dl2Yq+OiUUc61ZpiTppqgPWtx28CymfFgtIuLkWEe4evK7iv+oP0bhEgz3D1jUPCTOALanc4SQ==
```

> Use your prefered way of upload the demo content files
(as example [Azure Storrage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/))
into the *wwwroot* share of the new created StorrageAccount
```bash
.
└── wwwroot
    ├── index.html
    ├── logo.png
    ├── script.js
    └── style.css
```

### Modfiy *afs-ps-static-secret.yaml* (=Kubernetes Secret)

> Convert Storage Account Name and Key into *base64* string
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
***ID-, IPs, etc. will be different from your deployment***

```bash
> kubectl get all
```
> Output:
```bash
NAME                                    READY   STATUS    RESTARTS   AGE
pod/demo-azfs-ps-dep-859db88c56-t5gw4   1/1     Running   0          106m

NAME                      TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
service/demo-azfs-ps-lb   LoadBalancer   10.0.177.19   52.157.223.218   80:31439/TCP   106m
service/demo-azfs-ps-np   NodePort       10.0.55.62    <none>           80:30803/TCP   106m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/demo-azfs-ps-dep   1/1     1            1           106m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/demo-azfs-ps-dep-859db88c56   1         1         1       106m
```

## References

* [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
* [Kubernetes Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/#azure-file)
* [Manually create and use a volume with Azure Files share in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/azure-files-volume)
* [Storage options for applications in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/concepts-storage)