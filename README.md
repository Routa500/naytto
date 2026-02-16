Ylläpitotyökalu – automaatioskripti

Nimi: Aaron S23ÄTIV
Kurssi: Työtehtävien automatisointi komentokielellä

Projektin tarkoitus:

Tämän projektin tarkoituksena on toteuttaa yksinkertainen mutta työelämässä hyödyllinen automaatioskripti, joka helpottaa tietokoneen ylläpitotehtäviä.

Skripti tarkistaa levytilan, tekee varmuuskopion käyttäjän määrittelemästä kansiosta ja kirjaa kaikki tapahtumat lokitiedostoon.
Skripti voidaan ajaa manuaalisesti tai ajastetusti (esim. Task Schedulerilla).

Suunnitellut automatisoitavat tehtävät:

Levytilan tarkistaminen (esim. C:-asema)

Varmuuskopioinnin tekeminen annetusta kansiosta

Lokitiedoston kirjoittaminen tapahtumista (lokit/loki.txt)

TEMP-kansion puhdistus: poistaa tiedostot, jotka ovat vanhempia kuin 7 päivää

Skripti on modulaarinen ja koostuu useista erillisistä tiedostoista (main.ps1, yhteinen.ps1, levytila.ps1, varmuuskopio.ps1, puhdistus.ps1)

Käytettävä tekniikka ja järjestelmävaatimukset:

Kieli: PowerShell (Windows PowerShell 5.1 tai uudempi)

Käyttöjärjestelmä: Windows

Ei vaadi erillisiä asennettavia ohjelmia

Lokitiedosto tallennetaan automaattisesti lokit/loki.txt-kansioon

Ajastettavissa Task Schedulerilla

Toimii myös manuaalisesti, mutta käyttäjän syötettä tarvitaan varmuuskopioitavan kansion valintaan

Siirrettävyys:

Skripti voidaan siirtää toiselle Windows-koneelle suoraan, kunhan kansiorakenne säilyy

Tarvittaessa C:\naytto-polku voidaan muuttaa, mutta lokikansiot ja skriptit pitää säilyttää samassa suhteessa

PowerShellin suorittamisoikeudet tulee sallia (esim. Set-ExecutionPolicy RemoteSigned)

Mahdolliset kehitysideat

Skripti ei tee täydellistä virheenkäsittelyä, esimerkiksi jos kansio on lukittu tai levy täynnä

Varmuuskopiointi kattaa vain yksittäisen kansion kerrallaan

Ei lähetä ilmoituksia sähköpostilla

Ajastettu ajo käyttää aina oletuskansiota testikansio, ellei skriptiä muokata
