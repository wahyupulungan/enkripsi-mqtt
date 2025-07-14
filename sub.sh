#!/bin/bash
PASS="rahasia123"

while true; do
  # ---- dengar pesan ----
  mosquitto_sub -h localhost -t to_sub -C 1 |
    openssl enc -aes-256-cbc -a -d -salt -pbkdf2 -pass pass:$PASS

  # ---- balas ke pub ----
  read -p "[SUB] > " MSG || break
  [[ -z $MSG ]] || echo -n "$MSG" |
    openssl enc -aes-256-cbc -a -salt -pbkdf2 -pass pass:$PASS |
    mosquitto_pub -h localhost -t to_pub -l &
done
