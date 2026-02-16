# puhdistus.ps1
# Tämä skripti puhdistaa käyttäjän väliaikaistiedostot (Temp-kansion)
# Kommentit selittävät jokaisen rivin tarkoituksen

# Ladataan yhteiset funktiot (tässä Loki() lokitusta varten)
. .\yhteinen.ps1

# Temp-kansion polku käyttäjäkohtaisesti
# $env:TEMP on PowerShellin tapa hakea ympäristömuuttuja TEMP
$TempPolku = $env:TEMP
Loki "Temp-kansion puhdistus alkaa. Polku: $TempPolku"

# Haetaan kaikki tiedostot Temp-kansiosta ja sen alikansioista
# -Recurse: etsii myös alikansiot
# -File: valitsee vain tiedostot (ei kansioita)
$KaikkiTiedostot = Get-ChildItem -Path $TempPolku -Recurse -File

# Suodatetaan tiedostot, jotka ovat vanhempia kuin 7 päivää
# $_ viittaa nykyiseen käsiteltävään tiedostoon listassa
# LastWriteTime kertoo milloin tiedostoa on viimeksi muokattu
$vanhatTiedostot = $KaikkiTiedostot | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }

# Tarkistetaan löytyikö poistettavia tiedostoja
if ($vanhatTiedostot.Count -gt 0) {
    Loki "Löytyi $($vanhatTiedostot.Count) poistettavaa tiedostoa."
    
    # Käydään jokainen poistettava tiedosto läpi
    foreach ($tiedosto in $vanhatTiedostot) {
        try {
            # Poistetaan tiedosto
            # -Force: poistaa myös suojatut tiedostot
            # -ErrorAction Stop: pysäyttää ja siirtyy catch-lohkoon virheen sattuessa
            Remove-Item $tiedosto.FullName -Force -ErrorAction Stop

            # Kirjataan lokiin onnistunut poisto
            Loki "Poistettiin vanha tiedosto: $($tiedosto.FullName)"
        } catch {
            # Jos tiedoston poisto epäonnistuu, kirjataan virheilmoitus lokiin
            Loki "Virhe poistaessa tiedostoa: $($tiedosto.FullName) – $_"
        }
    }

    # Ilmoitetaan, että puhdistus on valmis
    Loki "Temp-kansion puhdistus valmis. Poistettu $($vanhatTiedostot.Count) tiedostoa."
} else {
    # Jos ei löytynyt poistettavia tiedostoja
    Loki "Temp-kansiossa ei ollut poistettavia tiedostoja."
}
