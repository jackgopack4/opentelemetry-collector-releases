FROM golang:1.23 AS build

WORKDIR /build

# Copy default builder config and ocb binary into the container
COPY builder-config.yaml /build/builder-config.yaml
COPY ocb /build/ocb

ARG TARGETOS
RUN if [ "$TARGETOS" = "linux"] || [ "$TARGETOS" = "darwin" ]; then \
      chmod +x /build/ocb; \
      else; then \
        icacls C:\build\ocb /grant Everyone:(RX); \
    fi

ENTRYPOINT [ "./ocb"]
# default arguments to use provided builder config file from documentation;
# replace if using a different file location or file name
CMD [ "--config", "builder-config.yaml" ]