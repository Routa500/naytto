function Puhdistus() {

    # $env:TEMP
    # = PowerShellin ympäristömuuttuja, joka sisältää käyttäjän TEMP-kansion polun
    # Esim. C:\Users\Käyttäjä\AppData\Local\Temp
    $TempPolku = $env:TEMP

    # Loki-funktio kirjoittaa tekstin lokitiedostoon
    # Tässä kerrotaan, että puhdistus alkaa ja mikä kansio käsitellään
    Loki "Temp-kansion puhdistus alkaa. Polku: $TempPolku"


    # Get-ChildItem
    # = hakee tiedostoja ja kansioita annetusta polusta
    #
    # -Path $TempPolku
    # = määrittää mistä kansiosta haku aloitetaan
    #
    # -Recurse
    # = käy myös kaikki alikansiot läpi (rekursiivisesti)
    #
    # -File
    # = palauttaa vain tiedostot (ei kansioita)
    $KaikkiTiedostot = Get-ChildItem -Path $TempPolku -Recurse -File


    # Where-Object
    # = suodattaa objektit annetun ehdon perusteella
    #
    # $_
    # = viittaa käsiteltävään tiedosto-objektiin
    #
    # LastWriteTime
    # = kertoo milloin tiedostoa on viimeksi muokattu
    #
    # (Get-Date)
    # = tämänhetkinen päivämäärä ja aika
    #
    # AddDays(-7)
    # = vähentää nykyisestä päivästä 7 päivää
    #
    # -lt
    # = "less than" eli pienempi kuin
    #
    # Lopputulos:
    # Valitaan tiedostot, joita ei ole muokattu viimeiseen 7 päivään
    $vanhatTiedostot = $KaikkiTiedostot | Where-Object {
        $_.LastWriteTime -lt (Get-Date).AddDays(-7)
    }


    # if-lause
    # Tarkistetaan onko poistettavia tiedostoja löytynyt
    #
    # .Count
    # = kertoo montako objektia kokoelmassa on
    #
    # -gt
    # = "greater than" eli suurempi kuin
    if ($vanhatTiedostot.Count -gt 0) {

        # Kirjoitetaan lokiin kuinka monta tiedostoa aiotaan poistaa
        Loki "Löytyi $($vanhatTiedostot.Count) poistettavaa tiedostoa."


        # foreach-silmukka
        # Käy jokaisen vanhan tiedoston läpi yksi kerrallaan
        foreach ($tiedosto in $vanhatTiedostot) {

            # try-catch
            # = virheenkäsittely
            # try-lohkossa yritetään suorittaa poisto
            # catch-lohko suoritetaan, jos tapahtuu virhe
            try {

                # Remove-Item
                # = poistaa tiedoston tai kansion
                #
                # $tiedosto.FullName
                # = koko tiedoston polku (esim. C:\...\file.tmp)
                #
                # -Force
                # = poistaa myös piilotetut tai suojatut tiedostot
                #
                # -ErrorAction Stop
                # = pakottaa virheen siirtymään catch-lohkoon
                Remove-Item $tiedosto.FullName -Force -ErrorAction Stop

                # Kirjoitetaan lokiin onnistunut poisto
                Loki "Poistettiin vanha tiedosto: $($tiedosto.FullName)"
            }
            catch {

                # $_
                # = sisältää virheobjektin
                #
                # Jos poisto epäonnistuu (esim. tiedosto lukittu),
                # virhe kirjataan lokiin mutta skripti jatkaa
                Loki "Virhe poistaessa tiedostoa: $($tiedosto.FullName) - $_"
            }
        }


        # Kun kaikki tiedostot on käsitelty,
        # kirjataan yhteenveto lokiin
        Loki "Temp-kansion puhdistus valmis. Poistettu $($vanhatTiedostot.Count) tiedostoa."
    }
    else {

        # else-haara suoritetaan,
        # jos poistettavia tiedostoja ei löytynyt lainkaan
        Loki "Temp-kansiossa ei ollut poistettavia tiedostoja."
    }
}

