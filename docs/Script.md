# Script für die Bildschirmaufnahme

```bash
apt update
apt install gnupg
mkdir test && cd test
gpg --full-generate-key
gpg --list-keys
gpg --export --armor maria@musterfrau.de
echo "Hallo Welt" > nachricht.txt
gpg --encrypt --armor --recipient maria@musterfrau.de nachricht.txt
ll
cat nachricht.txt.asc
ll
cat nachricht.decrypted.txt
```
