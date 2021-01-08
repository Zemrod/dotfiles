#!/usr/bin/env bash

update=$(checkupdates | wc -l)

printf "$update packages"
