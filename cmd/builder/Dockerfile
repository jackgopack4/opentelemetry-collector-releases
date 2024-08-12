ARG GO_VERSION=1.21

FROM golang:${GO_VERSION}-alpine

RUN apk add --no-cache git

ARG OCB_VERSION=0.106.1

WORKDIR /src

RUN git clone --branch cmd/builder/v${OCB_VERSION} https://github.com/open-telemetry/opentelemetry-collector.git

# RUN git checkout tags/cmd/builder/v${OCB_VERSION}
# RUN ls -la ./opentelemetry-collector/cmd/builder
# COPY ./opentelemetry-collector/cmd/builder/go.mod /app/go.mod
# COPY ./opentelemetry-collector/cmd/builder/go.sum /app/go.sum
# COPY ./ ./

RUN GOBIN=/app/ CGO_ENABLED=0 go install -trimpath -ldflags="-s -w" go.opentelemetry.io/collector/cmd/builder@v${OCB_VERSION}

COPY builder-config.yaml /app/builder-config.yaml


ENTRYPOINT ["/app/builder", "--config=/app/builder-config.yaml"]
