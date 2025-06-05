# Nécessite l'installation de ImageMagick
# Installer avec : winget install ImageMagick

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
    }
    catch {
        Write-Host "Erreur lors de l'optimisation de l'image : $ImagePath"
    }
}

# Dossiers à traiter
$folders = @(
    "images/regions",
    "images/culture",
    "images/hebergements",
    "images/patrimoine"
)

# Optimisation des images
foreach ($folder in $folders) {
    if (Test-Path $folder) {
        $images = Get-ChildItem -Path $folder -Filter "*.jpg"
        foreach ($image in $images) {
            Optimize-Image -ImagePath $image.FullName
        }
    }
}

Write-Host "Optimisation des images terminée !" 