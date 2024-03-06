#!/bin/bash

# check if packwiz is installed
if ! command -v packwiz &> /dev/null; then echo "[ERROR] packwiz could not be found! check your PATH or install packwiz"; exit 1; fi

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
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        cp hajpackserver.sh /tmp/hajpackserver.sh
        echo "[INFO] Removing everything!"
        echo "This will remove:"
        ls -A | grep -v "hajpackserver.sh"
        rm -rfvI * .*
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
    # check arguments
    if [ -z "$1" ]; then echo "[ERROR] Invalid arguments passed to function run_packwiz!"; exit 1; fi
    if [[ ! $1 == *pack.toml ]]; then echo "[WARN] $1 does not end with pack.toml! If you are encountering a token recognition error, this is likely the cause."; fi

    # run packwiz
    echo "[INFO] Running packwiz installer with server at $1" 
    /usr/lib/jvm/java-17-openjdk/bin/java -jar packwiz-installer-bootstrap.jar -g -s server $1

    # run server (if you want to change the server command, change it here!)
    command="/usr/lib/jvm/java-17-openjdk/bin/java -Xmx$ram -Xms$ram -jar server.jar"
    if [ $3 == false ]; then command="$command nogui"; fi
    echo "[INFO] Running server with command: $command"
    eval $command
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
if [ $setup == true ]; then setup; fi
if [ $clean == true ]; then cleanup; fi
if [ -n "$packwiz" ]; then run $packwiz $ram $gui; fi
