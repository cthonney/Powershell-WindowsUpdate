# Script d'Automatisation des Mises à Jour Windows

Ce script PowerShell permet de rechercher, télécharger et installer automatiquement les mises à jour de Windows. Il a été conçu pour être simple à utiliser et fournir des informations claires sur sa progression.

## ✨ Fonctionnalités

-   **Vérification Automatique** : Le script vérifie si le module `PSWindowsUpdate` est installé et l'installe si ce n'est pas le cas.
-   **Messages Clairs** : Affiche des messages d'état colorés pour chaque étape du processus.
-   **Installation Complète** : Accepte automatiquement toutes les mises à jour proposées pour une installation sans surveillance.
-   **Redémarrage Automatique** : Si une mise à jour requiert un redémarrage, le script le gérera automatiquement.
-   **Fenêtre Persistante** : La fenêtre PowerShell ne se ferme pas à la fin du script, vous laissant le temps de consulter tous les messages.

## ⚙️ Prérequis

-   **Windows PowerShell 5.1** ou une version ultérieure.
-   Une **connexion Internet** pour télécharger le module et les mises à jour.
-   Des **droits d'administrateur** pour installer le module et les mises à jour système.

---

## 🚀 Méthodes d'Exécution

Vous avez deux options pour lancer le script.

### Option 1 : Exécution Directe depuis GitHub (Recommandée)

Vous pouvez exécuter le script directement depuis GitHub sans avoir à télécharger de fichier.

1.  **Ouvrez PowerShell en tant qu'administrateur**. (Cherchez "PowerShell", faites un clic droit, et sélectionnez "Exécuter en tant qu'administrateur").

2.  **Copiez et collez la commande ci-dessous** dans la fenêtre PowerShell, puis appuyez sur `Entrée`.

    **Important** : Remplacez l'URL de l'exemple par l'URL "Raw" de votre propre script sur GitHub.

    ```powershell
    iex (irm '[https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1](https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1)')
    ```

    * `irm` (Invoke-RestMethod) télécharge le contenu du script.
    * `iex` (Invoke-Expression) exécute le script téléchargé.

### Option 2 : Exécution Locale

1.  **Téléchargez le script** :
    -   Cliquez sur le fichier `Update-Windows.ps1` dans ce dépôt.
    -   Cliquez sur le bouton "Raw" ou "Download".
    -   Enregistrez le fichier sur votre ordinateur.

2.  **Exécutez le script en tant qu'administrateur** :
    -   Faites un clic droit sur le fichier `Update-Windows.ps1` que vous avez sauvegardé.
    -   Sélectionnez "**Exécuter avec PowerShell**".

---

## ⚠️ Important

-   **Redémarrage** : Le paramètre `-AutoReboot` redémarrera votre ordinateur automatiquement si une mise à jour l'exige. **Assurez-vous de sauvegarder tout votre travail avant de lancer le script.**
-   **Politique d'exécution** : La méthode d'exécution directe depuis GitHub contourne la politique d'exécution locale. Si vous utilisez la méthode locale et rencontrez des erreurs, vous devrez peut-être exécuter cette commande dans un terminal PowerShell administrateur : `Set-ExecutionPolicy RemoteSigned`.
