FROM alpine:latest

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache ddclient

CMD ["ddclient", "-noquiet", "-foreground"]