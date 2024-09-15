#!/bin/bash

# Update Paketlisten
sudo apt update

# Installiere wget, falls nicht bereits installiert
sudo apt install -y wget

# Lade den Plex-GPG-Schlüssel herunter und füge ihn dem trusted.gpg.d-Verzeichnis hinzu
wget -O - https://downloads.plex.tv/plex-keys/PlexSign.key | sudo tee /etc/apt/trusted.gpg.d/plex.asc

# Füge das Plex-Repository hinzu
echo "deb https://downloads.plex.tv/repo/deb public main" | sudo tee /etc/apt/sources.list.d/plex.list

# Aktualisiere die Paketlisten
sudo apt update

# Installiere Plex Media Server
sudo apt install -y plexmediaserver

# Starte den Plex-Dienst und stelle sicher, dass er beim Systemstart automatisch gestartet wird
sudo systemctl start plexmediaserver
sudo systemctl enable plexmediaserver

# IP-Adresse herausfinden und in die Variable speichern
ip_address=$(hostname -I | awk '{print $1}')

# Falls hostname -I nicht funktioniert, kannst du alternative Methoden verwenden:
# ip_address=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Überprüfen, ob die IP-Adresse erfolgreich gesetzt wurde
if [ -z "$ip_address" ]; then
    echo "Fehler: No IP found!."
    exit 1
fi

# Ausgabe der Links mit der richtigen IP-Adresse
echo "###################################################################"
echo "Open Browser and enter http://$ip_address:32400/web"
echo "###################################################################"