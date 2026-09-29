#!/bin/bash


function main(){
    ssh-keygen -t ed25519 -f ~/.ssh/homelab_vms -C "Key pair used to connect via SSH the Homelab VMs." -N ""
    mkdir -p key-pair-results
    cp ~/.ssh/homelab_vms.pub key-pair-results/homelab_vms.pub
}


main
