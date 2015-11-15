# go-ca-bundles-generator

## Why use?

Some environment that has no CA information causes TLS error,
when we try to connect to websites via "https://".

## Usage

### Source Generation

1. Copy `generate.sh` in your project root directory with executable permission.
2. Execute `generate.sh`.

### Source Importation API

Import `./cabundles`.  
Now you can use various levels of API.

#### cabundles.GetCertPool()

returns `*x509.CertPool` internally using `ca-bundles.pem`.

#### cabundles.GetTlsConfig()

returns `*tls.Config` internally using `cabundles.GetCertPool()`.

#### cabundles.GetTransport()

returns `*http.Transport` internally using `cabundles.GetTlsConfig()`.

#### cabundles.GetClient()

returns `*http.Client` internally using `cabundles.GetTransport`

`./generate.sh` generate a go source file including latest `ca-bundles.pem` as resource.

## Test

`go run test.go` sends a dummy request to Twitter API server.
