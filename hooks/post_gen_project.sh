#!/usr/bin/env bash

if [ -z "${DRF_COOKIE_NO_INSTALL}" ]; then
    make install
    make build_dev
fi