# Windows Update Automation Script

---

## Description

Ce dépôt contient un script PowerShell conçu pour automatiser le processus de recherche, de téléchargement et d'installation des mises à jour Windows et des produits Microsoft associés. Il utilise le module `PSWindowsUpdate` pour une gestion simplifiée des mises à jour système.

Le script permet de :
- Vérifier et installer automatiquement le module `PSWindowsUpdate` si nécessaire.
- Rechercher les mises à jour disponibles pour Windows et les produits Microsoft (Office, SQL Server, etc.).
- Télécharger et installer ces mises à jour.
- Gérer le redémarrage automatique du système si un redémarrage est requis après l'installation des mises à jour.

---

## Prérequis

Pour que ce script fonctionne correctement, vous devez disposer de :

-   **Windows PowerShell 5.1 ou supérieur** (généralement inclus par défaut sur les versions récentes de Windows).
-   Une **connexion Internet** active pour télécharger les mises à jour et le module `PSWindowsUpdate`.
-   Des **droits d'administrateur** pour exécuter le script, car il effectue des opérations système et peut installer des modules.

---

## Utilisation

Vous avez plusieurs options pour utiliser ce script :

### Option 1 : Télécharger et exécuter le script directement depuis PowerShell (Recommandé pour l'automatisation)

Cette méthode est pratique pour une exécution rapide ou pour l'intégration dans des tâches automatisées, mais elle nécessite une **compréhension des risques de sécurité**. L'exécution directe de scripts depuis internet peut être dangereuse si la source n'est pas fiable. **Assurez-vous toujours de faire confiance au script et à son origine.**

1.  **URL Raw du script :**
    Le script `Update-Windows.ps1` est disponible à l'adresse raw suivante :
    `https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1`

2.  **Exécutez la commande dans PowerShell (en tant qu'administrateur) :**

    Ouvrez PowerShell **en tant qu'administrateur** et exécutez la commande suivante :

    ```powershell
    # Définir l'URL du script
    $scriptUrl = "[https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1](https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1)"

    # Télécharger le script et l'exécuter directement en mémoire
    # ATTENTION : L'utilisation de Invoke-Expression (iex) exécute le code téléchargé.
    # N'utilisez cette méthode qu'avec des sources fiables.
    Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing | Invoke-Expression
    ```

    **Alternative (commande unique avec gestion de la politique d'exécution) :**

    ```powershell
    # Définir l'URL du script
    $scriptUrl = "[https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1](https://raw.githubusercontent.com/cthonney/Powershell-WindowsUpdate/refs/heads/master/Update-Windows.ps1)"

    # Lance une nouvelle instance de PowerShell, contourne la politique d'exécution pour cette session,
    # puis télécharge et exécute le script.
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& {Invoke-WebRequest -Uri '$scriptUrl' -UseBasicParsing | Invoke-Expression}"
    ```

### Option 2 : Télécharger le dépôt en ZIP

Cette méthode est simple et ne nécessite pas Git.

1.  **Téléchargez le script :**
    Rendez-vous sur la page principale de ce dépôt GitHub : [https://github.com/cthonney/Powershell-WindowsUpdate](https://github.com/cthonney/Powershell-WindowsUpdate)
    Cliquez sur le bouton vert **"Code"**, puis sélectionnez **"Download ZIP"**.
    Une fois le fichier ZIP téléchargé, extrayez son contenu dans un dossier de votre choix (par exemple, `C:\Scripts\WindowsUpdate`).

2.  **Exécutez le script en tant qu'administrateur :**
    Ouvrez PowerShell en tant qu'administrateur (clic droit sur l'icône PowerShell > "Exécuter en tant qu'administrateur"), naviguez jusqu'au répertoire où vous avez sauvegardé le script, puis exécutez-le :

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force # Peut être nécessaire si non déjà fait
    .\Update-Windows.ps1
    ```

### Option 3 : Cloner le dépôt avec Git

Si vous utilisez Git, c'est la méthode recommandée pour maintenir le script à jour.

1.  **Clonez le dépôt :**
    ```bash
    git clone [https://github.com/cthonney/Powershell-WindowsUpdate.git](https://github.com/cthonney/Powershell-WindowsUpdate.git)
    cd Powershell-WindowsUpdate
    ```

2.  **Exécutez le script en tant qu'administrateur :**
    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force # Peut être nécessaire si non déjà fait
    .\Update-Windows.ps1
    ```

---

### Options de configuration dans le script :

Vous pouvez modifier le comportement du script en ajustant les variables suivantes au début du fichier `Update-Windows.ps1` :

-   `$AutoReboot = $true` : Définit si le système doit redémarrer automatiquement après les mises à jour si un redémarrage est requis. Changez en `$false` pour désactiver le redémarrage automatique.
-   `$IncludeMicrosoftProducts = $true` : Inclut les mises à jour pour d'autres produits Microsoft (comme Office). Changez en `$false` pour n'installer que les mises à jour Windows OS.

---

## Automatisation avec le Planificateur de Tâches Windows

Pour automatiser l'exécution de ce script à intervalles réguliers, vous pouvez utiliser le **Planificateur de Tâches Windows** :

1.  Ouvrez le **Planificateur de Tâches** (recherchez `taskschd.msc`).
2.  Dans le volet "Actions" à droite, cliquez sur **"Créer une tâche de base..."**.
3.  **Nom** : Donnez un nom descriptif (ex: `Mises à jour Windows Automatiques`).
4.  **Déclencheur** : Choisissez la fréquence souhaitée (ex: `Hebdomadaire`, `Mensuel`).
5.  **Action** : Sélectionnez **"Démarrer un programme"**.
6.  **Programme/script** : Entrez `powershell.exe`.
7.  **Ajouter des arguments (facultatif)** : Collez la ligne suivante, en ajustant le chemin du script si vous avez choisi l'option 2 ou 3 :
    ```
    -NoProfile -ExecutionPolicy Bypass -File "C:\Chemin\Vers\Votre\Script\Update-Windows.ps1"
    ```
    (Remplacez `C:\Chemin\Vers\Votre\Script\Update-Windows.ps1` par le chemin réel de votre script).
    *Si vous utilisez l'option de téléchargement direct (Option 1), vous pouvez adapter les arguments pour appeler la commande `Invoke-WebRequest | Invoke-Expression` à la place du chemin de fichier.*

8.  Cliquez sur `Suivant`, puis sur `Terminer`.
9.  **Très important :** Double-cliquez sur la tâche que vous venez de créer, allez dans l'onglet **"Général"** et cochez la case **"Exécuter avec les privilèges les plus élevés"** pour assurer que le script dispose des permissions nécessaires.

---

## Contribution

Les contributions sont les bienvenues ! Si vous avez des suggestions d'amélioration, des corrections de bugs ou de nouvelles fonctionnalités, n'hésitez pas à ouvrir une issue ou à soumettre une Pull Request.

---

## Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.
