kubectl apply $(ls secret*.yaml | awk ' { print " -f " $1 } ')
