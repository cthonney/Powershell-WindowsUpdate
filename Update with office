# Vérifier si le module PSWindowsUpdate est installé, sinon l'installer
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "Le module PSWindowsUpdate n'est pas installé. Tentative d'installation..."
    try {
        Install-Module -Name PSWindowsUpdate -Force -Confirm:$false -Scope AllUsers
        Write-Host "Le module PSWindowsUpdate a été installé avec succès."
    }
    catch {
        Write-Error "Échec de l'installation du module PSWindowsUpdate. Veuillez l'installer manuellement ou exécuter ce script avec des privilèges administrateur si ce n'est pas le cas."
        exit
    }
}
else {
    Write-Host "Le module PSWindowsUpdate est déjà installé."
}

# Importer le module (nécessaire pour utiliser ses cmdlets)
Import-Module PSWindowsUpdate

# --- Configuration des options ---

# Redémarrage automatique si nécessaire.
# True : Le système redémarrera automatiquement après les mises à jour si un redémarrage est requis.
# False : Le système ne redémarrera pas automatiquement. Une notification sera affichée.
$AutoReboot = $true

# Inclure les mises à jour des produits Microsoft (ex: Office).
# True : Les mises à jour pour d'autres produits Microsoft seront également installées.
# False : Seules les mises à jour Windows OS seront installées.
$IncludeMicrosoftProducts = $true

# --- Début du processus de mise à jour ---

Write-Host "`n--- Démarrage de la recherche de mises à jour Windows ---"

try {
    # Rechercher les mises à jour disponibles
    Write-Host "Recherche des mises à jour disponibles..."
    $updates = Get-WUList -MicrosoftUpdate:$IncludeMicrosoftProducts -ErrorAction Stop

    if ($updates -eq $null -or $updates.Count -eq 0) {
        Write-Host "Aucune mise à jour disponible."
    }
    else {
        Write-Host "Mises à jour trouvées :"
        $updates | Format-Table -AutoSize

        # Télécharger et installer les mises à jour
        Write-Host "`n--- Démarrage du téléchargement et de l'installation des mises à jour ---"
        # Utilise -AcceptAll pour accepter automatiquement toutes les conditions de licence
        # Utilise -AutoReboot pour redémarrer si $AutoReboot est vrai
        # Utilise -MicrosoftUpdate pour inclure les mises à jour Microsoft si $IncludeMicrosoftProducts est vrai
        Install-WUUpdate -AcceptAll -AutoReboot:$AutoReboot -MicrosoftUpdate:$IncludeMicrosoftProducts -Verbose -ErrorAction Stop

        Write-Host "`n--- Processus de mise à jour terminé. ---"

        # Vérifier si un redémarrage est en attente
        if (Test-PendingReboot) {
            Write-Host "Un redémarrage est en attente pour finaliser l'installation des mises à jour."
            if (-not $AutoReboot) {
                Write-Host "Le redémarrage automatique est désactivé. Veuillez redémarrer le système manuellement."
            }
        }
        else {
            Write-Host "Aucun redémarrage en attente."
        }
    }
}
catch {
    Write-Error "Une erreur s'est produite lors du processus de mise à jour : $($_.Exception.Message)"
}

Write-Host "`nScript terminé."
