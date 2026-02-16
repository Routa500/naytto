# yhteinen.ps1
# Tämä tiedosto sisältää yhteiset funktiot, joita muut skriptit käyttävät
# Kaikki kansiot luodaan automaattisesti, jos niitä ei ole

# ===========================
# 1) Luodaan tarvittavat kansiot
# ===========================
# Tarvittavat kansiot: lokit, raportit ja backup
$Kansiot = @("lokit", "raportit", "backup")

foreach ($kansio in $Kansiot) {
    # Test-Path tarkistaa, onko kansio olemassa
    if (-not (Test-Path $kansio)) {
        # New-Item luo kansion
        # -ItemType Directory = luodaan kansio
        # -Force = ei virhettä, vaikka kansio olisi jo olemassa
        # Out-Null estää ylimääräisen tulostuksen
        New-Item -ItemType Directory -Path $kansio -Force | Out-Null
        # Näytetään viesti konsoliin, että kansio luotiin
        Write-Host "Kansio luotu: $kansio" -ForegroundColor Green
    }
}

# ===========================
# 2) Funktio Loki
# ===========================
# Kirjoittaa viestin lokitiedostoon ja myös konsoliin
function Loki($teksti) {
    $lokitiedosto = "lokit\loki.txt"

    # Varmistetaan, että lokikansio on olemassa ennen kirjoitusta
    if (-not (Test-Path "lokit")) {
        New-Item -ItemType Directory -Path "lokit" -Force | Out-Null
    }

    # Add-Content lisää tekstin tiedoston loppuun
    # $(Get-Date -Format 'yyyy-MM-dd HH:mm') lisää aikaleiman
    Add-Content $lokitiedosto "$(Get-Date -Format 'yyyy-MM-dd HH:mm') - $teksti"

    # Tulostetaan viesti myös konsoliin
    Write-Host $teksti
}

# ===========================
# 3) Funktio Raportti
# ===========================
# Kirjoittaa viestin raporttitiedostoon
function Raportti($teksti) {
    $raporttitiedosto = "raportit\levyraportti.txt"

    # Varmistetaan, että raporttikansio on olemassa ennen kirjoitusta
    if (-not (Test-Path "raportit")) {
        New-Item -ItemType Directory -Path "raportit" -Force | Out-Null
    }

    # Add-Content lisää tekstin raporttitiedoston loppuun
    Add-Content $raporttitiedosto $teksti
}

function Puhdistus() {
    $TempPolku = $env:TEMP
    Loki "Temp-kansion puhdistus alkaa. Polku: $TempPolku"

    $KaikkiTiedostot = Get-ChildItem -Path $TempPolku -Recurse -File
    $vanhatTiedostot = $KaikkiTiedostot | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) }

    if ($vanhatTiedostot.Count -gt 0) {
        Loki "Löytyi $($vanhatTiedostot.Count) poistettavaa tiedostoa."

        foreach ($tiedosto in $vanhatTiedostot) {
            try {
                Remove-Item $tiedosto.FullName -Force -ErrorAction Stop
                Loki "Poistettiin vanha tiedosto: $($tiedosto.FullName)"
            } catch {
                Loki "Virhe poistaessa tiedostoa: $($tiedosto.FullName) - $_"
            }
        }

        Loki "Temp-kansion puhdistus valmis. Poistettu $($vanhatTiedostot.Count) tiedostoa."
    }
    else {
        Loki "Temp-kansiossa ei ollut poistettavia tiedostoja."
    }
}
