#!/bin/bash
set -euo pipefail

map=${1:-Stratis}

for x in makepbo.linux makepbo makepbo.exe; do
  if command -v $x &> /dev/null; then
    cmd=$x
  fi
done
if [ -z "${cmd:-}" ]; then
  >&2 echo makepbo not found
  exit 1
fi
outfile="Zeus_yymmdd_Template-$(git describe).$map"
$cmd -N Zeus_yymmdd_Template.Stratis "$outfile"
cp "$outfile.pbo" ~/link/arma/mpmissions
