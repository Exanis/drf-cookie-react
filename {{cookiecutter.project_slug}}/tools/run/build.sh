#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

DOCKER="tools/common/docker.sh"

function build {
    # Prepare environment
    GIT_COMMIT=$(git rev-parse --short HEAD)
    BUILD_DATE=$(date '+%Y%m%d-%H%M%S')
    TAG_VERSION="${BUILD_DATE}.${GIT_COMMIT}"
    IMAGE_NAME="{{cookiecutter.project_slug}}/${1}:${TAG_VERSION}"

    # Erase previous artifact (used if previous build failed)
    rm -rf target
    mkdir -p target/src

    # Prepare files list
    if [ -f "${1}"/.buildignore ]; then
        FILES=$(ls "${1}" | grep -v $(cat "${1}"/.buildignore))
    else
        FILES=$(ls "${1}")
    fi

    # Prepare content to build from
    OLDPATH=$(pwd)
    cd "${1}"
    cp -r ${FILES} ${OLDPATH}/target/src
    cd ${OLDPATH}
    cp "docker/${1}/${2}/Dockerfile" target/

    # Build
    ${DOCKER} build -t="${IMAGE_NAME}" target

    # Check
    if [ "$?" != "0" ]; then
        echo -e "${RED}ERROR: Cannot build ${1}/${2}${NC}"
        exit 1
    fi

    # Tag
    if [ "${2}" == "production" ]; then
        ${DOCKER} tag ${IMAGE_NAME} "{{cookiecutter.project_slug}}/${1}:latest"
        ${DOCKER} tag ${IMAGE_NAME} "{{cookiecutter.project_slug}}/${1}:production"
    else
        ${DOCKER} tag ${IMAGE_NAME} "{{cookiecutter.project_slug}}/${1}:${2}"
    fi

    # Clean working environment
    rm -rf target

    # Display ok for this one
    echo -e "${GREEN}OK: Build of ${1}/${2} complete${NC}"
}

if [ -z "${1}" ]; then
    TARGET="production"
else
    TARGET="${1}"
fi

if [ -z "${2}" ]; then
    build backend ${TARGET}
    build frontend ${TARGET}
    build database ${TARGET}
    build router ${TARGET}
else
    build ${2} ${TARGET}
fi