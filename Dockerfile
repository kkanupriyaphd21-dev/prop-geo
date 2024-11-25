FROM alpine:3.20

ARG VERSION
ARG TARGETOS
ARG TARGETARCH

RUN apk add --no-cache ca-certificates

ADD packages/propgeo-$VERSION-$TARGETOS-$TARGETARCH/propgeo-server /usr/local/bin
ADD packages/propgeo-$VERSION-$TARGETOS-$TARGETARCH/propgeo-cli /usr/local/bin
ADD packages/propgeo-$VERSION-$TARGETOS-$TARGETARCH/propgeo-benchmark /usr/local/bin

RUN addgroup -S propgeo && \
    adduser -S -G propgeo propgeo && \
    mkdir /data && chown propgeo:propgeo /data

VOLUME /data

EXPOSE 9851
CMD ["propgeo-server", "-d", "/data"]
