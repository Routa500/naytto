# Ylläpitotyökalu – automaatioskripti

**Nimi:** Aaron S23ÄTIV  
**Kurssi:** Työtehtävien automatisointi komentokielellä  

---

## Projektin tarkoitus

Tämän projektin tarkoituksena on toteuttaa yksinkertainen mutta työelämässä hyödyllinen automaatioskripti, joka helpottaa tietokoneen ylläpitotehtäviä.

Skripti on suunniteltu ajettavaksi säännöllisesti (esim. ajastettuna) ja suorittaa useita ylläpitoon liittyviä tarkistuksia automaattisesti.

---

## Suunnitellut automatisoitavat tehtävät

- Levytilan tarkistaminen (esim. C:-asema)
- Varmuuskopioinnin tekeminen annetusta kansiosta
- Lokitiedoston kirjoittaminen tapahtumista (`lokit/loki.txt`)

Skripti on modulaarinen ja koostuu useista erillisistä tiedostoista.

---

## Käytettävä tekniikka

- Kieli: PowerShell  
- Käyttöjärjestelmä: Windows  
- Skripti toimii ilman erillisiä lisäohjelmia  
- Ajastettavissa Task Schedulerilla, mutta manuaalinen syöte kansiosta tarvitaan

---

## Projektin rakenne
ylläpitotyökalu/
├── main.ps1 # Pääohjelma, joka käynnistää työkalun
├── levytila.ps1 # Levytilan tarkistus
├── varmuuskopio.ps1 # Varmuuskopiointi
├── yhteinen.ps1 # Yhteiset funktiot (lokitus)
├── lokit/
│ └── loki.txt # Lokitiedosto tapahtumista


---

## Käyttö

### Manuaalinen ajo

1. Avaa PowerShell.
2. Siirry skriptin kansioon:
   powershell
   cd C:\naytto
3. Suorita:
   ./main.ps1


