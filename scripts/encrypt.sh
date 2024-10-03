#!/bin/bash

mkdir -p docs/messages_encrypted

encrypt_file() {
    local file="$1"
    local recipient="$2"
    local output_file="$3"

    # Encrypt file
    gpg --yes --encrypt --armor --recipient ${recipient} --output docs/messages_encrypted/${output_file} ${file}
}

encrypt_file "message.txt" "marvin.hans.peters@student.rahn.education" "message_marvin.asc"
encrypt_file "message.txt" "finn.hugo.heyse@student.rahn.education" "message_finn.asc"
encrypt_file "message.txt" "paul.junghans@student.rahn.education" "message_paul.asc"

# Print out results
echo "\n\033[1mVerschlüsselte Nachrichten:\033[0m"
ls -ih docs/messages_encrypted

echo "\n\033[1mÖffentliche Schlüssel:\033[0m"
ls -ih docs/public_keys

# Ask if the encrypted messages should be printed out
echo "\n"
read -p "Möchtest du die verschlüsselten Nachrichten ausgeben? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "\033[3m"
    cat docs/messages_encrypted/message_marvin.asc
    echo "\n"
    cat docs/messages_encrypted/message_finn.asc
    echo "\n"
    cat docs/messages_encrypted/message_paul.asc
    echo "\033[0m"
fi
