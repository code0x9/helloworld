FROM golang:onbuild
MAINTAINER Niko Bellic <niko.bellic@daumkakao.com>

COPY VERSION /go/bin/VERSION

EXPOSE 8080
