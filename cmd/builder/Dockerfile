FROM golang:1.23 AS build

WORKDIR /app

# Copy the build.sh script and builder config into the container
COPY build.sh /app/build.sh
COPY builder-config.yaml /app/builder-config.yaml

# Make the build.sh script executable
RUN chmod +x /app/build.sh

ENTRYPOINT ["/app/build.sh"]
