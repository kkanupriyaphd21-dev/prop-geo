FROM alpine:3.4

ADD ./propgeo-server /usr/local/bin
ADD ./propgeo-cli /usr/local/bin

RUN addgroup -S propgeo && \
    adduser -S -G propgeo propgeo && \
    mkdir /data && chown propgeo:propgeo /data

VOLUME /data

EXPOSE 9851
CMD ["propgeo-server", "-d", "/data"]
