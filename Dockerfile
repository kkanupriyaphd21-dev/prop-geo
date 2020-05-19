FROM golang:1.13 as builder

# Copy local code to the container image.
WORKDIR /propgeo
COPY . .
COPY ./cmd/propgeo-server/main.go .

# Build the command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN CGO_ENABLED=0 GOOS=linux go build -v -o propgeo-server

FROM alpine:3.8
RUN apk add --no-cache ca-certificates

COPY --from=builder /propgeo/propgeo-server /usr/local/bin/propgeo-server
#ADD propgeo-cli /usr/local/bin
#ADD propgeo-benchmark /usr/local/bin

RUN addgroup -S propgeo && \
    adduser -S -G propgeo propgeo && \
    mkdir /data && chown propgeo:propgeo /data

VOLUME /data

EXPOSE 9851
CMD ["propgeo-server", "-d", "/data"]
