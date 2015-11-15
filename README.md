# go-ca-bundle-generator

## Why use?

Some environments those have **no latest CA information** may cause TLS errors,  
when we try to connect to websites via `https://``.  
We need **`ca-bundle.crt`**.

The source repository is here: **[bagder/ca-bundle](https://github.com/bagder/ca-bundle)**

## Usage

### Source Generation

Execute `generate.sh` in your project root directory.

```ShellSession
mpyw@localhost:~$ code=$(curl https://raw.githubusercontent.com/mpyw/go-ca-bundles-generator/master/generate.sh)
mpyw@localhost:~$ cd /path/to/project
mpyw@localhost:/path/to/project$ echo "$code" | bash
```

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
