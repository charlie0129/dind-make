ARG BASE_IMAGE
FROM $BASE_IMAGE

RUN apk add --no-cache \ 
    tzdata \
    make \
    git \
    bash \
    tar \
    curl && \
    git config --global --add safe.directory '*' && \
    git config --global credential.helper store

ENV TZ=Asia/Shanghai
