ARG GO_VERSION=1.14.3
FROM golang:${GO_VERSION} AS build

# Copy all project and build it
# This layer will be rebuilt when ever a file has changed in the project directory
WORKDIR /build
COPY mqtt_data_exporter /build
RUN CGO_ENABLED=0 go build -o /bin/mqtt_data_exporter

# This results in a single layer image
FROM alpine
COPY --from=build /bin/mqtt_data_exporter /bin/mqtt_data_exporter
EXPOSE 2112
ENTRYPOINT ["/bin/mqtt_data_exporter"]
