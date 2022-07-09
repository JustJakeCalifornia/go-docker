FROM golang:1.18-alpine AS build

WORKDIR /app
COPY go.mod .
COPY go.sum .

RUN go mod download

COPY ./cmd ./cmd

RUN go build -o /binary/go-docker ./cmd/api/main.go

FROM alpine:3.16
WORKDIR /app
COPY --from=build /app/binary .
CMD [ "./go-docker" ]