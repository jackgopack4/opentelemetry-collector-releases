#!/bin/bash
BUILDOS="linux"
BUILDARCH="amd64"

GOOS=${GOOS:-"linux"} # default value if not set
GOARCH=${GOARCH:-"amd64"} # default value if not set

WORKDIR="/app"
mkdir -p $WORKDIR

OCB_URL="https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/cmd%2Fbuilder%2Fv0.109.0/ocb_0.109.0_${BUILDOS}_${BUILDARCH}"

wget -O $WORKDIR/ocb $OCB_URL
chmod +x $WORKDIR/ocb

ls -la $WORKDIR > $WORKDIR/log
objdump -d $WORKDIR/ocb | head >> $WORKDIR/log

echo Your container args are: "$@"

$WORKDIR/ocb "$@"
