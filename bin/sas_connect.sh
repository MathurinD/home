#!/bin/bash

TMP=$(mktemp -d)
echo $TMP
mkdir -p $TMP
sshfs dorel@sas.eleves.ens.fr: $TMP
