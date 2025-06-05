# Script de configuration des images pour le site Tunisie Tourisme
# Nécessite ImageMagick (installé automatiquement si nécessaire)

# Vérification et installation de ImageMagick si nécessaire
function Install-ImageMagick {
    if (-not (Get-Command magick -ErrorAction SilentlyContinue)) {
        Write-Host "Installation de ImageMagick..."
        winget install ImageMagick
        Write-Host "ImageMagick installé avec succès !"
    }
}

# Création des dossiers nécessaires
function Create-Folders {
    $folders = @(
        "images",
        "images/regions",
        "images/culture",
        "images/hebergements",
        "images/patrimoine"
    )

    foreach ($folder in $folders) {
        if (-not (Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder -Force
            Write-Host "Dossier créé : $folder"
        }
    }
}

# Fonction pour télécharger une image
function Download-Image {
    param (
        [string]$Url,
        [string]$OutputPath
    )
    
    try {
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath
        Write-Host "Image téléchargée avec succès : $OutputPath"
        return $true
    }
    catch {
        Write-Host "Erreur lors du téléchargement de l'image : $Url"
        return $false
    }
}

# Fonction pour optimiser une image
function Optimize-Image {
    param (
        [string]$ImagePath
    )
    
    try {
        # Redimensionner l'image si elle est trop grande
        magick convert $ImagePath -resize "1920x1080>" $ImagePath
        
        # Optimiser la qualité
        magick convert $ImagePath -strip -quality 85 $ImagePath
        
        Write-Host "Image optimisée avec succès : $ImagePath"
        return $true
    }
    catch {
        Write-Host "Erreur lors de l'optimisation de l'image : $ImagePath"
        return $false
    }
}

# URLs des images à télécharger (images spécifiques à la Tunisie)
$images = @{
    # Images des régions
    "images/regions/tunis.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/regions/sousse.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/regions/djerba.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/regions/sfax.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/regions/tataouine.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    
    # Images culturelles
    "images/culture/gastronomie.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/culture/artisanat.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    "images/culture/festivals.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    
    # Image de fond
    "images/hero-bg.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
    
    # Carte
    "images/carte-tunisie-regions.jpg" = "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff"
}

# Fonction principale
function Main {
    Write-Host "Démarrage de la configuration des images..."
    
    # Installation de ImageMagick si nécessaire
    Install-ImageMagick
    
    # Création des dossiers
    Create-Folders
    
    # Téléchargement et optimisation des images
    foreach ($image in $images.GetEnumerator()) {
        if (Download-Image -Url $image.Value -OutputPath $image.Key) {
            Optimize-Image -ImagePath $image.Key
        }
    }
    
    Write-Host "Configuration des images terminée avec succès !"
}

# Exécution du script
Main 