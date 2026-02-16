# levytila.ps1
# Tämä skripti tarkistaa C-aseman vapaan levytilan

# . .\yhteinen.ps1 tarkoittaa:
# Ladataan yhteinen.ps1 tiedoston funktiot tähän skriptiin
. .\yhteinen.ps1


# Funktio Levytila
# Tarkistaa levytilan ja kirjaa tuloksen
function Levytila {

    # try/catch estää ohjelmaa kaatumasta virheeseen
    try {

        # Get-PSDrive C hakee C-aseman tiedot
        # .Free kertoo vapaan tilan tavuina
        $vapaa = (Get-PSDrive C).Free

        # / 1GB muuntaa tavut gigatavuiksi
        # Round pyöristää arvon selkeämmäksi
        $vapaaGB = [math]::Round($vapaa / 1GB, 1)

        # Kirjoitetaan tulos lokiin
        Loki "Levytila tarkistettu: Vapaana $vapaaGB GB"

        # Kirjoitetaan tulos raporttiin
        Raportti "C-asema: Vapaana $vapaaGB GB"
    }
    catch {
        # Jos virhe tapahtuu, ohjelma ei kaadu
        # Virhe kirjataan lokiin
        Loki "Virhe: levytilaa ei saatu luettua"
    }
}
