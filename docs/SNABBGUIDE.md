# ⚡ Snabbguide - Gothenburg Colors

Snabb referens för Göteborgs Stads färgsystem i R.


------------------------------------------------------------------------

## 📦 Installation

``` r
# Ladda färgsystem
source("colors_gothenburg.R")

# Ladda ggplot2 integration (valfritt)
source("ggplot_scales_gothenburg.R")
library(ggplot2)
```

------------------------------------------------------------------------

## 🎨 Färger

### Hämta enskilda färger

``` r
gbg_colors("blue")           # Göteborgsblå: #0076bc
gbg_colors("dark_green")     # Grön: #008767
gbg_colors("light_yellow")   # Ljusgul: #fff2b0
gbg_colors()                 # Alla 17 färger
```

### Tillgängliga färger

| Typ | Färger |
|:---------------------------|:-------------------------------------------|
| **Huvudfärg** | `blue` |
| **Mörka** | `dark_blue`, `dark_green`, `dark_cyan`, `dark_yellow`, `dark_red`, `dark_pink`, `dark_purple` |
| **Ljusa** | `light_gray`, `light_green`, `light_cyan`, `light_yellow`, `light_orange`, `light_pink`, `light_purple` |
| **Övrigt** | `white`, `black` |

------------------------------------------------------------------------

## 🎭 Paletter

### Sequential (låg → hög)

``` r
# Standard blå
gbg_palette("sequential", "blue")

# Grön gradient
gbg_palette("sequential", "green")

# Varningsgradient (gul → röd)
gbg_palette("sequential", "yellow_red")

# Interpolera till 7 färger
gbg_palette("sequential", "blue", n = 7)

# Omvänd ordning
gbg_palette("sequential", "blue", direction = -1)
```

**Tillgängliga:** `blue`, `green`, `yellow_red`, `dark_blue`, `cyan`, `yellow`, `red`, `pink`, `purple`, `yellow_green`, `yellow_green_dark`

### Diverging (negativ → neutral → positiv)

``` r
# Röd-Vit-Grön (standard)
gbg_palette("diverging", "red_green")

# Blå-Vit-Röd
gbg_palette("diverging", "blue_red")

# 7 steg
gbg_palette("diverging", "purple_green")
```

**Tillgängliga:** `red_green`, `blue_red`, `purple_green`

### Categorical (kategorier)

``` r
# 4 kategorier (rekommenderad)
gbg_palette("categorical", "palette_4")

# 7 kategorier (max)
gbg_palette("categorical", "palette_7")

# OBS: Interpolera INTE categorical paletter!
```

**Tillgängliga:** `palette_1` till `palette_7`

------------------------------------------------------------------------

## 🛠️ Hjälpfunktioner

### Textfärg för optimal kontrast

``` r
choose_text_color("#0076bc")    # → "#ffffff" (vit)
choose_text_color("#fff2b0")    # → "#000000" (svart)
```

### Visualisera palett

``` r
show_palette(gbg_palette("sequential", "blue"))
show_palette(gbg_palette("categorical", "palette_4"))

# Med egna labels
show_palette(
  gbg_palette("sequential", "blue", n = 5),
  labels = c("Mycket låg", "Låg", "Medel", "Hög", "Mycket hög")
)
```

### Skapa gradient

``` r
gbg_palette_gradient(
  c(gbg_colors("light_cyan"), gbg_colors("blue")),
  n = 10
)
```

## 🆕 Nya funktioner (v1.1)

### Kontrollera färgkontrast
```r
check_color_contrast(gbg_colors("blue"), gbg_colors("white"))
# Visar WCAG AA/AAA-status
```

------------------------------------------------------------------------

## 📊 ggplot2 Scales

### Sequential

``` r
# Kontinuerlig skala
ggplot(data, aes(fill = population)) + 
  geom_sf() + 
  scale_fill_gbg_sequential("blue")

# Diskret skala med 5 klasser
ggplot(data, aes(fill = cut(population, 5))) + 
  geom_sf() + 
  scale_fill_gbg_sequential("blue", n = 5, discrete = TRUE)

# För linjer/punkter
scale_color_gbg_sequential("green")
```

### Diverging

``` r
# Standard
ggplot(data, aes(fill = change_percent)) + 
  geom_sf() + 
  scale_fill_gbg_diverging("red_green")

# Med symmetriska limits
ggplot(data, aes(fill = deviation)) + 
  geom_sf() + 
  scale_fill_gbg_diverging(
    "red_green",
    limits = c(-50, 50)
  )

# För linjer/punkter
scale_color_gbg_diverging("blue_red")
```

### Categorical

``` r
# 4 kategorier
ggplot(data, aes(fill = district)) + 
  geom_sf() + 
  scale_fill_gbg_categorical("palette_4")

# 7 kategorier
ggplot(data, aes(fill = party)) + 
  geom_sf() + 
  scale_fill_gbg_categorical("palette_7")

# För linjer/punkter
scale_color_gbg_categorical("palette_4")
```

------------------------------------------------------------------------

## 📋 Snabb beslutsguide

### Välj palettyp

```         
Numeriska värden med ordning (0-100, låg-hög)?
  → Sequential

Avvikelser från centralvärde (±50, under-över)?
  → Diverging

Kategorier utan ordning (stadsdelar, partier)?
  → Categorical
```

### Välj specifik palett

#### Sequential

-   **Standard/neutral:** `blue`
-   **Positiva värden:** `green`
-   **Varningar/risk:** `yellow_red`

#### Diverging

-   **Negativ/positiv:** `red_green`
-   **Kallt/varmt:** `blue_red`
-   **Fler nyanser:** `purple_green`

#### Categorical

-   **2-3 kategorier:** `palette_2` eller `palette_3`
-   **4 kategorier:** `palette_4` ⭐ REKOMMENDERAD DEFAULT
-   **5-7 kategorier:** `palette_5`, `palette_6`, `palette_7`

------------------------------------------------------------------------

## 💡 Tips & Tricks

### Base R plots

``` r
# Enkel plot
plot(x, y, col = gbg_colors("blue"), pch = 16)

# Barplot med categorical
farger <- gbg_palette("categorical", "palette_4")
barplot(values, col = farger, names.arg = names)

# Heatmap
heatmap(matrix, col = gbg_palette("sequential", "blue", n = 20))
```

### Använd med andra paket

``` r
# gt-tabeller
library(gt)
data %>%
  gt() %>%
  tab_style(
    style = cell_fill(color = gbg_colors("light_cyan")),
    locations = cells_body(columns = kategori)
  )

# leaflet-kartor
library(leaflet)
pal <- colorNumeric(
  palette = gbg_palette("sequential", "blue", n = 7),
  domain = data$values
)
leaflet(data) %>%
  addPolygons(fillColor = ~pal(values))

# reactable
library(reactable)
reactable(
  data,
  columns = list(
    kategori = colDef(
      style = function(value) {
        list(background = gbg_colors("light_green"))
      }
    )
  )
)
```

### Normalisering för kartor

``` r
# Per capita
data$per_capita <- (data$värde / data$befolkning) * 1000

# Procent
data$procent <- (data$värde / sum(data$värde)) * 100

# Per area
data$per_km2 <- data$värde / data$area_km2
```

### Diskret klassindelning

``` r
# Kvantiler
data$klass <- cut(
  data$värde,
  breaks = quantile(data$värde, probs = seq(0, 1, 0.2)),
  include.lowest = TRUE
)

# Natural breaks (kräver classInt)
library(classInt)
breaks <- classIntervals(data$värde, n = 5, style = "jenks")
data$klass <- cut(data$värde, breaks = breaks$brks)

# Manuella gränser
data$klass <- cut(
  data$värde,
  breaks = c(0, 100, 500, 1000, Inf),
  labels = c("0-100", "100-500", "500-1000", "1000+")
)
```

------------------------------------------------------------------------

## ⚠️ Viktiga påminnelser (

### ✅ GÖR

-   Normalisera data för choropleth-kartor
-   Använd max 7 kategorier för categorical
-   Centrera diverging-skalor runt neutralvärdet
-   Testa kontrast med `choose_text_color()`
-   Använd färgerna från grafiska profilen

### ❌ UNDVIK

-   Interpolera categorical paletter (använd `n`)
-   Använda sequential för kategoriska data
-   Mer än 7 färger i categorical paletter
-   Glömma normalisera befolkningsdata
-   Använda färger som inte finns i profilen

------------------------------------------------------------------------

## 📚 Mer information

-   **Fullständig dokumentation:**
    -   [funktioner_katalog_colors.md](funktioner_katalog_colors.md)
    -   [funktioner_katalog_ggplot.md](funktioner_katalog_ggplot.md)
-   **Exempel:** Se `examples/`-mappen
-   **GitHub:** <https://github.com/globalfunlearning/gothenburg-colors>

------------------------------------------------------------------------

## 🎯 Vanligaste användningsfallen

### 1. Enkel karta med befolkningstäthet

``` r
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")
library(ggplot2)
library(sf)

ggplot(kommuner, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential("blue") +
  labs(
    title = "Befolkningstäthet",
    fill = "Personer/km²"
  ) +
  theme_minimal()
```

### 2. Diverging-karta med förändring

``` r
ggplot(data, aes(fill = förändring_procent)) +
  geom_sf(color = "white") +
  scale_fill_gbg_diverging("red_green") +
  labs(
    title = "Befolkningsförändring 2020-2024",
    fill = "Förändring (%)"
  ) +
  theme_minimal()
```

### 3. Categorical-karta med stadsdelar

``` r
ggplot(stadsdelar, aes(fill = namn)) +
  geom_sf(color = "white", linewidth = 0.5) +
  scale_fill_gbg_categorical("palette_7") +
  labs(title = "Stadsdelar") +
  theme_void()
```

### 4. Linjediagram

``` r
ggplot(tidsserie, aes(x = år, y = värde, color = kategori)) +
  geom_line(linewidth = 1.2) +
  scale_color_gbg_categorical("palette_4") +
  theme_minimal()
```

### 5. Stapeldiagram

``` r
ggplot(data, aes(x = kategori, y = värde, fill = kategori)) +
  geom_col() +
  scale_fill_gbg_categorical("palette_4") +
  theme_minimal() +
  theme(legend.position = "none")
```

------------------------------------------------------------------------

## 🆘 Snabb felsökning

| Problem | Lösning |
|------------------------------------|------------------------------------|
| "Färgen finns inte" | Kolla stavning: `gbg_colors()` för lista |
| "Paletten finns inte" | Se tillgängliga: `names(SEQUENTIAL_PALETTES)` |
| "colors_gothenburg.R måste laddas först" | Ladda i rätt ordning (colors → ggplot) |
| För många kategorier | Använd högre palette_X eller gruppera |
| Färger upprepas | Sätt `discrete = FALSE` för kontinuerlig |
| Fel textfärg | Använd `choose_text_color()` |

------------------------------------------------------------------------

**Version:** 1.0\
**Datum:** 2025-10-31\
**Projekt:** Gothenburg Colors
