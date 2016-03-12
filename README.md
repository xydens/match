<p align="center"><img src="https://raw.githubusercontent.com/pavlovml/match/master/resources/logo.png" alt="logo" width="220" /></p>

<p align="center"><strong>Scalable reverse image search</strong><br /><em>built on <a href="http://kubernetes.io/">Kubernetes</a> and <a href="https://www.elastic.co/">Elasticsearch</a></em></p>

<p align="center"><a href="http://kubernetes.io"><img src="https://img.shields.io/badge/kubernetes-ready-brightgreen.svg?style=flat" alt="Kubernetes shield" /></a></p>

## Installation

    $ docker run -e ELASTICSEARCH_URL=https://daisy.us-west-1.es.amazonaws.com -it pavlov/match

Match is packaged as a Docker container, making it highly portable and scalable to billions of images. You can configure a few options using environment variables:

* **ELASTICSEARCH_URL** *(required)*

  A URL pointing to the Elasticsearch database where image signatures are to be stored. If you don't want to host your own Elasticsearch cluster, consider using [AWS Elasticsearch Service](https://aws.amazon.com/elasticsearch-service/). That's what we use.

* **ELASTICSEARCH_INDEX** *(default: images)*
 
  The index in the Elasticsearch database where image signatures are to be stored.

* **ELASTICSEARCH_DOC_TYPE** *(default: images)*

  The doc type used for storing image signatures.

* **WORKER_COUNT** *(default: 4)*

  The number of gunicorn worker forks to maintain in each Docker container.

### Using in a Kubernetes cluster

Match is particularly awesomesauce when integrated into the Kubernetes container orchestration architecture. You can configure the service and replication controller like so:

```yaml
# match-svc.yaml
apiVersion: v1
kind: Service
metadata:
  namespace: default
  name: match
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
  selector:
    app: match
```

```yaml
# match-rc.yaml
apiVersion: v1
kind: ReplicationController
metadata:
  namespace: default
  name: match
spec:
  replicas: 2
  selector:
    app: match
  template:
    metadata:
      labels:
        app: match
    spec:
      containers:
      - name: match
        image: pavlov/match:latest
        ports:
        - containerPort: 80
        env:
        - name: ELASTICSEARCH_URL
          value: https://daisy.us-west-1.es.amazonaws.com
```

## API

Match has a simple HTTP API. All request parameters are specified via `application/x-www-form-urlencoded` or `multipart/form-data`.

---

### POST `/add`

Adds an image signature to the database.

#### Parameters

* **url** or **image** *(required)*

  The image to add to the database. It may be provided as a URL via `url` or as a `multipart/form-data` file upload via `image`.

* **filepath** *(required)*

  The path to save the image to in the database. If another image already exists at the given path, it will be overwritten.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "add",
  "result": []
}
```

---

### DELETE `/delete`

Deletes an image signature from the database.

#### Parameters

* **filepath** *(required)*

  The path of the image signature in the database.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "delete",
  "result": []
}
```

---

### POST `/search`

Searches for a similar image in the database. Scores range from 0 to 100, with 100 being a perfect match.

#### Parameters

* **url** or **image** *(required)*

  The image to add to the database. It may be provided as a URL via `url` or as a `multipart/form-data` file upload via `image`.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "search",
  "result": [
    {
      "score": 99.0,
      "filepath": "http://static.wixstatic.com/media/0149b5_345c8f862e914a80bcfcc98fcd432e97.jpg_srz_614_709_85_22_0.50_1.20_0.00_jpg_srz"
    }
  ]
}
```

---

### POST `/compare`

Searches for a similar image in the database. Scores range from 0 to 100, with 100 being a perfect match.

#### Parameters

* **url1** or **image1**, **url2** or **image2** *(required)*

  The images to compare. They may be provided as a URL via `url1`/`url2` or as a `multipart/form-data` file upload via `image1`/`image2`.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "compare",
  "result": [
    {
      "score": 99.0
    }
  ]
```

---

### GET `/count`

Count the number of image signatures in the database.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "list",
  "result": [420]
}
```

---

### GET `/list`

Lists the file paths for the image signatures in the database.

#### Parameters

* **offset** *(default: 0)*

  The location in the database to begin listing image paths.

* **limit** *(default: 20)*

  The number of image paths to retrieve.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "list",
  "result": [
    "http://img.youtube.com/vi/iqPqylKy-bY/0.jpg",
    "https://i.ytimg.com/vi/zbjIwBggt2k/hqdefault.jpg",
    "https://s-media-cache-ak0.pinimg.com/736x/3d/67/6d/3d676d3f7f3031c9fd91c10b17d56afe.jpg"
  ]
}
```

---

### GET `/ping`

Check for the health of the server.

#### Example Response

```json
{
  "status": "ok",
  "error": [],
  "method": "ping",
  "result": []
}
```

## Development

    $ export ELASTICSEARCH_URL=https://daisy.us-west-1.es.amazonaws.com
    $ make build
    $ make run
    $ make push

## License and Acknowledgements

Match is based on [ascribe/image-match](https://github.com/ascribe/image-match), which is in turn based on the paper [_An image signature for any kind of image_, Goldberg et al](http://www.cs.cmu.edu/~hcwong/Pdfs/icip02.ps). There is an existing [reference implementation](https://www.pureftpd.org/project/libpuzzle) which may be more suited to your needs.

Match itself is released under the [BSD 3-Clause license](https://github.com/pavlovml/match/blob/master/LICENSE). `ascribe/image-match` is released under the Apache 2.0 license.
