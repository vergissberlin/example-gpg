#!/bin/bash
generate_gpg_keys() {
    local name_real="$1"
    local name_email="$2"
    local passphrase="$3"
    local output_file="$4"

    # Generate gpg keys
    gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 2048
Subkey-Type: RSA
Subkey-Length: 2048
Name-Real: ${name_real}
Name-Email: ${name_email}
Expire-Date: 0
Passphrase: ${passphrase}
EOF

    # Export public key
    gpg --yes --armor --output docs/public_keys/${output_file} --export ${name_email}
}

generate_gpg_keys "Marvin Hans Peters" "marvin.hans.peters@student.rahn.education" "my-password" "marvin.asc"
generate_gpg_keys "Finn Hugo Heyse" "finn.hugo.heyse@student.rahn.education" "my-password" "finn.asc"
generate_gpg_keys "Paul Junghans" "paul.junghans@student.rahn.education" "my-password" "paul.asc"

