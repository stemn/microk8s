#!/usr/bin/env bash


refresh_opt_in_config() {
    # add or replace an option inside the config file.
    # Create the file if doesn't exist
    opt="--$1"
    value="$2"
    config_file="$SNAP_DATA/args/$3"
    replace_line="$opt=$value"
    if $(grep -qE "^$opt=" $config_file); then
        sudo "$SNAP/bin/sed" -i "s/^$opt=.*/$replace_line/" $config_file
    else
        sudo "$SNAP/bin/sed" -i "$ a $replace_line" "$config_file"
    fi
}


skip_opt_in_config() {
    # remove an option inside the config file.
    # argument $1 is the option to be removed
    # argument $2 is the configuration file under $SNAP_DATA/args
    opt="--$1"
    config_file="$SNAP_DATA/args/$2"
    sudo "${SNAP}/bin/sed" -i '/'"$opt"'/d' "${config_file}"
}


wait_for_service() {
    service="$1"
    sudo systemctl restart snap.${SNAP_NAME}.daemon-${service}
    try_attempt=0
    while ! (sudo systemctl is-active --quiet snap.${SNAP_NAME}.daemon-${service}) &&
          ! [ ${try_attempt} -eq 30 ]
    do
        try_attempt=$((try_attempt+1))
        sleep 1
    done
    if [ ${try_attempt} -eq 30 ]
    then
        echo "fail"
    else
        echo "ok"
    fi
}