Ylläpitotyökalu – automaatioskripti

Nimi: Aaron S23ÄTIV
Kurssi: Työtehtävien automatisointi komentokielellä

---

Projektin tarkoitus

Tämän projektin tarkoituksena on toteuttaa yksinkertainen mutta työelämässä
hyödyllinen automaatioskripti, joka helpottaa tietokoneen ylläpitotehtäviä.

Skripti on suunniteltu ajettavaksi säännöllisesti (esim. ajastettuna),
ja se suorittaa useita ylläpitoon liittyviä tarkistuksia automaattisesti.

---

Suunnitellut automatisoitavat tehtävät

Tässä vaiheessa suunnitellut toiminnot ovat:

- Levytilan tarkistaminen (esim. C:-asema)
- Varmuuskopioinnin tekeminen annetusta kansiosta
- Lokitiedoston kirjoittaminen tapahtumista
- Yhteenvetoraportin luominen

Skripti on modulaarinen ja koostuu useista erillisistä tiedostoista.

---

Käytettävä tekniikka

- Kieli: PowerShell
- Käyttöjärjestelmä: Windows
- Skripti on suunniteltu toimimaan ilman erillisiä lisäohjelmia
- Soveltuu ajastettavaksi Windows Task Schedulerilla

---

Projektin rakenne:

ylläpitotyökalu/
├── main.ps1 # Pääohjelma
├── levytila.ps1 # Levytilan tarkistus
├── varmuuskopio.ps1 # Varmuuskopiointi
├── yhteinen.ps1 # Yhteiset funktiot (lokitus, raportointi)
├── lokit/
│ └── loki.txt
