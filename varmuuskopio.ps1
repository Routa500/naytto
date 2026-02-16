# varmuuskopio.ps1
# Tämä skripti tekee varmuuskopion annetusta kansiosta

# Ladataan yhteiset funktiot
. .\yhteinen.ps1


# Funktio Varmuuskopio
# Saa parametrina kansion nimen
function Varmuuskopio($kansio) {

    # Test-Path tarkistaa löytyykö tiedosto tai kansio
    # ! tarkoittaa EI (negatiivinen ehto)
    # !(Test-Path ...) = kansiota EI ole olemassa
    if (!(Test-Path $kansio)) {

        # Jos kansio puuttuu, kirjataan virhe
        Loki "Virhe: kansiota ei loydy ($kansio)"

        # Write-Host tulostaa viestin ruudulle
        Write-Host "Kansiota ei loydy: $kansio" -ForegroundColor Red

        # return lopettaa funktion suorittamisen
        return
    }

    # Yritetään varmuuskopiointia
    try {

        # Copy-Item kopioi tiedostoja ja kansioita
        # -Recurse = kopioi myos alikansiot
        # -Force = sallii paallekirjoituksen
        Copy-Item $kansio "backup\" -Recurse -Force

        # Onnistuminen kirjataan lokiin
        Loki "Varmuuskopio tehty kansiosta: $kansio"

        # Tulostetaan onnistuminen ruudulle
        Write-Host "Varmuuskopiointi onnistui: $kansio" -ForegroundColor Green
    }
    catch {
        # Jos virhe tapahtuu, se kirjataan lokiin
        Loki "Virhe: varmuuskopiointi epaonnistui"

        # Tulostetaan virhe ruudulle
        Write-Host "Varmuuskopiointi epaonnistui" -ForegroundColor Red
    }
}
