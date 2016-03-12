<p align="center"><img src="https://raw.githubusercontent.com/pavlovml/match/master/resources/logo.png" alt="logo" width="220" /></p>

<p align="center">Scalable reverse image search<br /><em>built on <a href="http://kubernetes.io/">Kubernetes</a> and <a href="https://www.elastic.co/">Elasticsearch</a></em></p>

<p align="center"><a href="http://kubernetes.io"><img src="https://img.shields.io/badge/kubernetes-ready-brightgreen.svg?style=flat" alt="Kubernetes shield" /></a></p>

## Installation

**More documentation coming soon...**

    $ make run

## Development

    $ make build
    $ make push

## License and Acknowledgements

Match is based on [ascribe/image-match](https://github.com/ascribe/image-match), which is in turn based on the paper [_An image signature for any kind of image_, Goldberg et al](http://www.cs.cmu.edu/~hcwong/Pdfs/icip02.ps). There is an existing [reference implementation](https://www.pureftpd.org/project/libpuzzle) which may be more suited to your needs.

Match itself is released under the [BSD 3-Clause license](https://github.com/pavlovml/match/blob/master/LICENSE). `ascribe/image-match` is released under the Apache 2.0 license.
