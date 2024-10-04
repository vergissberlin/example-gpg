# Asynchrone Verschlüsselung 

1) Asymmetrische Verschlüsselung verwendet ein Schlüsselpaar (öffentlich und privat).
2) Öffentlicher Schlüssel wird verwendet, um Nachrichten zu verschlüsseln.
3) Privater Schlüssel wird verwendet, um Nachrichten zu entschlüsseln.

---

 ```mermaid
sequenceDiagram
participant A as Sender
participant B as Empfänger
A->>B: Öffentlichen Schlüssel anfordern
B-->>A: Öffentlichen Schlüssel senden
Note over A,B: Sender verwendet den öffentlichen Schlüssel, um die Nachricht zu verschlüsseln.
A->>B: Verschlüsselte Nachricht senden
Note over B,A: Empfänger verwendet seinen privaten Schlüssel, um die Nachricht zu entschlüsseln.
B-->>A: Bestätigung der empfangenen Nachricht
```

<!--
In diesem Diagramm fordert der Sender (A) den öffentlichen Schlüssel vom Empfänger (B) an. Der Empfänger sendet diesen öffentlichen Schlüssel an den Sender. Der Sender verwendet diesen öffentlichen Schlüssel, um die Nachricht zu verschlüsseln und sendet dann die verschlüsselte Nachricht an den Empfänger. Der Empfänger verwendet seinen privaten Schlüssel, um die verschlüsselte Nachricht zu entschlüsseln. Nachdem der Empfänger die Nachricht entschlüsselt hat, sendet er eine Bestätigung an den Absender.
-->

---

## Installation  GPG

### Linux/Mac

```bash
sudo apt-get install gnupg  # für Ubuntu/Debian
brew install gnupg  # für macOS
```

### Windows

☝️ Lade *Gpg4win* herunter.

---
## Key Erstellen

1) `gpg --full-generate-key`
2) Wähle die Art des Schlüssels (1) RSA and RSA.
3) Gib die Schlüssellänge an (4096).
4) Gib an, ob der Schlüssel abläuft (0 für "nie ablaufen").
5) Gib deine Identität ein.
6) Erstelle ein Passwort.

---
## Public Key Exportieren

Du musst deinen Key exportieren und an die Personen schicken, die Dir eine Nachricht schicken wollen.
```bash
gpg --armor --export deine-email@example.com > publickey.asc
```

---
## Fremden Key Importieren

Der Schlüssel des Empfängers muss import werden um die Nachricht zu verschlüsseln.
```bash
gpg --import recipient-publickey.asc
```

---

## Nachricht verschlüsseln

```bash
gpg --encrypt --armor --recipient empfaenger@example.com nachricht.txt
```

---

## Verschlüsselte Nachricht per E-Mail senden

1) Kopiere den Inhalt der verschlüsselten Datei (nachricht.txt.asc).
2) Füge den verschlüsselten Text in den E-Mail-Textbereich ein.

---

## Entschlüsseln der Nachricht

Wenn Du eine verschlüsselte Nachricht erhältst, kannst Du sie wie folgt entschlüsseln:

```bash
gpg --decrypt nachricht.txt.asc
```

---

## Alternativen

- Gpg4win für Windows.
- GPG Suite für macOS.
- Online Tools wie [pgptool.org](https://pgptool.org/).
