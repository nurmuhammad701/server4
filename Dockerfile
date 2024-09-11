FROM golang:1.23.1 AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

RUN go build -o main .

FROM alpine:latest

WORKDIR /app

EXPOSE 8085


CMD ["./main"]