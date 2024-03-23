FROM --platform=$BUILDPLATFORM golang:1.22 AS build
ARG TARGETOS
ARG TARGETARCH

WORKDIR /build
RUN git clone -b mod-update https://github.com/sfudeus/mqtt_data_exporter.git

WORKDIR /build//mqtt_data_exporter
RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /bin/mqtt_data_exporter

FROM scratch
COPY --from=build /bin/mqtt_data_exporter /bin/mqtt_data_exporter
EXPOSE 2112
ENTRYPOINT ["/bin/mqtt_data_exporter"]
