# #!/bin/bash -x
export HTTPS_PROXY="localhost:3128"
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

kubectl apply -f $MYDIR/eagle_console.yaml