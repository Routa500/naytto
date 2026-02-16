# yhteinen.ps1
# Tämä tiedosto sisältää yhteiset funktiot, joita muut skriptit käyttävät

# New-Item luo uusia kohteita (tässä kansioita)
# -ItemType Directory = luodaan kansio
# -Force = ei virhettä, vaikka kansio olisi jo olemassa
# Out-Null = estää PowerShelliä tulostamasta ylimääräistä tekstiä
New-Item -ItemType Directory -Force lokit, raportit, backup | Out-Null


# Funktio Loki
# Kirjoittaa viestin lokitiedostoon
function Loki($teksti) {

    # Get-Date hakee nykyisen ajan
    # -Format määrittää ajan muodon
    # Add-Content lisää tekstin tiedoston loppuun
    Add-Content "lokit\loki.txt" "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - $teksti"
}


# Funktio Raportti
# Kirjoittaa viestin raporttitiedostoon
function Raportti($teksti) {

    # Raportti tallennetaan raportit-kansioon
    Add-Content "raportit\levyraportti.txt" $teksti
}

