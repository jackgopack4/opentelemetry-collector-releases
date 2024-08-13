ARG GO_VERSION=1.21

FROM golang:${GO_VERSION} AS compiler

ARG OCB_VERSION=0.107.0

WORKDIR /src

COPY ./manifest.yaml /src/manifest.yaml

RUN CGO_ENABLED=0 go install -trimpath -ldflags="-s -w" go.opentelemetry.io/collector/cmd/builder@v${OCB_VERSION}

FROM golang:${GO_VERSION} AS builder

WORKDIR /app

COPY --from=compiler /src/manifest.yaml /app/manifest.yaml
COPY --from=compiler /go/bin/builder /app/builder

#RUN apk add --no-cache libc6-compat gcc

RUN /app/builder --config=/app/manifest.yaml

FROM alpine AS certs
RUN apk --update add ca-certificates

FROM scratch

ARG USER_UID=10001
USER ${USER_UID}

COPY --from=builder --chmod=0755 /tmp/dist/otelcol-custom /otelcol
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY config.yaml /etc/otelcol/config.yaml

ENTRYPOINT ["/otelcol"]
CMD ["--config", "/etc/otelcol/config.yaml"]
EXPOSE 4317 55678 55679
