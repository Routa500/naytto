<#
.SYNOPSIS
Tarkistaa C-aseman vapaan levytilan.

.DESCRIPTION
Kirjaa lokiin ja raporttiin vapaana olevan tilan gigatavuina.

.NOTES
Tekijä: Aaron S23ÄTIV
#>

# Ladataan yhteiset funktiot (Loki ja Raportti)
. .\yhteinen.ps1

function Levytila {
    try {
        # Hae vapaa tila C-asemalta
        $vapaa = (Get-PSDrive C).Free
        # Muunna tavut gigatavuiksi ja pyöristä 1 desimaaliin
        $vapaaGB = [math]::Round($vapaa / 1GB, 1)

        # Kirjaa lokiin
        Loki "Levytila tarkistettu: Vapaana $vapaaGB GB"
        # Kirjaa raporttiin
        Raportti "C-asema: Vapaana $vapaaGB GB"
    } catch {
        # Jos virhe tapahtuu, kirjataan lokiin
        Loki "KRIITTINEN VIRHE: levytilaa ei saatu luettua - $_"
    }
}
