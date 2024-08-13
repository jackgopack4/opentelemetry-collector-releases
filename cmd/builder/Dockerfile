ARG GO_VERSION=1.21

FROM golang:${GO_VERSION} AS build

ARG OCB_VERSION=0.107.0

WORKDIR /app

COPY ./manifest.yaml .

RUN go install -trimpath -ldflags="-s -w" go.opentelemetry.io/collector/cmd/builder@v${OCB_VERSION}

RUN CGO_ENABLED=0 builder --config=/app/manifest.yaml

FROM alpine AS certs
RUN apk --update add ca-certificates

FROM scratch

# ARG USER_UID=10001
# USER ${USER_UID}

COPY --from=build --chmod=0755 /app/otelcol-custom /
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY config.yaml /

CMD ["/otelcol-custom", "--config=/config.yaml"]
EXPOSE 4317 55678 55679
