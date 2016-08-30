#!/bin/bash

data=$(curl https://curl.haxx.se/ca/cacert.pem)

if [ ! -e cabundle ]; then
    mkdir cabundle
fi

cat << _EOT_ > cabundle/cabundle.go
package cabundle

import (
    "unsafe"
    "reflect"
    "net/http"
    "crypto/x509"
    "crypto/tls"
)

var strData = \`$data\`

func pemData() []byte {
    var empty [0]byte
    sx := (*reflect.StringHeader)(unsafe.Pointer(&strData))
    b := empty[:]
    bx := (*reflect.SliceHeader)(unsafe.Pointer(&b))
    bx.Data = sx.Data
    bx.Len = len(strData)
    bx.Cap = bx.Len
    return b
}

func GetCertPool() *x509.CertPool {
    certs := x509.NewCertPool()
    certs.AppendCertsFromPEM(pemData())
    return certs
}

func GetTlsConfig() *tls.Config {
    return &tls.Config {
        RootCAs: GetCertPool(),
    }
}

func GetTransport() *http.Transport {
    return &http.Transport {
        TLSClientConfig: GetTlsConfig(),
    }
}

func GetClient() *http.Client {
    return &http.Client {
        Transport: GetTransport(),
    }
}

_EOT_
