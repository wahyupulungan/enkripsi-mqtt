#!/bin/bash
PASS="rahasia123"

while true; do
  # ---- kirim pesan ----
  read -p "[PUB] > " MSG || break
  [[ -z $MSG ]] || echo -n "$MSG" |
    openssl enc -aes-256-cbc -a -salt -pbkdf2 -pass pass:$PASS |
    mosquitto_pub -h localhost -t to_sub -l

  # ---- tunggu balasan ----
  mosquitto_sub -h localhost -t to_pub -C 1 |
    openssl enc -aes-256-cbc -a -d -salt -pbkdf2 -pass pass:$PASS
done
