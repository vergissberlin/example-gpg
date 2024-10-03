# Beispiel asynchrone Verschlüsselung mit GnuPG (GPG)

## Begriffsklärung

**Asymmetrische Verschlüsselung** verwendet ein Schlüsselpaar, das aus einem öffentlichen und einem privaten Schlüssel besteht. Der öffentliche Schlüssel wird verwendet, um Nachrichten zu verschlüsseln, die nur der Besitzer des privaten Schlüssels entschlüsseln kann. Um eine E-Mail asymmetrisch zu verschlüsseln, wird der öffentliche Schlüssel des Empfängers verwendet.

## Wie es funktioniert

Angenommen, Alice möchte eine verschlüsselte Nachricht an Bob senden. Bob hat ein Schlüsselpaar (privat und öffentlich) erstellt und Alice seinen öffentlichen Schlüssel gegeben. Alice verschlüsselt die Nachricht mit Bobs öffentlichem Schlüssel und sendet sie an Bob. Bob kann die Nachricht mit seinem privaten Schlüssel entschlüsseln.

Die Nachricht wird also mit dem öffentlichen Schlüssel des Empfängers verschlüsselt und kann nur mit dem privaten Schlüssel des Empfängers entschlüsselt werden. Der private Schlüssel sollte geheim gehalten werden, während der öffentliche Schlüssel an andere weitergegeben werden kann. Der öffentliche Schlüssel wird auch verwendet, um digitale Signaturen zu überprüfen. Er kann nicht zum Entschlüsseln von Nachrichten verwendet werden. Hintergrund ist, dass die Verschlüsselung mit dem öffentlichen Schlüssel sehr rechenintensiv ist, während die Entschlüsselung mit dem privaten Schlüssel schnell erfolgt. 

> Hiezu werden Einwegfunktionen verwendet, die leicht zu berechnen sind, aber schwer umkehrbar sind.

## Hands on

Hier ist eine Schritt-für-Schritt-Anleitung:

1. [Erstelle ein Schlüsselpaar (privat und öffentlich)](#1-erstellen-eines-schlüsselpaares-privat-und-öffentlich).
2. [Exportiere deinen öffentlichen Schlüssel und gib ihn an andere weiter](#c-exportiere-den-öffentlichen-schlüssel).
3. [Importiere den öffentlichen Schlüssel des Empfängers](#a-importiere-den-öffentlichen-schlüssel-des-empfängers).
4. [Verschlüssele die Nachricht](#b-nachricht-verschlüsseln).
5. [Sende die verschlüsselte Nachricht per E-Mail](#3-verschlüsselte-nachricht-per-e-mail-senden).

### 1. Erstellen eines Schlüsselpaares (Privat und Öffentlich)

Wir verwenden GnuPG (GPG), ein beliebtes Open-Source-Tool für die Verschlüsselung und Signierung.

#### a. Installation von GPG

- Linux/Mac: Normalerweise ist GPG vorinstalliert. Wenn nicht, installiere es mit:

    ```bash
    sudo apt-get install gnupg  # für Ubuntu/Debian
    brew install gnupg  # für macOS
    ```

- Windows: Lade Gpg4win herunter [hier](https://gpg4win.org/).

#### b. Erstellen eines Schlüsselpaares

1. Öffne ein Terminal (oder die GPG-Konsole auf Windows) und gib folgenden Befehl ein:

    ```bash
    gpg --full-generate-key
    ```

2. Wähle die Art des Schlüssels
   - Wähle (1) RSA and RSA.
3. Gib die Schlüssellänge an:
   - Empfohlen: 4096 (dies ist sehr sicher).
4. Gib an, ob der Schlüssel abläuft. Für einen normalen Anwendungsfall kannst du 0 für "nie ablaufen" eingeben.
5. Gib deine Identität ein:
   - Name: Dein voller Name.
   - E-Mail: Deine E-Mail-Adresse.
   - Kommentar: Optional.
6. Erstelle ein Passwort, um deinen privaten Schlüssel zu schützen.

Nach diesen Schritten wird dein Schlüsselpaar erstellt. Der private Schlüssel bleibt auf deinem System, und der öffentliche Schlüssel kann für die Verschlüsselung verwendet werden.

#### c. Exportiere den öffentlichen Schlüssel

Um deinen öffentlichen Schlüssel zu exportieren, damit er an andere weitergegeben oder auf einem Server veröffentlicht werden kann:

```bash
gpg --armor --export deine-email@example.com > publickey.asc
```

Dieser Befehl speichert deinen öffentlichen Schlüssel in einer Datei namens publickey.asc im ASCII-Format.

### 2. Verschlüsseln der Nachricht

#### a. Importiere den öffentlichen Schlüssel des Empfängers

Du benötigst den öffentlichen Schlüssel des Empfängers, um die Nachricht zu verschlüsseln. Wenn du den öffentlichen Schlüssel als Datei erhalten hast, importiere ihn:

```bash
gpg --import recipient-publickey.asc
```

#### b. Nachricht verschlüsseln

Angenommen, du hast die Nachricht in einer Datei namens nachricht.txt gespeichert und du willst sie an empfaenger@example.com verschlüsseln:

```bash
gpg --encrypt --armor --recipient empfaenger@example.com nachricht.txt
```

- `--encrypt`: Verschlüsselt die Nachricht.
- `--armor`: Erzeugt einen ASCII-Text statt einer binären Datei, was für E-Mails praktischer ist.
- `--recipient`: Gibt den Empfänger an.

Das Ergebnis ist eine Datei, die in einem ASCII-Format (nachricht.txt.asc) vorliegt. Der verschlüsselte Text sieht etwa so aus:

```text
-----BEGIN PGP MESSAGE-----
Version: GnuPG v2
 
hQIMA6Ln56wZw95gAQ/+K19rNpbT/1h2Syq
...
-----END PGP MESSAGE-----
```

### 3. Verschlüsselte Nachricht per E-Mail senden

1. Kopiere den Inhalt der verschlüsselten Datei (nachricht.txt.asc).
2. Füge den verschlüsselten Text in den E-Mail-Textbereich ein.
3. Der Empfänger muss dann seinen privaten Schlüssel verwenden, um die Nachricht zu entschlüsseln.

### 4. Entschlüsseln der Nachricht (Empfängerseite)

Der Empfänger kann die Nachricht mit folgendem Befehl entschlüsseln:
gpg --decrypt nachricht.txt.asc

Falls du die Nachricht selbst testweise verschlüsseln und entschlüsseln möchtest, kannst du deinen eigenen öffentlichen Schlüssel verwenden.

## Alternativen

Wenn Du kein GPG auf der Kommandozeile verwenden möchtest, gibt es auch grafische Benutzeroberflächen für GPG, wie z.B. [Gpg4win](https://gpg4win.org/) für Windows oder [GPG Suite](https://gpgtools.org/) für macOS. Diese Tools bieten eine benutzerfreundliche Oberfläche für die Verwaltung von Schlüsseln und das Verschlüsseln/Entschlüsseln von Nachrichten. Sie sind jedoch im Wesentlichen Frontends für die GPG-Befehlszeile. Wenn Du gar nichts installieren möchtest, gibt es auch [Online-Tools](https://pgptool.org/), die GPG-Funktionen anbieten.

### Online Tools

- <https://pgptool.org>
