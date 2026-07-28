FROM golang:1.24-alpine AS build

WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download

COPY main.go ./
RUN CGO_ENABLED=0 go build -o /dependency-demo .

FROM scratch
COPY --from=build /dependency-demo /dependency-demo
EXPOSE 8080
ENTRYPOINT ["/dependency-demo"]
