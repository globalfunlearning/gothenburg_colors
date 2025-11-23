# 🎨 Gothenburg Colors - R Design System

Färgsystem och designfunktioner enligt Göteborgs Stads grafiska profil.

**Version:** 1.1  
**Senast uppdaterad:** 2025-11-23

---

## 📦 Installation

```r
# Ladda core färgsystem (inget ggplot2-beroende)
source("colors_gothenburg.R")

# Ladda ggplot2 integration (valfritt)
source("ggplot_scales_gothenburg.R")
```

---

## 🎯 Snabbstart

### Grundläggande användning

```r
# Hämta enskilda färger
gbg_colors("blue")           # Göteborgsblå: #0076bc
gbg_colors("dark_green")     # Grön: #008767

# Hämta alla färger
alla_farger <- gbg_colors()
```

### Paletter

```r
# Sequential (låg → hög)
gbg_palette("sequential", "blue")              # Blå gradient
gbg_palette("sequential", "green", n = 7)      # 7 gröna nyanser

# Diverging (negativ → neutral → positiv)
gbg_palette("diverging", "red_green")          # Röd-Vit-Grön

# Categorical (kategorier)
gbg_palette("categorical", "palette_4")        # 4 distinkta färger
gbg_palette("categorical", "palette_7")        # 7 distinkta färger
```

### ggplot2 integration

```r
library(ggplot2)

# Sequential
ggplot(data, aes(fill = population)) + 
  geom_sf() + 
  scale_fill_gbg_sequential("blue")

# Diverging
ggplot(data, aes(fill = change_percent)) + 
  geom_sf() + 
  scale_fill_gbg_diverging("red_green")

# Categorical
ggplot(data, aes(fill = district)) + 
  geom_sf() + 
  scale_fill_gbg_categorical("palette_4")
```

---

## ✨ Vad är nytt i v1.1?

### Nya funktioner

**`check_color_contrast()`** - Kontrollera färgkontrast enligt WCAG
```r
check_color_contrast(gbg_colors("blue"), gbg_colors("white"))
# Returnerar kontrast-ratio och WCAG AA/AAA-status
```

### Förbättringar

- ✅ **Starkare input-validering** i alla funktioner
- ✅ **Bättre felmeddelanden** som hjälper till felsökning
- ✅ **Automatiserade tester** med testthat (80+ tester)
- ✅ **Färgblindanpassning** dokumenterad

---

## 📁 Projektstruktur

```
gothenburg-colors/
├── colors_gothenburg.R              # CORE: Färger + paletter
├── ggplot_scales_gothenburg.R       # EXTENSION: ggplot2 scales
├── README.md                        # Detta dokument
├── CHANGELOG.md                     # Versionshistorik
├── LICENSE                          # MIT License
├── .gitignore                       # Git-ignorerade filer
│
├── docs/
│   ├── funktioner_katalog_colors.md      # Detaljerad API-dokumentation
│   ├── funktioner_katalog_ggplot.md      # ggplot2 scales-dokumentation
│   ├── fargblindanpassning.md            # Tillgänglighetsdokumentation
│   └── SNABBGUIDE.md                     # Snabbreferens
│
├── examples/
│   ├── exempel_colors.R              # Base R exempel
│   ├── exempel_kartor.R              # ggplot2 kartor med sf
│   └── exempel_diagram.R             # ggplot2 diagram
│
└── tests/
    ├── testthat.R                    # Testkonfiguration
    └── testthat/
        ├── test-colors.R             # Tester för colors_gothenburg.R
        └── test-scales.R             # Tester för ggplot_scales_gothenburg.R
```

---

## 🎨 Färgpaletter

### Huvudfärg
- **Göteborgsblå**: `#0076bc` - Används för profilerande element

### Komplementfärger - Mörka
Använd för datavärden, diagram och kartor:

- **Mörkblå**: `#3f5564`
- **Grön**: `#008767`
- **Turkos**: `#008391`
- **Gul**: `#ffcd37`
- **Röd**: `#d24723`
- **Rosa**: `#d53878`
- **Lila**: `#674a99`

### Komplementfärger - Ljusa
Använd för bakgrunder, ljusa värden, highlights:

- **Grå**: `#d1d9dc`
- **Ljusgrön**: `#b7e1c8`
- **Ljusblå**: `#bfe4f2`
- **Ljusgul**: `#fff2b0`
- **Aprikos**: `#faceb9`
- **Ljusrosa**: `#f8ccdc`
- **Violett**: `#e0d0e7`

### Paletttyper

**Sequential (11 st):**
- `blue`, `green`, `yellow_red` (huvudpaletter)
- `dark_blue`, `cyan`, `yellow`, `red`, `pink`, `purple` (single hue)
- `yellow_green`, `yellow_green_dark` (multi hue)

**Diverging (3 st):**
- `red_green` (negativ-positiv)
- `blue_red` (kallt-varmt)
- `purple_green` (7 steg)

**Categorical (7 st):**
- `palette_1` till `palette_7` (1-7 färger)
- ⭐ `palette_4` rekommenderas som standard

---

## 🔧 Kärnfunktioner

### colors_gothenburg.R (CORE)

| Funktion | Beskrivning |
|:---------|:------------|
| `gbg_colors()` | Hämta enskilda färger eller alla |
| `gbg_palette()` | Hämta färgpalett (sequential/diverging/categorical) |
| `choose_text_color()` | Välj svart eller vit text för optimal kontrast |
| `check_color_contrast()` | ✨ **NY** Kontrollera WCAG-kontrast |
| `show_palette()` | Visualisera palett (kräver ggplot2) |
| `gbg_palette_gradient()` | Skapa custom gradient |

### ggplot_scales_gothenburg.R (EXTENSION)

| Funktion | Typ | Användning |
|:---------|:----|:-----------|
| `scale_fill_gbg_sequential()` | Sequential | Fyll-färger, ordnade värden |
| `scale_color_gbg_sequential()` | Sequential | Linje/punkt-färger, ordnade värden |
| `scale_fill_gbg_diverging()` | Diverging | Fyll-färger, avvikelser |
| `scale_color_gbg_diverging()` | Diverging | Linje/punkt-färger, avvikelser |
| `scale_fill_gbg_categorical()` | Categorical | Fyll-färger, kategorier |
| `scale_color_gbg_categorical()` | Categorical | Linje/punkt-färger, kategorier |

---

## 💡 Användningsområden

### colors_gothenburg.R kan användas i:
- Base R plots
- gt-tabeller
- reactable
- leaflet
- Alla R-paket som behöver färger

### ggplot_scales_gothenburg.R kan användas i:
- ggplot2 kartor (geom_sf)
- ggplot2 diagram (geom_bar, geom_line, etc)
- Alla ggplot2 visualiseringar

---

## 🎓 Best Practices

### Val av paletttyp

**Sequential:** Använd för ordnade värden (låg → hög)
- Befolkningstäthet
- Procentandelar
- Index

**Diverging:** Använd för avvikelser från centralvärde
- Befolkningsförändring
- Budget över/under
- För/emot

**Categorical:** Använd för kategorier utan ordning
- Stadsdelar
- Partier
- Kategorier (max 7 rekommenderas)

### Kontrollera tillgänglighet

```r
# Kontrollera färgkontrast
check_color_contrast(
  bakgrundsfärg,
  textfärg
)

# Välj automatiskt optimal textfärg
text_color <- choose_text_color(bakgrundsfärg)
```

---

## ♿ Tillgänglighet

- ✅ Alla paletter är färgblindanpassade
- ✅ WCAG AA-standard för kontrast
- ✅ Max 7 kategorier för categorical
- ✅ Ljushet-gradient i sequential paletter

**Läs mer:** [docs/fargblindanpassning.md](docs/fargblindanpassning.md)

---

## 🧪 Testning

Projektet har 80+ automatiserade tester:

```r
# Kör alla tester
source("tests/testthat.R")

# Eller specifika tester
testthat::test_file("tests/testthat/test-colors.R")
testthat::test_file("tests/testthat/test-scales.R")
```

---

## 📚 Dokumentation

- [Funktionskatalog: colors_gothenburg.R](docs/funktioner_katalog_colors.md)
- [Funktionskatalog: ggplot_scales_gothenburg.R](docs/funktioner_katalog_ggplot.md)
- [Färgblindanpassning](docs/fargblindanpassning.md)
- [Snabbguide](docs/SNABBGUIDE.md)
- [Ändringslogg](CHANGELOG.md)

---

## 🔄 Versionshistorik

### Version 1.1 (2025-11-23)

**Nya funktioner:**
- `check_color_contrast()` - WCAG-kontroll
- Automatiserade tester (testthat)

**Förbättringar:**
- Starkare input-validering
- Bättre felmeddelanden
- Färgblindanpassning dokumenterad

### Version 1.0 (2025-10-31)

- Initial release
- Komplett färgsystem enligt Göteborgs Stads profil
- ggplot2-integration

**Se:** [CHANGELOG.md](CHANGELOG.md) för komplett historik

---

## 🤝 Bidra

Detta är ett öppen källkod-projekt. Bidrag välkomnas!

### Rapportera problem

Använd GitHub Issues för att rapportera buggar eller föreslå förbättringar.

### Kodstandard

Projektet följer:
- Tidyverse style guide
- Roxygen2 för dokumentation
- testthat för tester
- Conventional commits

---

## 📄 Licens

MIT License - Se [LICENSE](LICENSE) för detaljer.

---

## 🔗 Relaterade resurser

**Göteborgs Stad:**
- [Grafisk profil](https://goteborg.se/grafiskprofil)
- [Designsystem fördatavisualisering](designprinciper_visualisering_Göteborg.md)

**R-resurser:**
- [ColorBrewer](https://colorbrewer2.org/)
- [WCAG Färgkontrast](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)

---

## 📧 Kontakt

**Utvecklare:** Henrik Söderholm  
**Organisation:** Stadsledningskontoret, Göteborgs Stad  
**GitHub:** [globalfunlearning/gothenburg_colors](https://github.com/globalfunlearning/gothenburg_colors)

---

## ⭐ Exempel

### Choropleth-karta

```r
library(ggplot2)
library(sf)
library(dplyr)

# Ladda färgsystem
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")

# Skapa karta med rådata eller normaliserad data
ggplot(kommuner, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential(
    palette = "blue",
    name = "Personer per km²"
  ) +
  labs(
    title = "Befolkningstäthet i Göteborg",
    caption = "Källa: SCB"
  ) +
  theme_minimal()
```

### Kontrastkontroll för text

```r
# Bakgrundsfärg
bg <- gbg_colors("dark_yellow")

# Kontrollera kontrast
contrast <- check_color_contrast(bg, "#ffffff")
print(contrast)

# Välj automatiskt bästa textfärg
text <- choose_text_color(bg)

# Använd i plot
ggplot(data, aes(x = category, y = value)) +
  geom_col(fill = bg) +
  geom_text(aes(label = value), color = text, vjust = -0.5)
```

---

*Skapad: 2025-10-31*  
*Uppdaterad: 2025-11-23*  
*Version: 1.1*