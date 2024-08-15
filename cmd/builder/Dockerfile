FROM --platform=$BUILDPLATFORM golang:1.22 AS build
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
ARG BUILDPLATFORM
ARG BUILDOS
ARG BUILDARCH

ENV SUPPORTED_BUILD_PLATFORMS="linux/amd64 linux/arm64 linux/ppc64le darwin/amd64 darwin/arm64"

ENV GOOS=${TARGETOS}
ENV GOARCH=${TARGETARCH}

WORKDIR /app

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM" > ./log

# Download the appropriate OCB binary based on BUILDOS and BUILDARCH
RUN if echo "$SUPPORTED_BUILD_PLATFORMS" | grep -qw "$BUILDPLATFORM"; then \
      OCB_URL="https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv0.107.0/ocb_0.107.0_${BUILDOS}_${BUILDARCH}" && \
      wget -O /app/ocb $OCB_URL && \
      chmod +x /app/ocb; \
    else \
      echo "Unsupported build platform: $BUILDPLATFORM" && \
      exit 1; \
    fi

RUN ls -la /app > ./log
# COPY ./ ./
# TODO: move to downloading pre-compiled binaries based on architecture
#RUN go install -trimpath -ldflags="-s -w" go.opentelemetry.io/collector/cmd/builder@latest

# RUN CGO_ENABLED=0 ./ocb --config=/app/manifest.yaml
ENTRYPOINT ["./ocb"]

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
