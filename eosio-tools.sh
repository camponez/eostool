#!/bin/bash

LOG_FILE='eosiod.log'
PID_FILE='eosiod.pid'
VERSION='0.1'

function start_eosio {

    if [ -f "${PID_FILE}" ]; then
        echo 'Looks like eosiod is running. Use stop command first.'
        echo "If you are sure eosiod is not running delete ${PID_FILE}"
        exit 0
    fi

    if [ -d './data-dir' ]; then
        if [ -f "${LOG_FILE}" ]; then
            echo 'Backing up the log file...'
            mv "${LOG_FILE}" "${LOG_FILE}.old"
        fi

        echo 'Starting eosiod...';
        ./eosiod > ${LOG_FILE} 2>&1 &
        echo $! >${PID_FILE};
    else
        echo 'data-dir/ has to be present in the same directory as eosiod'
    fi
}

function stop_eosio {
    if [ -f ${PID_FILE} ]; then
        echo 'Stopping...'
        kill -15 $(cat "${PID_FILE}")
        rm -v ${PID_FILE}
    else
        echo "No ${PID_FILE} found"
    fi
}

function setup {
    EOS="$1"
    cp -v "$EOS/programs/eosiod/eosiod" .
    echo 'Now run `./tools/start.sh start` to start your eosiod'
}

case $1 in
    "start")
        start_eosio
        ;;
    "stop")
        stop_eosio
        ;;

    "restart")
        stop_eosio
        sleep 5
        start_eosio
        ;;

    "setup")
        if [ -d "$2" ]; then
            setup "$2"
        else
            echo "$2 does not exist. Please pass the FULL PATH"
            echo "usage: ./tools/start.sh setup $HOME/eos/build"
        fi
        ;;
    "version")
        echo "Version $VERSION"
        ;;
    *)
        echo 'Options are "start" and "stop"'

    esac
