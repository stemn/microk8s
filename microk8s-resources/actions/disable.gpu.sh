#!/usr/bin/env bash

set -e

source $SNAP/actions/common/utils.sh

echo "Disabling NVIDIA GPU support"
sudo sh -c "sed 's@${SNAP}@'"${SNAP}"'@g;s@${SNAP_DATA}@'"${SNAP_DATA}"'@g' $SNAP_DATA/args/containerd-runc.toml > $SNAP_DATA/args/containerd.toml"
sudo systemctl restart snap.${SNAP_NAME}.daemon-containerd
"$SNAP/kubectl" "--kubeconfig=$SNAP/client.config" "delete" "-f" "${SNAP}/actions/gpu.yaml"
echo "GPU support disabled"

