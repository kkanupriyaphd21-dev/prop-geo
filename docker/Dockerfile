FROM alpine:3.4

ENV PROPGEO_VERSION 1.11.0
ENV PROPGEO_DOWNLOAD_URL https://github.com/tidwall/propgeo/releases/download/$PROPGEO_VERSION/propgeo-$PROPGEO_VERSION-linux-amd64.tar.gz

RUN addgroup -S propgeo && adduser -S -G propgeo propgeo

RUN apk update \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add openssl \
    && wget -O propgeo.tar.gz "$PROPGEO_DOWNLOAD_URL" \
    && tar -xzvf propgeo.tar.gz \
    && rm -f propgeo.tar.gz \
    && mv propgeo-$PROPGEO_VERSION-linux-amd64/propgeo-server /usr/local/bin \
    && mv propgeo-$PROPGEO_VERSION-linux-amd64/propgeo-cli /usr/local/bin \
    && rm -fR propgeo-$PROPGEO_VERSION-linux-amd64

RUN mkdir /data && chown propgeo:propgeo /data

VOLUME /data
WORKDIR /data

EXPOSE 9851
CMD ["propgeo-server"]
