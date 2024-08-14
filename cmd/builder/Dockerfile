FROM golang:1.21 AS build

WORKDIR /app

COPY ${BUILDER_CONFIG_FILE} ./manifest.yaml
# TODO: move to downloading pre-compiled binaries based on architecture
RUN go install -trimpath -ldflags="-s -w" go.opentelemetry.io/collector/cmd/builder@latest

RUN CGO_ENABLED=0 builder --config=/app/manifest.yaml
ENTRYPOINT "/builder"

# FROM alpine AS certs
# RUN apk --update add ca-certificates

# FROM scratch
# ARG COLLECTOR_CONFIG_FILE="./config.yaml"

# ARG USER_UID=10001
# USER ${USER_UID}

# COPY --from=build --chmod=0755 /app/otelcol-custom /
# COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# COPY ${COLLECTOR_CONFIG_FILE} /

# CMD ["/otelcol-custom", "--config=/config.yaml"]
# EXPOSE 4317 55678 55679
