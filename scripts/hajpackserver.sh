#!/bin/bash

# check if packwiz is installed
if ! command -v packwiz &> /dev/null
then
    echo "packwiz could not be found! check your PATH or install packwiz"
fi

# if no arguments are passed
if [ $# -eq 0 ]
then
    echo "Invalid arguments"
    echo "Usage: ./hajpackserver.sh --packwiz http://localhost:8080/pack.toml"
    echo
    echo "Options:"
    echo "  --packwiz <url> - run packwiz server"
    echo "  --setup - setup packwiz server"
    echo "  --clean - clean packwiz server"
    exit 1
fi

# if --packwiz is passed
if [ "$1" == "--packwiz" ]
then
    if [ -z "$2" ]
    then
        echo "Invalid arguments"
        echo "Usage: ./hajpackserver.sh --packwiz http://localhost:8080/pack.toml"
        exit 1
    fi
    echo "Running packwiz server"
    java -jar packwiz-installer-bootstrap.jar -g -s server $2
    echo "Running server"
    java -jar server.jar
fi

# if --setup is passed
if [ "$1" == "--setup" ]
then
    wget https://github.com/packwiz/packwiz-installer-bootstrap/releases/download/v0.0.3/packwiz-installer-bootstrap.jar
    wget https://meta.fabricmc.net/v2/versions/loader/1.20.1/0.15.7/1.0.0/server/jar -O server.jar
fi

# if --clean is passed
if [ "$1" == "--clean" ]
then
    echo -n "This will remove everything that is not this script! Are you sure? (y/N) "
    read -r response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        # copy script to temp file
        cp hajpackserver.sh /tmp/hajpackserver.sh
        # remove everything
        echo "Removing everything!"
        echo "This will remove:"
        ls -A | grep -v "hajpackserver.sh"
        echo ".fabric/"
        rm -rfvI *
        rm -rfvI .fabric/ # there are definitely better ways to do this, i will fix it later
        # copy script back
        cp /tmp/hajpackserver.sh hajpackserver.sh
    else
        echo "Aborted"
    fi
fi
