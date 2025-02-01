FROM golang:1.20-alpine AS builder
WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o app .
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/app .
COPY --from=builder /app/static ./static

EXPOSE 8080

CMD ["./app"]
