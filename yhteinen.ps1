<#
.SYNOPSIS
Yhteiset funktiot lokitusta ja raportointia varten.

.NOTES
Tekijä: Aaron S23ÄTIV
#>

# Loki-funktio: lisää lokimerkinnän log.txt-tiedostoon
function Loki($Viesti) {
    # Hae nykyinen aikaleima
    $aika = Get-Date -Format "yyyy-MM-dd HH.mm.ss"
    $Polku = ".\log.txt"
    $Teksti = "$aika - $Viesti"
    # Lisää lokimerkintä tiedoston loppuun
    Add-Content -Path $Polku -Value $Teksti
}

# Raportti-funktio: lisää rivin raportti.txt-tiedostoon
function Raportti($Viesti) {
    $Polku = ".\raportti.txt"
    Add-Content -Path $Polku -Value $Viesti
}
