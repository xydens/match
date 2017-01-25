FROM python:2
MAINTAINER Alex Kern <alex@pavlov.ai>

# deps
RUN apt-get update && \
    apt-get install -y libopenblas-dev gfortran && \
    pip install numpy && \
    pip install scipy && \
    pip install flask gunicorn && \
    pip install image-match==1.1.0

# install
RUN mkdir -p /app
WORKDIR /app
COPY src .

# run
EXPOSE 80
ENV PORT 80
CMD gunicorn -w ${WORKER_COUNT:-4} wsgi:app
