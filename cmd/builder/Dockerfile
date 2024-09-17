# run with sample command:
# docker run -v $(pwd)/builder-config.yaml:/etc/otelcol-dev/builder-config.yaml -v $(pwd)/output:/build/otelcol-dev \
#   -e GOOS=darwin -e GOARCH=arm64 opentelemetry-collector-builder
FROM golang:1.23 AS build

WORKDIR /build

# Set build-time arguments
ARG OTELCOL_BUILDER_VERSION="0.109.0"
ARG OTELCOL_BUILDER_DIR="/build/bin"
ARG OTELCOL_BUILDER="/build/bin/ocb"

# Set environment variables using ARG values
ENV OTELCOL_BUILDER_VERSION=${OTELCOL_BUILDER_VERSION}
ENV OTELCOL_BUILDER_DIR=${OTELCOL_BUILDER_DIR}
ENV OTELCOL_BUILDER=${OTELCOL_BUILDER}

# Copy the builder config and ocb binary into the container
COPY builder-config.yaml /etc/otelcol-dev/builder-config.yaml
COPY ocb /build/bin/ocb

# forcibly rename dist and output path to otelcol-dev
RUN apt-get update && \
  apt-get install yq -y
RUN yq -yi '.dist.name = "otelcol-dev" | .dist.output_path = "./otelcol-dev"' /etc/otelcol-dev/builder-config.yaml

# download and install the appropriate ocb binary based on container platform
# RUN set -x && \
#   if ! command -v ocb >/dev/null 2>&1; then \
#     if [ ! -x "$OTELCOL_BUILDER" ]; then \
#       set -e && \
#       os=$(uname -s) && \
#       os=$(echo "$os" | tr '[:upper:]' '[:lower:]') && \
#       machine=$(uname -m) && \
#       echo "os: $os" && \
#       echo "machine: $machine" && \
#       if [ "$machine" = "x86" ]; then \
#         machine="386"; \
#       elif [ "$machine" = "x86_64" ]; then \
#         machine="amd64"; \
#       elif [ "$machine" = "aarch64" ]; then \
#         machine="arm64"; \
#       elif [ "$machine" = "arm64v8" ]; then \
#         machine="arm64"; \
#       fi && \
#       echo "Installing ocb ($os/$machine) at $OTELCOL_BUILDER_DIR" && \
#       mkdir -p "$OTELCOL_BUILDER_DIR" && \
#       curl -sfLo "$OTELCOL_BUILDER" "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv$OTELCOL_BUILDER_VERSION/ocb_${OTELCOL_BUILDER_VERSION}_${os}_${machine}" && \
#       chmod +x "$OTELCOL_BUILDER"; \
#     fi; \
#   else \
#     OTELCOL_BUILDER=$(command -v ocb); \
#   fi

# run the builder and output files to /build/otelcol-dev
ENTRYPOINT [ "/build/bin/ocb", "--config", "/etc/otelcol-dev/builder-config.yaml" ]
