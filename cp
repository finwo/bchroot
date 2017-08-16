#!/bin/bash
mkdir -p $(dirname $1$2)
cp -v $2 $1$2
