#!/bin/bash

echo "$1"
if [ "$1" == "-x" ]; then
	ssh -p 2222 server@127.0.0.1 -XC
	exit 0
fi

ssh -p 2222 server@127.0.0.1
exit 0
