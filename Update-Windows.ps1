<#
.SYNOPSIS
    Automatise la recherche, le téléchargement et l'installation des mises à jour Windows.
.DESCRIPTION
    Ce script utilise le module PSWindowsUpdate pour gérer le processus de mise à jour de Windows.
    Il vérifie d'abord si le module est installé, l'installe si nécessaire, puis procède à l'installation des mises à jour.
    Des messages d'état sont affichés tout au long du processus.
.NOTES
    Auteur: Gemini
    Version: 1.0
    Date: 2025-07-11
#>

# Forcer la politique d'exécution pour le processus actuel afin de permettre l'exécution du script
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

# --- Début du Script ---

# Message de bienvenue
Write-Host "===============================================" -ForegroundColor Green
Write-Host "  Script de mise à jour automatique de Windows " -ForegroundColor Green
Write-Host "==============================================="
Write-Host

# Étape 1: Vérifier et installer le module PSWindowsUpdate
Write-Host "[ÉTAPE 1/4] Vérification du module 'PSWindowsUpdate'..." -ForegroundColor Cyan

# Vérifier si le module est installé
if (Get-Module -ListAvailable -Name PSWindowsUpdate) {
    Write-Host " -> Le module 'PSWindowsUpdate' est déjà installé." -ForegroundColor Green
} else {
    Write-Host " -> Le module 'PSWindowsUpdate' n'est pas trouvé. Tentative d'installation..." -ForegroundColor Yellow
    try {
        # Installer le module sans confirmation manuelle
        Install-Module -Name PSWindowsUpdate -Force -AcceptLicense -Confirm:$false
        Write-Host " -> Le module 'PSWindowsUpdate' a été installé avec succès." -ForegroundColor Green
    } catch {
        Write-Host " -> ERREUR: Impossible d'installer le module 'PSWindowsUpdate'. Veuillez vérifier votre connexion Internet ou l'exécuter en tant qu'administrateur." -ForegroundColor Red
        # Pause pour que l'utilisateur puisse lire le message avant de fermer
        Write-Host "Appuyez sur Entrée pour quitter."
        Read-Host
        Exit
    }
}
Write-Host

# Étape 2: Importer le module
Write-Host "[ÉTAPE 2/4] Importation du module 'PSWindowsUpdate'..." -ForegroundColor Cyan
try {
    Import-Module PSWindowsUpdate -ErrorAction Stop
    Write-Host " -> Module importé avec succès." -ForegroundColor Green
} catch {
    Write-Host " -> ERREUR: Impossible d'importer le module 'PSWindowsUpdate'." -ForegroundColor Red
    Write-Host "Appuyez sur Entrée pour quitter."
    Read-Host
    Exit
}
Write-Host

# Étape 3: Rechercher, télécharger et installer les mises à jour
Write-Host "[ÉTAPE 3/4] Recherche, téléchargement et installation des mises à jour..." -ForegroundColor Cyan
Write-Host "Cette opération peut prendre beaucoup de temps. Veuillez patienter..." -ForegroundColor Yellow

# Obtenir les mises à jour. L'option -AcceptAll accepte toutes les mises à jour, et -AutoReboot redémarre si nécessaire.
# Utilisez Get-WindowsUpdate -Install -Verbose pour plus de détails.
Get-WindowsUpdate -Install -AcceptAll -AutoReboot -Verbose

Write-Host " -> Processus de mise à jour terminé." -ForegroundColor Green
Write-Host

# Étape 4: Fin du script
Write-Host "[ÉTAPE 4/4] Toutes les opérations sont terminées." -ForegroundColor Cyan
Write-Host "==============================================="
Write-Host

# Empêcher la fermeture automatique de la fenêtre
Write-Host "Le script a terminé son exécution."
Write-Host "Vous pouvez maintenant fermer cette fenêtre manuellement ou appuyer sur Entrée." -ForegroundColor Yellow
Read-Host
