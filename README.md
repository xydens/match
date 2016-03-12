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

Match is particularly awesomesauce when integrated into the Kubernetes container orchestration architecture.

**Coming soon...**

## API

**Coming soon...**

## Development

    $ export ELASTICSEARCH_URL=https://daisy.us-west-1.es.amazonaws.com
    $ make build
    $ make run
    $ make push

## License and Acknowledgements

Match is based on [ascribe/image-match](https://github.com/ascribe/image-match), which is in turn based on the paper [_An image signature for any kind of image_, Goldberg et al](http://www.cs.cmu.edu/~hcwong/Pdfs/icip02.ps). There is an existing [reference implementation](https://www.pureftpd.org/project/libpuzzle) which may be more suited to your needs.

Match itself is released under the [BSD 3-Clause license](https://github.com/pavlovml/match/blob/master/LICENSE). `ascribe/image-match` is released under the Apache 2.0 license.
