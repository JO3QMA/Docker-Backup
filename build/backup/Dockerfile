FROM debian:latest
LABEL maintainer="gumi@jo3qma.com"
ENV TZ=Asia/Tokyo
RUN apt update && apt install -y --no-install-recommends \
      rsync \
      tar \
      gzip && \
      apt clean && \
      rm -rf /var/lib/apt/lists/*
COPY --chmod=755 ./*sh /usr/local/bin/
VOLUME /data
SHELL ["/bin/bash", "-c"]
ENTRYPOINT ["/usr/local/bin/backup.sh"]