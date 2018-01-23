# re:dash helm

## Prepare


- re:dash (this repository)
- redis (<https://github.com/kubernetes/charts/tree/master/stable/redis>)
- DataBase
    - GCP SQL Proxy (<https://github.com/kubernetes/charts/tree/master/stable/gcloud-sqlproxy>)
    - postgres (<https://github.com/kubernetes/charts/tree/master/stable/postgresql>)

Value Sample -> [here](https://gist.github.com/Himenon/33608b18dcdc3c39df1d155f1ffd13eb)

## Usage

The following two items are explained.

- GKE + Google Cloud SQL
- GKE + Persistent Volume

These two differences is db of redash (postgres) which host on GC SQL or PV.

### 1. GKE + Google Cloud SQL (postgres)

- Google Cloud SQL: re:dash Database

#### 1-1. Setup Cloud SQL and Service Account

- https://cloud.google.com/sql/docs/

#### 1-2. helm install gcloud-cloudsql

```yaml
# cloudsql-values
image: "gcr.io/cloudsql-docker/gce-proxy"
imageTag: "1.11"
serviceAccountKey: [SA_KEY]
cloudsql:
  instance: [INSTANCE_CONNECTION_NAME]
  port: [DB_PORT]
```

```bash
$ helm install -f cloudsql-values.yaml --name=cloudproxy stable/gcloud-sqlproxy
```

Links

- https://github.com/kubernetes/charts/tree/master/stable/gcloud-sqlproxy

#### 1-3. helm install redash (this repository)

```yaml
# redash-values.yaml
db:
  name: [DB_NAME]
  user: [DB_USER]
  pass: [DB_PASS]
  host: [DB_HOST]
service:
  type: [SERVICE_TYPE]
```

```
$ helm install -f redash-values.yaml himenon/redash
```

**Parameter**

- `[DB_NAME]`: redash using database name
- `[DB_USER]`: redash using database user name
- `[DB_PASS]`: Plain Text
    - However, [template/\_helpers.tpl](/Himenon/redash-helm/blob/master/templates/_helpers.tpl) change base64 text.
    - And use only above value in [template/secret.yaml](/Himenon/redash-helm/blob/master/templates/secret.yaml)
- `[DB_HOST]`: Kubernetes Service Name
    - **Cloud SQL**: Cloud SQL Service Name (Look 1-2).
    - **Persistent Volume**: Postgres Service Name (Look 2-3).
- `[SERVICE_TYPE]`: Kubernetes Service Type
    - https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services---service-types


### 2. GKE + Persistent Volume (postgres)

#### 2-1. helm install postgres

```bash
$ helm install --name redash-db stable/postgresql
```

Links

- https://github.com/kubernetes/charts/tree/master/stable/postgresql

#### 2-2. helm install redash (this repository)

Same: 1-3

### 3 Redis Server

Links

- https://github.com/kubernetes/charts/tree/master/stable/redis

```
$ helm install --name redash-redis stable/redis
```


# Author

- [Himenon](https://github.com/Himenon)


# TODO

- networkpolicy
- NOTES
