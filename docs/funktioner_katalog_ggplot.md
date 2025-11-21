---
editor_options: 
  markdown: 
    wrap: 72
---

# 📖 Funktionskatalog - ggplot_scales_gothenburg.R

Komplett referens för alla ggplot2 scale-funktioner.

------------------------------------------------------------------------

## Innehållsförteckning

1.  [Översikt](#översikt)
2.  [Sequential Scales](#sequential-scales)
    -   [scale_fill_gbg_sequential()](#scale_fill_gbg_sequential)
    -   [scale_color_gbg_sequential()](#scale_color_gbg_sequential)
3.  [Diverging Scales](#diverging-scales)
    -   [scale_fill_gbg_diverging()](#scale_fill_gbg_diverging)
    -   [scale_color_gbg_diverging()](#scale_color_gbg_diverging)
4.  [Categorical Scales](#categorical-scales)
    -   [scale_fill_gbg_categorical()](#scale_fill_gbg_categorical)
    -   [scale_color_gbg_categorical()](#scale_color_gbg_categorical)
5.  [Gemensamma parametrar](#gemensamma-parametrar)
6.  [Användningsexempel](#användningsexempel)

------------------------------------------------------------------------

## Översikt {#översikt}

### Beroenden

Dessa funktioner kräver:

-   `colors_gothenburg.R` (måste laddas först)

-   `ggplot2`

``` r
# Ladda i rätt ordning
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")
library(ggplot2)
```

### Automatisk beroendekontroll

Skriptet kontrollerar automatiskt att:

1\. `colors_gothenburg.R` är laddat (kollar om `CATEGORICAL_PALETTES`
finns)

2\. `ggplot2` är tillgängligt

Om beroenden saknas får du tydliga felmeddelanden.

### Funktionsöversikt

| Funktion | Typ | Användning |
|:------------------------|:----------------|:-----------------------------|
| `scale_fill_gbg_sequential()` | Sequential | Fyll-färger för ordnade värden |
| `scale_color_gbg_sequential()` | Sequential | Linje-/punkt-färger för ordnade värden |
| `scale_fill_gbg_diverging()` | Diverging | Fyll-färger för avvikelser |
| `scale_color_gbg_diverging()` | Diverging | Linje-/punkt-färger för avvikelser |
| `scale_fill_gbg_categorical()` | Categorical | Fyll-färger för kategorier |
| `scale_color_gbg_categorical()` | Categorical | Linje-/punkt-färger för kategorier |

------------------------------------------------------------------------

## Sequential Scales {#sequential-scales}

### scale_fill_gbg_sequential() {#scale_fill_gbg_sequential}

#### Beskrivning

ggplot2 scale för fyll-färger med sequential paletter. Används för
numeriska värden med ordning (låg → hög).

#### Syntax

``` r
scale_fill_gbg_sequential(palette = "blue", 
                          n = NULL, 
                          direction = 1,
                          discrete = NULL,
                          ...)
```

#### Parametrar

**palette** (character) - Namn på sequential palett - Standard:
`"blue"` - Tillgängliga: `"blue"`, `"green"`, `"yellow_red"`,
`"dark_blue"`, `"cyan"`, `"yellow"`, `"red"`, `"pink"`, `"purple"`,
`"yellow_green"`, `"yellow_green_dark"`

**n** (integer, valfritt) - Antal färger - `NULL` = automatisk
detektering från data - Specificera för diskreta skalor med exakt antal
klasser

**direction** (integer) - `1` = normal ordning (ljus → mörk) - `-1` =
omvänd ordning (mörk → ljus)

**discrete** (logical, valfritt) - `TRUE` = tvinga diskret skala
(använder `scale_fill_manual`) - `FALSE` = tvinga kontinuerlig skala
(använder `scale_fill_gradientn`) - `NULL` = automatisk detektering
baserat på data

**...** (övriga argument) - Alla argument som accepteras av
`scale_fill_manual()` eller `scale_fill_gradientn()` - Exempel: `name`,
`breaks`, `labels`, `limits`, `na.value`, `guide`

#### Returnerar

Ett ggplot2 scale-objekt

#### Exempel

``` r
library(ggplot2)
library(sf)

# Kontinuerlig skala (default)
ggplot(kommuner, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential("blue") +
  labs(
    title = "Befolkningstäthet",
    fill = "Personer per km²"
  )

# Diskret skala med 5 klasser
ggplot(kommuner, aes(fill = cut(befolkning_per_km2, breaks = 5))) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential("blue", n = 5, discrete = TRUE) +
  labs(fill = "Täthet")

# Omvänd ordning (mörk = låg)
ggplot(kommuner, aes(fill = arbetslöshet)) +
  geom_sf() +
  scale_fill_gbg_sequential("yellow_red", direction = -1)

# Med anpassade breaks och labels
ggplot(kommuner, aes(fill = medelinkomst)) +
  geom_sf() +
  scale_fill_gbg_sequential(
    "green",
    breaks = c(300000, 400000, 500000),
    labels = c("300k", "400k", "500k"),
    name = "Medelinkomst (SEK)"
  )
```

#### Best Practices

**Kontinuerlig skala:** För data med många unika värden

``` r
# Befolkning, temperatur, index
scale_fill_gbg_sequential("blue")
```

**Diskret skala:** För klassindelad data

``` r
# Kvantiler, natural breaks
scale_fill_gbg_sequential("blue", n = 5, discrete = TRUE)
```

**Val av palett:** - `"blue"` - Standard, neutral - `"green"` - Positiva
värden, miljö - `"yellow_red"` - Varningar, risk

------------------------------------------------------------------------

### scale_color_gbg_sequential() {#scale_color_gbg_sequential}

#### Beskrivning

Samma som `scale_fill_gbg_sequential()` men för linje- och punktfärger
(color/colour aesthetic).

#### Syntax

``` r
scale_color_gbg_sequential(palette = "blue", 
                           n = NULL, 
                           direction = 1,
                           discrete = NULL,
                           ...)
```

#### Parametrar

Identiska med `scale_fill_gbg_sequential()` - se ovan.

#### Exempel

``` r
# Linjer över tid
ggplot(tidsserie, aes(x = år, y = värde, color = temperatur)) +
  geom_line(linewidth = 1) +
  scale_color_gbg_sequential("yellow_red")

# Punkter färgade efter värde
ggplot(data, aes(x = x, y = y, color = z)) +
  geom_point(size = 3) +
  scale_color_gbg_sequential("blue", n = 7, discrete = TRUE)

# Kombinera fill och color
ggplot(kommuner, aes(fill = befolkning)) +
  geom_sf(aes(color = inkomst)) +
  scale_fill_gbg_sequential("blue") +
  scale_color_gbg_sequential("green")
```

------------------------------------------------------------------------

## Diverging Scales {#diverging-scales}

### scale_fill_gbg_diverging() {#scale_fill_gbg_diverging}

#### Beskrivning

ggplot2 scale för fyll-färger med diverging paletter. Används för värden
med negativ-neutral-positiv riktning.

#### Syntax

``` r
scale_fill_gbg_diverging(palette = "red_green", 
                         n = NULL, 
                         direction = 1,
                         discrete = NULL,
                         ...)
```

#### Parametrar

**palette** (character) - Namn på diverging palett - Standard:
`"red_green"` - Tillgängliga: `"red_green"`, `"blue_red"`,
`"purple_green"`

**n, direction, discrete, ...** - Se [Sequential
Scales](#sequential-scales)

#### Exempel

``` r
# Befolkningsförändring (negativ = röd, positiv = grön)
ggplot(kommuner, aes(fill = befolkning_förändring_procent)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_diverging("red_green") +
  labs(
    title = "Befolkningsförändring 2020-2024",
    fill = "Förändring (%)"
  )

# Med symmetriska limits runt noll
ggplot(data, aes(fill = avvikelse)) +
  geom_sf() +
  scale_fill_gbg_diverging(
    "red_green",
    limits = c(-50, 50),
    breaks = seq(-50, 50, 25)
  )

# Diskret skala med 7 klasser
ggplot(kommuner, aes(fill = cut(förändring, breaks = 7))) +
  geom_sf() +
  scale_fill_gbg_diverging("red_green", n = 7, discrete = TRUE)

# Temperaturavvikelse (blå = kallt, röd = varmt)
ggplot(data, aes(fill = temp_avvikelse)) +
  geom_tile() +
  scale_fill_gbg_diverging("blue_red")
```

#### Best Practices

**Centrera runt noll:**

``` r
# Säkerställ att vit = 0
max_abs <- max(abs(range(data$värde)))
scale_fill_gbg_diverging(
  "red_green",
  limits = c(-max_abs, max_abs)
)
```

**Val av palett:** - `"red_green"` - Standard för negativ/positiv -
`"blue_red"` - Temperatur, kallt/varmt - `"purple_green"` - Alternativ
med fler nyanser

------------------------------------------------------------------------

### scale_color_gbg_diverging() {#scale_color_gbg_diverging}

#### Beskrivning

Samma som `scale_fill_gbg_diverging()` men för linje- och punktfärger.

#### Syntax

``` r
scale_color_gbg_diverging(palette = "red_green", 
                          n = NULL, 
                          direction = 1,
                          discrete = NULL,
                          ...)
```

#### Parametrar

Identiska med `scale_fill_gbg_diverging()` - se ovan.

#### Exempel

``` r
# Linjer som visar avvikelse
ggplot(tidsserie, aes(x = datum, y = avvikelse, color = avvikelse)) +
  geom_line(linewidth = 1.5) +
  scale_color_gbg_diverging("red_green") +
  geom_hline(yintercept = 0, linetype = "dashed")

# Punkter färgade efter förändring
ggplot(data, aes(x = x, y = y, color = förändring)) +
  geom_point(size = 4) +
  scale_color_gbg_diverging("blue_red")
```

------------------------------------------------------------------------

## Categorical Scales {#categorical-scales}

### scale_fill_gbg_categorical() {#scale_fill_gbg_categorical}

#### Beskrivning

ggplot2 scale för fyll-färger med categorical paletter. Används för
kategoriska variabler utan inbördes ordning.

#### Syntax

``` r
scale_fill_gbg_categorical(palette = "palette_4", 
                           direction = 1,
                           ...)
```

#### Parametrar

**palette** (character) - Namn på categorical palett - Standard:
`"palette_4"` - Tillgängliga: `"palette_1"` till `"palette_7"` -
Rekommenderar max 7 kategorier

**direction** (integer) - `1` = normal ordning - `-1` = omvänd ordning

**...** (övriga argument) - Alla argument som accepteras av
`scale_fill_manual()` - Exempel: `name`, `breaks`, `labels`, `na.value`,
`guide`

**OBS:** Parametern `n` finns INTE för categorical scales. Använd alltid
originalfärgerna från paletten.

#### Exempel

``` r
# 4 stadsdelar
ggplot(stadsdelar, aes(fill = stadsdel)) +
  geom_sf(color = "white", linewidth = 0.5) +
  scale_fill_gbg_categorical("palette_4") +
  labs(
    title = "Göteborg - Stadsdelar",
    fill = "Stadsdel"
  )

# 7 partier
ggplot(valdistrikt, aes(fill = parti)) +
  geom_sf() +
  scale_fill_gbg_categorical("palette_7") +
  labs(fill = "Parti")

# Med anpassade labels
ggplot(data, aes(fill = kategori)) +
  geom_col() +
  scale_fill_gbg_categorical(
    "palette_5",
    name = "Kategori",
    labels = c("A: Högt", "B: Medel", "C: Lågt", "D: Okänt", "E: Ingen data")
  )

# Omvänd ordning
ggplot(data, aes(fill = typ)) +
  geom_sf() +
  scale_fill_gbg_categorical("palette_4", direction = -1)
```

#### Val av palett

``` r
# Antal kategorier → Rekommenderad palett
1 kategori   → palette_1
2 kategorier → palette_2
3 kategorier → palette_3
4 kategorier → palette_4  # ⭐ MEST ANVÄND
5 kategorier → palette_5
6 kategorier → palette_6
7 kategorier → palette_7  # MAX rekommenderad
```

#### Best Practices

**Max 7 kategorier:**

``` r
# För fler än 7 kategorier, överväg att:
# 1. Gruppera mindre kategorier till "Övrigt"
# 2. Använda facets istället
# 3. Filtrera till viktigaste kategorierna
```

**Konsekvent ordning:**

``` r
# Specificera factor levels för konsekvent ordning
data$kategori <- factor(
  data$kategori,
  levels = c("Kategori A", "Kategori B", "Kategori C", "Kategori D")
)

ggplot(data, aes(fill = kategori)) +
  geom_sf() +
  scale_fill_gbg_categorical("palette_4")
```

------------------------------------------------------------------------

### scale_color_gbg_categorical() {#scale_color_gbg_categorical}

#### Beskrivning

Samma som `scale_fill_gbg_categorical()` men för linje- och punktfärger.

#### Syntax

``` r
scale_color_gbg_categorical(palette = "palette_4", 
                            direction = 1,
                            ...)
```

#### Parametrar

Identiska med `scale_fill_gbg_categorical()` - se ovan.

#### Exempel

``` r
# Linjer för olika kategorier
ggplot(tidsserie, aes(x = datum, y = värde, color = kategori)) +
  geom_line(linewidth = 1) +
  scale_color_gbg_categorical("palette_4")

# Punkter grupperade efter typ
ggplot(data, aes(x = x, y = y, color = typ)) +
  geom_point(size = 3) +
  scale_color_gbg_categorical("palette_5")

# Kombinera fill och color
ggplot(data, aes(x = kategori, y = värde, fill = kategori)) +
  geom_boxplot(aes(color = kategori), alpha = 0.7) +
  scale_fill_gbg_categorical("palette_4") +
  scale_color_gbg_categorical("palette_4")
```

------------------------------------------------------------------------

## Gemensamma parametrar {#gemensamma-parametrar}

### Parametrar som fungerar för alla scales

#### name

Titel på legend/färgskala

``` r
scale_fill_gbg_sequential("blue", name = "Befolkning\n(personer)")
```

#### breaks

Vilka värden som ska visas i legenden

``` r
scale_fill_gbg_diverging(
  "red_green",
  breaks = c(-50, -25, 0, 25, 50)
)
```

#### labels

Anpassade etiketter för breaks

``` r
scale_fill_gbg_categorical(
  "palette_4",
  labels = c("Kategori A", "Kategori B", "Kategori C", "Kategori D")
)
```

#### limits

Min och max värden för skalan

``` r
scale_fill_gbg_sequential("blue", limits = c(0, 1000))
```

#### na.value

Färg för NA-värden

``` r
scale_fill_gbg_categorical("palette_4", na.value = "grey80")
```

#### guide

Anpassa legend

``` r
scale_fill_gbg_sequential(
  "blue",
  guide = guide_colorbar(
    barwidth = 15,
    barheight = 0.5,
    title.position = "top"
  )
)
```

------------------------------------------------------------------------

## Användningsexempel {#användningsexempel}

### Choropleth-karta (sequential)

``` r
library(ggplot2)
library(sf)

# Ladda färgsystem
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")

# Skapa karta
ggplot(kommuner, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential(
    palette = "blue",
    name = "Befolkning\nper km²",
    breaks = c(0, 100, 500, 1000, 2000),
    labels = c("0", "100", "500", "1 000", "2 000")
  ) +
  labs(
    title = "Befolkningstäthet i Göteborg",
    subtitle = "Antal invånare per kvadratkilometer, 2024",
    caption = "Källa: SCB"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 14),
    plot.subtitle = element_text(size = 11),
    panel.grid = element_blank()
  )
```

### Diverging-karta (förändring)

``` r
# Befolkningsförändring med symmetriska limits
max_change <- max(abs(kommuner$befolkning_förändring))

ggplot(kommuner, aes(fill = befolkning_förändring)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_diverging(
    palette = "red_green",
    name = "Förändring (%)",
    limits = c(-max_change, max_change),
    breaks = seq(-max_change, max_change, length.out = 5)
  ) +
  labs(
    title = "Befolkningsförändring 2020-2024",
    subtitle = "Röd = minskning, Grön = ökning"
  ) +
  theme_minimal()
```

### Categorical-karta (stadsdelar)

``` r
# Karta med stadsdelar
ggplot(stadsdelar, aes(fill = namn)) +
  geom_sf(color = "white", linewidth = 0.5) +
  geom_sf_text(aes(label = namn), size = 3) +
  scale_fill_gbg_categorical(
    palette = "palette_7",
    name = "Stadsdel"
  ) +
  labs(
    title = "Göteborgs Stadsdelar"
  ) +
  theme_void() +
  theme(
    legend.position = "right"
  )
```

### Linjediagram med kategorier

``` r
# Tidsserie med flera kategorier
ggplot(tidsserie, aes(x = år, y = antal, color = kategori)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_gbg_categorical(
    palette = "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Utveckling över tid",
    x = "År",
    y = "Antal"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom"
  )
```

### Stapeldiagram

``` r
# Grupperade staplar
ggplot(data, aes(x = år, y = värde, fill = kategori)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_gbg_categorical(
    palette = "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Värden per kategori och år",
    x = "År",
    y = "Värde"
  ) +
  theme_minimal()
```

### Heatmap

``` r
# Heatmap med sequential skala
ggplot(data, aes(x = x, y = y, fill = värde)) +
  geom_tile(color = "white", linewidth = 0.5) +
  scale_fill_gbg_sequential(
    palette = "blue",
    name = "Värde"
  ) +
  coord_equal() +
  theme_minimal()
```

------------------------------------------------------------------------

## Tips & Tricks

### Kombinera fill och color

``` r
# Använd samma palett för fill och color
ggplot(data, aes(fill = kategori)) +
  geom_sf(aes(color = kategori), linewidth = 1) +
  scale_fill_gbg_categorical("palette_4", alpha = 0.7) +
  scale_color_gbg_categorical("palette_4")
```

### Anpassa legend-position

``` r
# Horisontell legend under kartan
ggplot(data, aes(fill = värde)) +
  geom_sf() +
  scale_fill_gbg_sequential("blue") +
  theme(
    legend.position = "bottom",
    legend.key.width = unit(3, "cm"),
    legend.key.height = unit(0.5, "cm")
  ) +
  guides(fill = guide_colorbar(title.position = "top"))
```

### Diskret vs kontinuerlig

``` r
# Låt ggplot2 välja automatiskt (default)
scale_fill_gbg_sequential("blue")

# Tvinga kontinuerlig för många värden
scale_fill_gbg_sequential("blue", discrete = FALSE)

# Tvinga diskret för klassindelning
scale_fill_gbg_sequential("blue", n = 5, discrete = TRUE)
```

### Hantera NA-värden

``` r
# Ge NA-värden en grå färg
scale_fill_gbg_categorical(
  "palette_4",
  na.value = "grey80",
  na.translate = TRUE  # Inkludera NA i legend
)
```

------------------------------------------------------------------------

## Felsökning

### "colors_gothenburg.R måste laddas först"

``` r
# Lösning: Ladda skripten i rätt ordning
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")
```

### "Paketet 'ggplot2' krävs"

``` r
# Lösning: Installera och ladda ggplot2
install.packages("ggplot2")
library(ggplot2)
```

### För många kategorier

``` r
# Problem: palette_4 har 4 färger men data har 6 kategorier
# Lösning: Använd palette_6 eller palette_7
scale_fill_gbg_categorical("palette_6")

# Eller gruppera kategorier
data$kategori_grouped <- fct_lump_n(data$kategori, n = 4)
```

### Färger upprepas

``` r
# Problem: Continuous data med diskret skala
# Lösning: Använd discrete = FALSE
scale_fill_gbg_sequential("blue", discrete = FALSE)
```

------------------------------------------------------------------------

## Ändringshistorik

**Version 1.0** (2025-10-31) - Första versionen - 6 scale-funktioner -
Stöd för sequential, diverging, categorical

------------------------------------------------------------------------

*Dokumentation skapad: 2025-10-31*\
*För: ggplot_scales_gothenburg.R v1.0*
