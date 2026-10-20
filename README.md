# Kajy Vola — application Android (APK)

Dossier prêt à être compilé sur GitHub. Le fichier APK est fabriqué automatiquement par GitHub Actions (Capacitor + Gradle), sans rien installer sur le téléphone ou l'ordinateur.

## Contenu

| Élément | Rôle |
|---|---|
| `www/index.html` | L'application Kajy Vola (un seul fichier) |
| `capacitor.config.json` | Nom (Kajy Vola) et identifiant (`com.ryahdyfi.kajyvola`) |
| `package.json` | Dépendances Capacitor (dont Fichiers et Partage pour l'export PDF/JSON) |
| `resources/` | Icône (ancienne, ronde, adaptative), fond de démarrage |
| `scripts/apply-android.sh` | Applique l'icône, le fond de démarrage et l'orientation portrait |
| `.github/workflows/android.yml` | La compilation automatique |

## Compiler sur GitHub

1. Créez un dépôt GitHub (par exemple `kajy-vola`) et envoyez-y **tout le contenu** de ce dossier (y compris le dossier caché `.github`).
2. Ouvrez l'onglet **Actions** du dépôt. La compilation démarre à chaque envoi sur `main` ou `master`. On peut aussi la lancer à la main avec **Run workflow**.
3. Quand elle est terminée (environ 5 à 8 minutes), ouvrez l'exécution et téléchargez **kajy-vola-apk** dans « Artifacts » : vous obtenez `kajy-vola.apk`.
4. Copiez l'APK sur le téléphone et installez-le (autorisez l'installation depuis cette source si Android le demande).

Pour publier une version téléchargeable directement : créez un tag `v1.0.0`. L'APK sera alors joint automatiquement à la « Release » du dépôt.

## Mettre à jour l'application

Remplacez `www/index.html` par la nouvelle version, puis envoyez le changement sur GitHub : un nouvel APK est compilé.

## Notes

- Sans secrets, l'APK est en mode **debug** (il s'installe, mais n'est pas signé pour de bon). Avec les 3 secrets ci-dessous, l'APK est une version **release signée**.
- Les données (valeurs saisies, profils, historique) restent dans le téléphone (stockage local de l'appli).
- Export PDF/JSON : la feuille de partage Android s'ouvre pour enregistrer (Drive, Fichiers…) ou envoyer le fichier.
- Pour changer l'icône : remplacez les images dans `resources/android/res/`.

## Version signée

1. Dans GitHub : **Settings → Secrets and variables → Actions → New repository secret**.
2. Créez ces 3 secrets (valeurs dans `SIGNATURE-INFO.txt`, fourni à part) :
   - `KEYSTORE_BASE64` : tout le contenu de `keystore-base64.txt`
   - `KEYSTORE_PASSWORD` : le mot de passe
   - `KEY_ALIAS` : `kajyvola`
3. Relancez la compilation (**Actions → Run workflow**). Le journal affiche la signature vérifiée (« Signed release build »).

À savoir :
- **Gardez `kajy-vola.keystore` en lieu sûr** (ne le mettez jamais dans le dépôt). Toutes les futures mises à jour devront être signées avec le même fichier.
- Une version signée ne peut pas se « mettre à jour par-dessus » une version debug : désinstallez d'abord l'ancienne. Pensez à exporter vos données (Menu → Fitehirizana → JSON) avant.
