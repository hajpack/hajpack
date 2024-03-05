#!/bin/bash

# check if packwiz is installed
if ! command -v packwiz &> /dev/null
then
    echo "[ERROR] packwiz could not be found! check your PATH or install packwiz"
    exit 1
fi

# arg variables
packwiz=""
ram="8G"
gui=false
setup=false
clean=false

help() {
    echo "[ERROR] Invalid arguments!"
    echo "Usage: ./hajpackserver.sh -p http://localhost:8080/pack.toml -r 8G -g"
    echo
    echo "Options:"
    echo "  -p <url> - run packwiz server using pack.toml at <url>"
    echo "  -s - setup packwiz server (optional)"
    echo "  -c - clean packwiz server (optional)"
    echo "  -r <ram> - set server ram (optional, default 8G)"
    echo "  -g - run server with gui (optional, default nogui)"
    exit 1
}

cleanup() {
    echo -n "This will remove everything that is not this script! Are you sure? (y/N) "
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        # copy script to temp file
        cp hajpackserver.sh /tmp/hajpackserver.sh
        # remove everything
        echo "[INFO] Removing everything!"
        echo "This will remove:"
        ls -A | grep -v "hajpackserver.sh"
        rm -rfvI * .*
        # copy script back
        cp /tmp/hajpackserver.sh hajpackserver.sh
    else
        echo "[INFO] Aborted deletion"
    fi
}

setup() {
    wget https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar -q --show-progress
    wget https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.7/1.0.0/server/jar -O server.jar -q --show-progress
}

run() {
    if [ -z "$1" ]
    then
        echo "[ERROR] Invalid arguments passed to function run_packwiz!"
        exit 1
    fi
    if [[ ! $1 == *pack.toml ]]
    then
        echo "[WARN] $1 does not end with pack.toml! If you are encountering a token recognition error, this is likely the cause."
    fi
    echo "[INFO] Running packwiz installer with server at $1" 
    java -jar packwiz-installer-bootstrap.jar -g -s server $1

    # TODO: make this not garbage
    command="java" # if you want to tweak the command further to personal preference, do it here
    # if $1 is not set, set it to 8G
    # there are probably better ways to do this
    if [ -z "$2" ]
    then
        command="$command -Xmx8G -Xms8G"
    else
        command="$command -Xmx$2 -Xms$2"
    fi

    command="$command -jar server.jar"

    # if argument 3 passed to the function is false add nogui to the command
    if [ $3 == false ]
    then
        command="$command nogui"
    fi

    echo "[INFO] Running server with command: $command"
    $command
}

# parse arguments
while getopts 'scgp:r:' flag; do
  case "${flag}" in
    p) packwiz="${OPTARG}" ;;
    r) ram="${OPTARG}" ;;
    g) gui=true ;;
    s) setup=true ;;
    c) clean=true ;;
    *) help ;;
  esac
done

if [ $OPTIND -eq 1 ]; then help; fi

# run the actual commands
if [ $setup == true ]
then
    setup
fi

if [ $clean == true ]
then
    cleanup
fi

if [ -n "$packwiz" ]
then
    run $packwiz $ram $gui
fi
