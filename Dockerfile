FROM alpine:latest

RUN apk --no-cache add git curl vim bash openssh tig

RUN mkdir /workspace

ADD go.sh /go.sh

ADD known_hosts /root/.ssh/known_hosts

WORKDIR /workspace


#ENTRYPOINT /go.sh
