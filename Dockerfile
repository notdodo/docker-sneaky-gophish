FROM golang:alpine

RUN sed -i -e 's/v[[:digit:]]\.[[:digit:]]*/edge/g' /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add --no-cache vim wget ca-certificates build-base git nginx

WORKDIR $GOPATH
RUN go get -v github.com/gophish/gophish
WORKDIR $GOPATH/src/github.com/gophish/gophish
RUN go build -i -ldflags="-s -w"
RUN mkdir /app && cp -R $GOPATH/src/github.com/gophish/gophish/* /app/ && rm -rf $GOPATH
WORKDIR /app
# In reverse proxy not needed
# RUN sed -i "s|127.0.0.1|0.0.0.0|g" config.json
RUN sed -i "s|gophish.db|database/gophish.db|g" config.json
RUN chmod +x ./gophish

RUN apk del build-base git

VOLUME ["/app/database"]
EXPOSE 3333 80 443
ENTRYPOINT ["./gophish"]


#{
#	"admin_server": {
#		"listen_url": "0.0.0.0:3333",
#		"use_tls": false,
#		"cert_path": "gophish_admin.crt",
#		"key_path": "gophish_admin.key"
#	},
#	"phish_server": {
#		"listen_url": "0.0.0.0:80",
#		"use_tls": false,
#		"cert_path": "example.crt",
#		"key_path": "example.key"
#	},
#	"db_name": "sqlite3",
#	"db_path": "database/gophish.db",
#	"migrations_prefix": "db/db_",
#	"contact_address": "",
#	"logging": {
#		"filename": ""
#	}
#}
