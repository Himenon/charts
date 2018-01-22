# helm-node-red

## Install the Chart

```bash
$ helm install --name my-release .
```

## Uninstall the Chart

```bash
$ helm delete --purge my-release
```


# Persistent Volume

## gcePersistentVolume

1. Create Compute Disk

```
$ gcloud compute disks create my-node-red --size 2 --type pd-standard

# Show disks
$ gcloud compute disks list
```

2. Create Persistent Volume by Compute Disk


```yaml
kind: PersistentVolume
apiVersion: v1
metadata:
  name: sample-storage
  labels:
    app: node-red
spec:
  storageClassName: hello-world    # Very Important !!!
  capacity:
    storage: 2Gi
  accessModes:
    - ReadWriteOnce
  gcePersistentDisk:
    fsType: "ext4"
    pdName: "my-node-red"          # GCE Persistent Volume Disk Name
```

3. Set .Values.persistence.storageClass

your `values.yaml`

```yaml
persistence:
  storageClass: "hello-world"
```

4. helm install

```bash
helm install -f values.yaml ./helm-node-red
```


# Author

- [K.Himeno](https://github.com/Himenon)

