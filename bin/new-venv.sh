#!/usr/bin/env bash
# Dieses Script erstellt ein neues uv-verwaltetes virtuelles Environment (venv)
# Es fragt zunächst ab, welche der aktuell installierten (verwalteten) Python-Versionen genutzt werden soll.
# Anschließend wird das venv mit --seed angelegt (sodass pip vorinstalliert wird)
# und eine .envrc erzeugt, die direnv beim Betreten des Verzeichnisses das venv automatisch aktiviert.

set -euo pipefail

# Prüfen, ob uv verfügbar ist
if ! command -v uv &>/dev/null; then
  echo "uv ist nicht installiert. Bitte installiere uv zuerst."
  exit 1
fi

# Liste der verwalteten Python-Versionen ermitteln.
# uv python list gibt eine Tabelle aus – wir extrahieren die erste Spalte (Version) und überspringen die Header-Zeile.
PY_VERSIONS=$(uv python list | hck -f 1)

# Falls fzf vorhanden ist, benutze es für die Auswahl, ansonsten nutze ein simples Bash-Menü.
if command -v fzf &>/dev/null; then
  SELECTED_VERSION=$(echo "$PY_VERSIONS" | fzf --prompt="Select Python version to use: ")
else
  echo "Verfügbare Python-Versionen:"
  select ver in $PY_VERSIONS; do
    SELECTED_VERSION=$(echo $ver | hck -f 1)
    break
  done
fi

# Erstelle das virtuelle Environment mit uv und --seed (sodass pip vorinstalliert wird)
echo "Erstelle virtuelles Environment..."
echo $SELECTED_VERSION
uv python install $SELECTED_VERSION
uv venv --python $SELECTED_VERSION --seed || { echo "Fehler beim Erstellen des venv"; exit 1; }

# Lege eine .envrc an, damit direnv das venv beim Betreten des Verzeichnisses lädt.
# Die Standard-direnv-Funktion "layout python" sucht nach einem venv im aktuellen Verzeichnis (.venv)
cat <<EOF > .envrc
source .venv/bin/activate
EOF

direnv allow
poetry init
