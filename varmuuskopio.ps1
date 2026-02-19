<#
.SYNOPSIS
Tee varmuuskopio annetusta kansiosta.

.DESCRIPTION
Kopioi kansion sisällön backup-hakemistoon, luo kansio tarvittaessa.
Kirjaa lokiin ja ruudulle onnistumiset ja virheet.

.NOTES
Tekijä: Aaron S23ÄTIV
#>

# Lataa Loki()-funktio
. .\yhteinen.ps1

function Varmuuskopio($Kansio) {
    # Tarkista, löytyykö annettu kansio
    if (-not (Test-Path $Kansio)) {
        Loki "Annettua kansiota ei löydy: $Kansio"
        Write-Host "Annettua kansiota ei löydy: $Kansio" -ForegroundColor Red
        throw "Annettua kansiota ei löydy: $Kansio"
    }

    try {
        # Luo backup-polku aikaleimalla
        $BackupPolku = "C:\naytto\varmuuskopiot\backup_" + (Get-Date -Format "yyyyMMdd_HHmmss")
        # Luo hakemisto, jos sitä ei ole
        if (-not (Test-Path $BackupPolku)) { New-Item -ItemType Directory -Path $BackupPolku | Out-Null }

        # Kopioi kansio backup-polkuun
        # -Recurse: myös alikansiot
        # -Force: päällekirjoitus sallittu
        Copy-Item $Kansio $BackupPolku -Recurse -Force

        # Onnistuminen lokiin ja ruudulle
        Loki "Varmuuskopiointi onnistui: $Kansio -> $BackupPolku"
        Write-Host "Varmuuskopiointi onnistui: $Kansio -> $BackupPolku" -ForegroundColor Green
    } catch {
        # Virheenkäsittely
        Loki "Virhe varmuuskopioinnissa: $_"
        Write-Host "Varmuuskopiointi epäonnistui: $Kansio" -ForegroundColor Red
    }
}
