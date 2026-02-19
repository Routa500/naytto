<#
.SYNOPSIS
Puhdistaa käyttäjän TEMP-kansion.

.DESCRIPTION
Poistaa tiedostot, jotka ovat vanhempia kuin 7 päivää.
Kirjaa jokaisen poiston ja mahdolliset virheet lokiin.

.NOTES
Tekijä: Aaron S23ÄTIV
#>

# Ladataan yhteiset funktiot (Loki() lokitusta varten)
. .\yhteinen.ps1  

function Puhdistus {
    # Hae TEMP-kansion polku ympäristömuuttujasta
    $TempPolku = $env:TEMP
    Loki "Temp-kansion puhdistus alkaa. Polku: $TempPolku"

    # Hae kaikki tiedostot TEMP-kansiosta ja sen alikansioista
    # -Recurse: sisällyttää alikansiot
    # -File: vain tiedostot, ei kansioita
    $KaikkiTiedostot = Get-ChildItem -Path $TempPolku -Recurse -File

    # Suodatetaan tiedostot, jotka ovat vanhempia kuin 7 päivää
    $vanhatTiedostot = $KaikkiTiedostot | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }

    if ($vanhatTiedostot.Count -gt 0) {
        Loki "Löytyi $($vanhatTiedostot.Count) poistettavaa tiedostoa."

        foreach ($tiedosto in $vanhatTiedostot) {
            try {
                # Poistetaan tiedosto
                # -Force: myös suojatut tiedostot
                # -ErrorAction Stop: siirtyy catch-lohkoon virheen sattuessa
                Remove-Item $tiedosto.FullName -Force -ErrorAction Stop
                Loki "Poistettiin vanha tiedosto: $($tiedosto.FullName)"
            } catch {
                # Jos tiedoston poisto epäonnistuu
                Loki "Virhe poistaessa tiedostoa: $($tiedosto.FullName) - $_"
            }
        }

        Loki "Temp-kansion puhdistus valmis. Poistettu $($vanhatTiedostot.Count) tiedostoa."
    } else {
        # Ei löytynyt poistettavia tiedostoja
        Loki "Temp-kansiossa ei ollut poistettavia tiedostoja."
    }
}
