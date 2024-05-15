FROM docker:26.1.2-alpine3.19
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \ 
    tzdata \
    make \
    git \
    bash \
    tar && \
    git config --global --add safe.directory '*'

ENV TZ=Asia/Shanghai
