#!/usr/bin/env bash
# Applique l'icone, le fond de demarrage et l'orientation sur le projet Android genere par Capacitor.
set -euo pipefail
cd "$(dirname "$0")/.."
RES=android/app/src/main/res
SRC=resources/android

# Icones (anciennes, rondes, premier plan adaptatif) + fond degrade adaptatif
cp -r "$SRC/res/." "$RES/"

# Fond de demarrage uni (remplace le logo Capacitor) : tous les splash.png
find "$RES" -name 'splash.png' -exec cp "$SRC/splash.png" {} \;

# Ancienne couleur de fond d'icone (inutilisee maintenant mais gardee coherente)
if [ -f "$RES/values/ic_launcher_background.xml" ]; then
  sed -i 's/#FFFFFF/#5B2FA0/I' "$RES/values/ic_launcher_background.xml"
fi

# Orientation portrait
MAN=android/app/src/main/AndroidManifest.xml
if ! grep -q 'screenOrientation' "$MAN"; then
  sed -i 's#android:name=".MainActivity"#android:name=".MainActivity"\n            android:screenOrientation="portrait"#' "$MAN"
fi
echo "Android project customised."
