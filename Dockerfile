FROM golang:1-buster

COPY ./buildscript/installpkgs /buildscript/installpkgs

RUN /buildscript/installpkgs && rm -rf /buildscript

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

COPY ./fs /

LABEL org.opencontainers.image.source=https://github.com/willabides/codespaces-go
ENV GOPRIVATE=github.com/github/*
