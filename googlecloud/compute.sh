#!/bin/bash

ENABLE_CREATE=/bin/true
COMPUTE_NAMES="ns master-01"

function start() {
    for name in $(gcloud compute instances list --format 'get(name)')
    do
    	if [[ ${COMPUTE_NAMES} =~ (^| )${name}($| ) ]]; then
            status=$(gcloud compute instances list --filter ${name} --format 'get(status)')
            if [ $? -ne 0 -o -z "${status}" ]; then
                echo 'Error: status is invalid'
                exit 1
            fi
            if [ ${status} != 'RUNNING' ]; then
                gcloud compute instances start ${name}
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi
        fi
    done
}

function stop() {
    for name in $(gcloud compute instances list --format 'get(name)')
    do
    	if [[ ${COMPUTE_NAMES} =~ (^| )${name}($| ) ]]; then
            status=$(gcloud compute instances list --filter ${name} --format 'get(status)')
            if [ ${status} == 'RUNNING' ]; then
                gcloud compute instances stop ${name}
                if [ $? -ne 0 ]; then
                    exit 1
                fi
            fi
        fi
    done
}

case $1 in
    'start' )
        start
        ;;
    'stop' )
        stop
        ;;
    * )
        echo "$(basename $0) start|stop"
        ;;
esac
