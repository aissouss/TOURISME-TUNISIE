# Création des dossiers nécessaires
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
    }
    catch {
        Write-Host "Erreur lors du téléchargement de l'image : $Url"
    }
}

# URLs des images à télécharger
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

# Téléchargement des images
foreach ($image in $images.GetEnumerator()) {
    Download-Image -Url $image.Value -OutputPath $image.Key
}

Write-Host "Téléchargement des images terminé !" 