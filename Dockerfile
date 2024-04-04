# Minify client side assets (JavaScript)
FROM node:latest AS build-js

RUN npm install gulp gulp-cli -g && apt-get update && apt-get install -y git
WORKDIR /build
RUN git clone https://github.com/gophish/gophish .
RUN npm install
RUN gulp

# Build Golang binary
FROM golang:latest AS build-golang

WORKDIR /go/src/github.com/gophish/gophish
COPY --from=build-js /build/ ./

# Stripping X-Gophish 
RUN sed -i 's/X-Gophish-Contact/X-Contact/g' models/email_request_test.go
RUN sed -i 's/X-Gophish-Contact/X-Contact/g' models/maillog.go
RUN sed -i 's/X-Gophish-Contact/X-Contact/g' models/maillog_test.go
RUN sed -i 's/X-Gophish-Contact/X-Contact/g' models/email_request.go

# Stripping X-Gophish-Signature
RUN sed -i 's/X-Gophish-Signature/X-Signature/g' webhook/webhook.go

# Changing servername
RUN sed -i 's/const ServerName = "gophish"/const ServerName = "srv1"/' config/config.go

# Changing rid value
RUN sed -i 's/const RecipientParameter = "rid"/const RecipientParameter = "dir"/g' models/campaign.go

# Copying in custom 404 handler
COPY ./files/phish.go ./controllers/phish.go

RUN go get -v && go build -v

# Runtime container
FROM debian:stable

RUN useradd -m -d /opt/gophish -s /bin/bash app && \
    apt-get update && \
    apt-get install --no-install-recommends -y jq libcap2-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /opt/gophish
COPY --from=build-golang /go/src/github.com/gophish/gophish/ ./
COPY --from=build-js /build/static/js/dist/ ./static/js/dist/
COPY --from=build-js /build/static/css/dist/ ./static/css/dist/
COPY --from=build-golang /go/src/github.com/gophish/gophish/config.json ./
COPY ./files/404.html ./templates/
RUN chown app config.json

RUN setcap 'cap_net_bind_service=+ep' /opt/gophish/gophish
USER app
CMD ["./docker/run.sh"]
