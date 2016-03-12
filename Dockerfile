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
COPY python/* /app
RUN pip install /app/python && \
    ln -s /app/bin/pavlov-match /usr/local/bin/pavlov-match

# run
ENV PORT 80
EXPOSE 80
WORKDIR /app
CMD gunicorn -w ${WORKER_COUNT:-4} server:app
