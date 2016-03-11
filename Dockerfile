FROM python:2.7
MAINTAINER Alex Kern <alex@pavlovml.com>

# deps
RUN apt-get update && \
    apt-get install -y libopenblas-dev gfortran && \
    pip install numpy && \
    pip install scipy && \
    pip install scikit-image cairosvg elasticsearch flask gunicorn

# install
RUN mkdir -p /app
COPY . /app
RUN pip install /app/python && \
    ln -s /app/bin/pavlov-match /usr/local/bin/pavlov-match

# configure
ENV PORT 80
ENV WORKER_COUNT 4
ENV ELASTICSEARCH_URL https://daisy.us-west-1.es.amazonaws.com

# run
EXPOSE 80
CMD [ "pavlov-match" ]
