# GitHub-projektstruktur för R – Göteborgs Stad

Detta dokument beskriver hur du strukturerar R-projekt på GitHub så att det blir en **naturlig del av arbetsflödet** – inte en extra börda.

**Filosofi:** Start enkelt, bygg gradvis. AI (som Claude) hjälper dig skapa dokumentation när du behöver den.

---

## Hur detta dokument används

**För AI-tjänster:** Hjälp användare sätta upp projekt snabbt genom att generera README, .gitignore och andra filer enligt mallarna här. Föreslå vad som behövs baserat på projekttyp.

**För användare:** Börja minimalt (3 filer) och lägg till mer när projektet växer. Be AI-tjänster om hjälp att skapa dokumentation – kopierar du kod 3 gånger? Dags för examples/. Ska andra använda koden? Lägg till SNABBGUIDE.md.

---

## Innehåll

1. [Snabbstart: Tre steg till GitHub](#snabbstart-tre-steg-till-github)
2. [Tre strukturnivåer](#tre-strukturnivåer)
3. [De tre obligatoriska filerna](#de-tre-obligatoriska-filerna)
4. [Lägg till när du behöver det](#lägg-till-när-du-behöver-det)
5. [Commit-principer](#commit-principer)
6. [Filmallar för AI att använda](#filmallar-för-ai-att-använda)

---

## Snabbstart: Tre steg till GitHub

### Steg 1: Skapa projekt lokalt (2 min)

```r
# I RStudio: File > New Project > New Directory > New Project
# Välj projektnamn med understreck: befolkning_analys_2024
```

### Steg 2: Be AI skapa grundfiler (1 min)

**Till AI-tjänst:**
> "Skapa .gitignore för R, en enkel README.md för befolkningsanalys, och föreslå LICENSE"

**Du får:**
- `.gitignore` (klar att använda)
- `README.md` (med projektnamn och kortfattad beskrivning)
- `LICENSE` (oftast MIT)

### Steg 3: Pusha till GitHub (2 min)

```bash
# I Terminal/Git Bash
git init
git add .
git commit -m "feat: Initial commit"

# Skapa repo på GitHub, sen:
git remote add origin https://github.com/dittnamn/projekt-namn.git
git push -u origin main
```

**Klart!** Du har ett fungerande GitHub-projekt på 5 minuter.

---

## Tre strukturnivåer

Välj nivå baserat på projektets behov. **Börja alltid på Nivå 1**, bygg vidare när det behövs.

### Nivå 1: Minimal (alla projekt börjar här)

**När:** Ny analys, personligt projekt, experimentering

```
projekt-namn/
├── .gitignore           # Vad Git ignorerar
├── README.md            # Kort beskrivning
├── LICENSE              # MIT (om publikt)
└── projekt-namn.Rproj   # RStudio-projekt
```

**Tid att sätta upp:** 5 min (med AI-hjälp)

### Nivå 2: Standard (när projektet växer)

**När:** Projekt med flera skript, återanvändbar kod, eller kollegor ska förstå det

```
projekt-namn/
├── .gitignore
├── README.md
├── LICENSE
├── projekt-namn.Rproj
│
├── R/
│   ├── 01_load_data.R
│   ├── 02_clean_data.R
│   ├── 03_analysis.R
│   └── functions/
│       └── helpers.R
│
├── data/                # I .gitignore om känslig
│   └── raw/
│
├── output/              # I .gitignore
│   └── figures/
│
└── docs/
    └── notes.md         # Anteckningar medan du jobbar
```

**Tid att bygga upp:** Gradvis, allteftersom du kodar

**Trigger:** "Jag har mer än 3 skript" eller "Kollegor ska förstå detta"

### Nivå 3: Delningsbart (paket/verktyg för andra)

**När:** Andra ska använda din kod, återanvändbart paket, publikt verktyg

```
paket-namn/
├── .gitignore
├── LICENSE
├── README.md            # Omfattande
├── SNABBGUIDE.md       # Kom igång på 5 min
│
├── colors_paket.R      # Huvudfunktioner
├── ggplot_scales.R     # Integration
│
├── docs/
│   └── funktioner_katalog.md
│
└── examples/
    ├── 01_basic.R
    └── 02_advanced.R
```

**Tid att sätta upp:** 1-2 timmar (AI genererar mycket)

**Trigger:** "Andra ska kunna installera och använda detta direkt"

---

## De tre obligatoriska filerna

Dessa **måste** finnas i alla projekt på GitHub.

### 1. README.md

**Vad:** Projektets framsida – första intryck

**Minimal version (Nivå 1):**
```markdown
# Befolkningsanalys Göteborg 2024

Analys av befolkningsutveckling i Göteborg 2015-2024.

## Data

SCB:s befolkningsstatistik, hämtad 2024-11-22.

## Användning

Kör skript i ordning: 01_load → 02_clean → 03_analysis
```

**Tid:** 2 min att skriva, eller be AI göra det

**Tips:** AI kan generera detta från dina skriptnamn!

### 2. .gitignore

**Vad:** Vad Git ska ignorera (data, output, temporära filer)

**Standard för R (kopiera alltid):**
```gitignore
# R
.Rproj.user/
.Rhistory
.RData
.Ruserdata

# Data (om känslig)
data/
*.csv
*.xlsx
*.rds

# Output (genereras av kod)
output/

# Temporärt
*.tmp
*~

# OS
.DS_Store
Thumbs.db
```

**Tid:** 30 sekunder (kopiera från detta dokument eller be AI)

**Tips:** GitHub kan auto-generera när du skapar repo – välj "R" template

### 3. LICENSE

**Vad:** Vad andra får göra med koden

**Rekommendation:** MIT License (enklast)

**När behövs:** Alltid för publika repos, frivilligt för privata

**Tid:** 1 min (GitHub kan skapa åt dig)

```bash
# På GitHub när du skapar repo:
# Add file > Create new file > Skriv "LICENSE"
# Klicka "Choose a license template" > MIT
```

---

## Lägg till när du behöver det

**Princip:** Bygg inte struktur i föreväg. Lägg till när du känner smärtan av att det saknas.

### När lägga till `examples/`?

**Trigger:**
- "Jag glömmer hur funktionen används"
- "Någon annan ska använda detta"
- "Jag kopierar samma setup-kod flera gånger"

**Lösning:** Be AI skapa 1-2 exempel

```r
# Till AI-tjänst:
# "Skapa exempel-skript som visar hur gbg_colors() används för enkel karta"
```

**Tid:** 5 min (AI gör jobbet)

### När lägga till `SNABBGUIDE.md`?

**Trigger:**
- "README är för lång"
- "Folk behöver komma igång snabbt"
- "Jag förklarar samma setup 3 gånger"

**Lösning:**
```r
# Till AI-tjänst:
# "Skapa SNABBGUIDE.md: Installation + ett fungerande exempel på 1 sida"
```

**Tid:** 5 min (AI skriver det)

### När lägga till `docs/funktioner_katalog.md`?

**Trigger:**
- "Jag har >5 funktioner"
- "Jag glömmer parametrarnas namn"
- "Andra ska förstå alla funktioner"

**Lösning:**
```r
# Till AI-tjänst:
# "Generera funktionskatalog från mina R-filer med roxygen-kommentarer"
```

**Tid:** 10 min (AI läser din kod och genererar)

### När lägga till `CHANGELOG.md`?

**Trigger:**
- "Jag versionshanterar (v1.0, v1.1, etc.)"
- "Andra behöver veta vad som ändrats"

**Lösning:** Be AI skapa från dina commit-meddelanden

**Tid:** 5 min första gången, sedan 1 min per uppdatering

---

## Commit-principer

### Hur ofta committa?

**Tumregel:** Vid varje "naturligt stopp"

- ✅ Funkton fungerar
- ✅ Bugg fixad
- ✅ Dag slut
- ❌ Mitt i nedbruten kod

**Bättre för ofta än för sällan!**

### Bra commit-meddelanden

**Format:**
```
typ: Kort beskrivning (max 50 tecken)
```

**Typer:**
- `feat:` Ny funktion/feature
- `fix:` Buggfix
- `docs:` Dokumentation
- `refactor:` Omstrukturering (ingen ny funktionalitet)
- `chore:` Underhåll (.gitignore, LICENSE, etc.)

**Exempel:**
```bash
✅ Bra
git commit -m "feat: Lägg till befolkningskarta funktion"
git commit -m "fix: Korrigera färgkod för Göteborgsblå"
git commit -m "docs: Uppdatera README med installation"

❌ Dåligt
git commit -m "uppdatering"
git commit -m "fix"
git commit -m "ändrade lite"
```

**Tips:** AI kan föreslå commit-meddelanden från dina ändringar!

### Första commit

```bash
git add .
git commit -m "feat: Initial commit med grundstruktur"
git push
```

---

## Filmallar för AI att använda

Dessa mallar är optimerade för att AI ska kunna generera snabbt.

### Mall: README.md (Minimal)

```markdown
# [Projektnamn]

[En mening om vad projektet gör]

## Data

[Var kommer data från? När hämtad?]

## Användning

[Hur kör man projektet? Vilken ordning?]

## Kontakt

[Ditt namn] - [email@goteborg.se]
```

### Mall: README.md (Standard - för delningsbara projekt)

```markdown
# [Projektnamn]

[Kort beskrivning - en mening]

## Om projektet

[2-3 meningar]:
- Vad gör det?
- Varför är det användbart?
- Vem är det för?

## Installation

```r
# Klona eller ladda ner
source("R/functions/main.R")
```

## Snabbstart

```r
library(tidyverse)

# Exempel
resultat <- process_data("data/raw/input.csv")
```

## Dokumentation

- [Snabbguide](SNABBGUIDE.md)
- [Exempel](examples/)

## Licens

MIT License - se [LICENSE](LICENSE)

## Kontakt

[Namn] - [email]
```

### Mall: SNABBGUIDE.md

```markdown
# Snabbguide

Kom igång med [projekt] på 5 minuter.

## 1. Installation

```r
source("funktioner.R")
library(tidyverse)
```

## 2. Grundläggande användning

```r
# Ladda data
data <- load_data("input.csv")

# Bearbeta
resultat <- process(data)

# Visualisera
create_plot(resultat)
```

## 3. Vanliga användningsfall

### Fall 1
```r
# Kod exempel
```

### Fall 2
```r
# Kod exempel
```

## Mer information

Se [README](README.md) för fullständig dokumentation.
```

### Mall: .gitignore (R-projekt)

```gitignore
# R
.Rproj.user/
.Rhistory
.RData
.Ruserdata

# Data
data/
*.csv
*.xlsx
*.rds

# Output
output/
figures/
tables/

# Temp
*.tmp
*~

# OS
.DS_Store
Thumbs.db
```

---

## Checklista: Nytt projekt

### Nivå 1: Minimal start (5 min)

- [ ] Skapa RStudio-projekt
- [ ] Be AI skapa `.gitignore` för R
- [ ] Be AI skapa `README.md` med projektnamn + 1 mening
- [ ] Lägg till `LICENSE` (om publikt repo)
- [ ] `git init && git commit -m "feat: Initial commit"`

### Nivå 2: Växande projekt (när behövs)

- [ ] Strukturera R/ med numrerade skript
- [ ] Flytta återanvändbara funktioner till R/functions/
- [ ] Lägg data/ i .gitignore (om känslig)
- [ ] Skapa docs/notes.md för anteckningar

### Nivå 3: Delningsbart (när andra ska använda)

- [ ] Be AI skapa `SNABBGUIDE.md` från dina exempel
- [ ] Be AI generera `examples/` från din kod
- [ ] Be AI skapa `docs/funktioner_katalog.md` från roxygen
- [ ] Uppdatera README till "Standard"-version

---

## Praktiska AI-kommandon

**Setup nytt projekt:**
```
"Skapa .gitignore för R-projekt, README.md för befolkningsanalys 
av Göteborg, och föreslå lämplig LICENSE"
```

**Generera dokumentation:**
```
"Läs mina R-filer och skapa funktionskatalog med alla funktioner, 
parametrar och exempel"
```

**Skapa exempel:**
```
"Skapa 2 exempel-skript: ett för grundläggande användning och ett 
för avancerad med ggplot2"
```

**Generera SNABBGUIDE:**
```
"Skapa SNABBGUIDE.md baserat på README + examples/, max 1 sida"
```

**Uppdatera README:**
```
"Utöka README till standard-version med installation, snabbstart, 
och länkar till dokumentation"
```

---

## Integration med andra standarder

**Kodprinciper för R:**
- Projektstrukturen matchar den i `kodprinciper_R_Göteborg.md`
- Numrerade skript (01_, 02_, etc.)
- Separera functions/ från scripts/

**Designprinciper för visualisering:**
- Länka till designprinciper i docs/ om projektet skapar visualiseringar
- Använd gothenburg_colors i alla grafer

**Automatisering:**
- Be AI skapa alla filer konsekvent med andra standarder
- AI känner redan till strukturen från de andra dokumenten

---

## Tre guldregler

1. **Start enkelt** – Tre filer räcker för att börja (README, .gitignore, LICENSE)
2. **Bygg gradvis** – Lägg till dokumentation när du känner smärtan av att den saknas
3. **Använd AI** – Låt AI skapa dokumentation från din kod, spara tid

**Resultat:** GitHub blir en naturlig del av arbetsflödet, inte en extra börda.

---

## Resurser

**GitHub:**
- [GitHub Desktop](https://desktop.github.com/) – GUI istället för kommandorad
- [GitHub Markdown Guide](https://guides.github.com/features/mastering-markdown/)

**Licenser:**
- [Choose a License](https://choosealicense.com/) – Välj rätt licens
- [MIT License](https://opensource.org/licenses/MIT) – Rekommenderad för de flesta

**Inspiration:**
- [gothenburg_colors](https://github.com/globalfunlearning/gothenburg_colors) – Exempel på Nivå 3-projekt

---

*Senast uppdaterad: 2025-11-22*

*Detta dokument utvecklas baserat på erfarenheter från Göteborgs Stads R-projekt.*