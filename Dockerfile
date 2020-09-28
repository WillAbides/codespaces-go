FROM golang:1-buster

RUN apt-get update \
  && apt-get install -y \
      apt-utils \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg-agent \
      software-properties-common  \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -  \
  && add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" \
  && apt-get update \
  && apt-get install -y docker-ce-cli \
  && apt-get clean  \
  && rm -rf /var/lib/apt/lists/*

# go get packages vscode uses for go
RUN go get \
    github.com/mdempsky/gocode \
    github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline \
    github.com/stamblerre/gocode \
    github.com/rogpeppe/godef \
    github.com/sqs/goreturns \
    golang.org/x/lint/golint \
    golang.org/x/tools/gopls \
    mvdan.cc/gofumpt

LABEL org.opencontainers.image.source=https://github.com/willabides/codespaces-go
ENV GOPRIVATE=github.com/github/*
