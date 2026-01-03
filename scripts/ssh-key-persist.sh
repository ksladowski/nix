#!/usr/bin/env bash

SSH_KEYS=$(mktemp -d)
mkdir -p "$SSH_KEYS/persist/etc/ssh"

cp /persist/etc/ssh/ssh_host_ed25519_key "$SSH_KEYS/persist/etc/ssh/"
cp /persist/etc/ssh/ssh_host_ed25519_key.pub "$SSH_KEYS/persist/etc/ssh/"
cp /persist/etc/ssh/ssh_host_rsa_key "$SSH_KEYS/persist/etc/ssh/" 2>/dev/null
cp /persist/etc/ssh/ssh_host_rsa_key.pub "$SSH_KEYS/persist/etc/ssh/" 2>/dev/null

chmod 600 "$SSH_KEYS/persist/etc/ssh"/ssh_host_*_key 2>/dev/null
chown -R $(id -u):$(id -g) "$SSH_KEYS"
