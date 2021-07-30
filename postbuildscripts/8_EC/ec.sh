# #!/bin/bash -x
MYSELF="$(realpath "$0")"
MYDIR="${MYSELF%/*}"

kubectl apply -f $MYDIR/eagle_console.yaml