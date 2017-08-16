#!/bin/bash
mkdir -p $(dirname $1$2)
cp -vL $2 $1$2
