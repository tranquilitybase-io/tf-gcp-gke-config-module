# #!/bin/bash -x

openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=TB Inc./CN=eagle-console.tranquilitybase-demo.io' -keyout private.landing-zone.com.key -out private.landing-zone.com.crt
openssl req -out eagle-console.private.landing-zone.com.csr -newkey rsa:2048 -nodes -keyout eagle-console.private.landing-zone.com.key -subj "/CN=eagle-console.tranquilitybase-demo.io/O=eagle-console organization"
openssl x509 -req -days 365 -CA private.landing-zone.com.crt -CAkey private.landing-zone.com.key -set_serial 0 -in eagle-console.private.landing-zone.com.csr -out eagle-console.private.landing-zone.com.crt

## create secret
kubectl create -n istio-system secret tls ec-tls-credential --key=eagle-console.private.landing-zone.com.key --cert=eagle-console.private.landing-zone.com.crt

