# 🎨 Gothenburg Colors - R Design System

Färgsystem och designfunktioner enligt Göteborgs Stads grafiska profil.

## 📦 Installation

```r
# Ladda core färgsystem (inget ggplot2-beroende)
source("colors_gothenburg.R")

# Ladda ggplot2 integration (valfritt)
source("ggplot_scales_gothenburg.R")
```

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

## 📁 Projektstruktur

```
gothenburg-colors/
├── colors_gothenburg.R              # CORE: Färger + paletter (418 rader)
├── ggplot_scales_gothenburg.R       # EXTENSION: ggplot2 scales (325 rader)
├── README.md                        # Detta dokument
├── docs/
│   ├── funktioner_katalog_colors.md
│   └── funktioner_katalog_ggplot.md
└── examples/
    ├── exempel_colors.R
    ├── exempel_kartor.R
    └── exempel_diagram.R
```

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
- `palette_1` (1 färg - Göteborgsblå)
- `palette_2` (2 färger - Blå + Svart)
- `palette_3` (3 färger)
- `palette_4` (4 färger) ⭐ REKOMMENDERAD
- `palette_5` (5 färger)
- `palette_6` (6 färger)
- `palette_7` (7 färger - MAX)

## 🔧 Funktioner

### colors_gothenburg.R (CORE)

#### `gbg_colors(color = NULL)`
Hämta specifik färg eller alla färger.

```r
gbg_colors("blue")           # Enskild färg
gbg_colors()                 # Alla färger
```

#### `gbg_palette(type, palette = NULL, n = NULL, direction = 1)`
Hämta färgpalett.

**Parametrar:**
- `type`: "sequential", "diverging", "categorical"
- `palette`: Specifik palett (NULL = första)
- `n`: Antal färger att interpolera till
- `direction`: 1 = normal, -1 = omvänd

```r
gbg_palette("sequential", "blue")
gbg_palette("sequential", "blue", n = 7)
gbg_palette("sequential", "blue", n = 7, direction = -1)
```

#### `choose_text_color(background_color)`
Välj svart eller vit text för optimal kontrast (WCAG AA).

```r
choose_text_color("#0076bc")    # → "#ffffff" (vit)
choose_text_color("#fff2b0")    # → "#000000" (svart)
```

#### `show_palette(colors, labels = NULL)`
Visualisera färgpalett. Kräver ggplot2.

```r
show_palette(gbg_palette("sequential", "blue"))
show_palette(gbg_palette("categorical", "palette_4"))
```

#### `gbg_palette_gradient(colors, n = 10)`
Skapa gradient mellan färger.

```r
gbg_palette_gradient(c("#bfe4f2", "#0076bc"), n = 10)
```

### ggplot_scales_gothenburg.R (EXTENSION)

Kräver både `colors_gothenburg.R` och `ggplot2`.

#### Sequential scales
- `scale_fill_gbg_sequential(palette, n, direction, discrete, ...)`
- `scale_color_gbg_sequential(palette, n, direction, discrete, ...)`

#### Diverging scales
- `scale_fill_gbg_diverging(palette, n, direction, discrete, ...)`
- `scale_color_gbg_diverging(palette, n, direction, discrete, ...)`

#### Categorical scales
- `scale_fill_gbg_categorical(palette, direction, ...)`
- `scale_color_gbg_categorical(palette, direction, ...)`

**Parametrar:**
- `palette`: Namn på palett
- `n`: Antal färger (NULL = automatisk)
- `direction`: 1 = normal, -1 = omvänd
- `discrete`: TRUE/FALSE/NULL (automatisk detektering)
- `...`: Övriga argument till ggplot2 scales

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

### Normalisering

⚠️ **Viktigt:** Choropleth-kartor kräver ofta normaliserad data!

```r
# Normalisera till per capita
data$per_capita <- (data$value / data$population) * 1000

# Eller till procent
data$procent <- (data$value / sum(data$value)) * 100
```

### Tillgänglighet

- Alla paletter är färgblindanpassade
- Använd `choose_text_color()` för optimal kontrast
- Max 7 kategorier för categorical paletter

## 🔄 Versionshistorik

### Version 1.0 (2025-10-31)
- Första versionen
- Två modulära skript: CORE + EXTENSION
- 11 sequential, 3 diverging, 7 categorical paletter
- 6 ggplot2 scale-funktioner
- Komplett dokumentation

## 📚 Dokumentation

- [Funktionskatalog: colors_gothenburg.R](docs/funktioner_katalog_colors.md)
- [Funktionskatalog: ggplot_scales_gothenburg.R](docs/funktioner_katalog_ggplot.md)
- [Snabbguide](docs/snabbguide.md)

## 🤝 Bidra

Detta är ett öppen källkod-projekt. Bidrag välkomnas!

## 📄 Licens

MIT License

## 🔗 Relaterade resurser

- [Göteborgs Stads grafiska profil](https://goteborg.se/grafiskprofil)
- [ColorBrewer](https://colorbrewer2.org/)

---

**Skapad:** 2025-10-31  
**Version:** 1.0  
**Kontakt:** Henrik Söderholm
# Gothenburg Colors
