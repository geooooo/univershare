#!/usr/bin/env bash

if [[ "$1" == "test" ]]
then
    pub run aqueduct db upgrade --connect=postgres://geo:123@localhost:5432/univershare_test
else
    pub run aqueduct db upgrade --connect=postgres://geo:123@localhost:5432/univershare
fi