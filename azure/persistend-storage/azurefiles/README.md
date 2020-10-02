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

```bash
git clone https://github.com/adminph-de/k8s-examples.git
```

```bash
kubectl apply -f afs-ps-static-secret.yaml
```

```bash
kubectl apply -f azf-ps-static.yaml
```
## Result

```bash
kubectl get all
```

NAME                               READY   STATUS    RESTARTS   AGE
pod/azfs-ps-dep-859db88c56-t5gw4   1/1     Running   0          106m

NAME                 TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)        AGE
service/azfs-ps-lb   LoadBalancer   10.0.177.19   52.157.223.218   80:31439/TCP   106m
service/azfs-ps-np   NodePort       10.0.55.62    <none>           80:30803/TCP   106m

NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/azfs-ps-dep   1/1     1            1           106m

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/azfs-ps-dep-859db88c56   1         1         1       106m