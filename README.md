Ylläpitotyökalu – automaatioskripti

Nimi: Aaron S23ÄTIV
Kurssi: Työtehtävien automatisointi komentokielellä

Projektin tarkoitus

Tämän projektin tarkoituksena on toteuttaa työelämälähtöinen automaatioskripti, joka helpottaa tietokoneen ylläpitotehtäviä.
Skripti on modulaarinen, dokumentoitu ja sisältää systemaattisen virheenkäsittelyn sekä lokituksen.

Skripti voidaan ajaa:

Manuaalisesti PowerShell-ikkunasta

Ajastettuna Task Schedulerilla

Toiminnot

Skripti suorittaa seuraavat tehtävät:

Levytilan tarkistus

Tarkistaa C:-aseman vapaan tilan gigatavuina

Kirjaa tiedot lokiin ja raporttiin

Varmuuskopiointi

Tekee varmuuskopion käyttäjän määrittelemästä kansiosta

Luo aikaleimalla nimetyn backup-kansion (esim. backup_20260219_142019)

Virheenkäsittely, jos kansiota ei löydy

TEMP-kansion puhdistus

Poistaa tiedostot, jotka ovat vanhempia kuin 7 päivää

Lokittaa kaikki poistetut tiedostot ja mahdolliset virheet

Lokitiedostot

log.txt: kaikki tapahtumat ja virheet

raportti.txt: raportointia varten

Admin-tarkistus

Skripti tarkistaa, onko käyttäjällä admin-oikeudet

Jos oikeuksia ei ole, käyttäjää varoitetaan

Skriptien rakenne
Tiedosto	Kuvaus
main.ps1	Pääohjelma, joka kutsuu kaikki moduulit
yhteinen.ps1	Yhteiset funktiot: Loki(), Raportti()
levytila.ps1	Levytilan tarkistus
varmuuskopio.ps1	Varmuuskopiointifunktio
puhdistus.ps1	TEMP-kansion puhdistus

Tekniikka ja järjestelmävaatimukset

Kieli: PowerShell (5.1 tai uudempi)

Käyttöjärjestelmä: Windows

Ei vaadi erillisiä ohjelmia

Lokitiedostot tallennetaan automaattisesti

Ajastettavissa Task Schedulerilla tai ajettavissa manuaalisesti

PowerShellin suorittamisoikeudet tulee sallia (Set-ExecutionPolicy RemoteSigned)

Parametrisoitu käyttö

Skripti on parametrisoitu, eikä vaadi Read-Host-syötteitä, jos haluat ajaa automaattisesti:

.\main.ps1 -VarmuuskopioKansio "C:\naytto\testikansio"


-VarmuuskopioKansio = määrittää, mikä kansio varmuuskopioidaan

Jos parametri puuttuu, skripti käyttää oletuskansiota testikansio

Siirrettävyys

Skripti voidaan siirtää toiselle Windows-koneelle

Lokikansiot ja skriptit tulee säilyttää samassa suhteessa

Backup-kansiopolut voidaan muuttaa tarvittaessa

Mahdolliset kehitysideat

Laajennettu virheenkäsittely (esim. lukittu kansio, levy täynnä)

Varmuuskopiointi useammasta kansiosta kerrallaan

Ilmoitukset sähköpostilla

Ajastettu ajo voisi käyttää eri kansiota kuin oletuskansio
