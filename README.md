# go-ca-bundle-generator

## Why use?

Some environments those have **no latest CA information** may cause TLS errors,  
when we try to connect to websites via `https://`.  
We need **`ca-bundle.crt`**.

Source: **[https://curl.haxx.se/ca/cacert.pem](https://curl.haxx.se/ca/cacert.pem)**

## Usage

### Source Generation

Execute `generate.sh` in your project root directory.

```ShellSession
mpyw@localhost:~$ code=$(curl https://raw.githubusercontent.com/mpyw/go-ca-bundle-generator/master/generate.sh)
mpyw@localhost:~$ cd /path/to/project
mpyw@localhost:/path/to/project$ echo "$code" | bash
```

### Package API

Import `./cabundle`.  
Now you can use various levels of API.

#### cabundle.GetCertPool()

returns `*x509.CertPool` internally using `ca-bundle.crt`.

#### cabundle.GetTlsConfig()

returns `*tls.Config` internally using `cabundle.GetCertPool()`.

#### cabundle.GetTransport()

returns `*http.Transport` internally using `cabundle.GetTlsConfig()`.

#### cabundle.GetClient()

returns `*http.Client` internally using `cabundle.GetTransport()`.

## Test

`go run test.go` sends a dummy request to Twitter API server.
