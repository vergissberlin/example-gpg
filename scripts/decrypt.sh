#!/bin/bash

mkdir -p docs/messages_decrypted

decrypt_file() {
    local file="$1"
    local recipient="$2"
    local output_file="$3"

    # Decrypt file
    gpg --yes --decrypt --output docs/messages_decrypted/${output_file} ${file}
}

decrypt_file "docs/messages_encrypted/message_marvin.asc" "marvin.hans.peters@student.rahn.education" "message_marvin.txt"
decrypt_file "docs/messages_encrypted/message_finn.asc" "finn.hugo.heyse@student.rahn.education" "message_finn.txt"
decrypt_file "docs/messages_encrypted/message_paul.asc" "paul.junghans@student.rahn.education" "message_paul.txt"

# Print out results
echo "\n\033[1mEntschlüsselte Nachrichten:\033[0m"
ls -ih docs/messages_decrypted

echo "\n\033[1mÖffentliche Schlüssel:\033[0m"
ls -ih docs/public_keys

# Ask if the encrypted messages should be printed out
echo "\n"
read -p "Möchtest du die entschlüsselten Nachrichten ausgeben? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "\033[3m"
    cat docs/messages_decrypted/message_marvin.txt
    echo "\n"
    cat docs/messages_decrypted/message_finn.txt
    echo "\n"
    cat docs/messages_decrypted/message_paul.txt
    echo "\033[0m"
fi
