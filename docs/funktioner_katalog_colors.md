# 📖 Funktionskatalog - colors_gothenburg.R

Komplett referens för alla funktioner i `colors_gothenburg.R`.

------------------------------------------------------------------------

## Innehållsförteckning

1.  [gbg_colors()](#gbg_colors) - Hämta färger
2.  [gbg_palette()](#gbg_palette) - Hämta paletter
3.  [choose_text_color()](#choose_text_color) - Välj textfärg
4.  [show_palette()](#show_palette) - Visualisera palett
5.  [gbg_palette_gradient()](#gbg_palette_gradient) - Skapa gradient
6.  [Färgdefinitioner](#färgdefinitioner) - Alla tillgängliga färger
7.  [Paletter](#paletter) - Alla tillgängliga paletter

------------------------------------------------------------------------

## gbg_colors() {#gbg_colors}

### Beskrivning

Hämtar specifik färg eller alla tillgängliga färger från Göteborgs Stads färgpalett.

### Syntax

``` r
gbg_colors(color = NULL)
```

### Parametrar

-   **color** (character, valfritt): Namn på färg att hämta. Om `NULL` returneras alla färger.

### Returnerar

-   Om `color` specificerad: Character string med hex-färgkod (t.ex. `"#0076bc"`)
-   Om `color = NULL`: Named list med alla färger

### Tillgängliga färger

#### Huvudfärg

-   `"blue"` - Göteborgsblå (#0076bc)

#### Mörka färger

-   `"dark_blue"` - Mörkblå (#3f5564)
-   `"dark_green"` - Grön (#008767)
-   `"dark_cyan"` - Turkos (#008391)
-   `"dark_yellow"` - Gul (#ffcd37)
-   `"dark_red"` - Röd (#d24723)
-   `"dark_pink"` - Rosa (#d53878)
-   `"dark_purple"` - Lila (#674a99)

#### Ljusa färger

-   `"light_gray"` - Grå (#d1d9dc)
-   `"light_green"` - Ljusgrön (#b7e1c8)
-   `"light_cyan"` - Ljusblå (#bfe4f2)
-   `"light_yellow"` - Ljusgul (#fff2b0)
-   `"light_orange"` - Aprikos (#faceb9)
-   `"light_pink"` - Ljusrosa (#f8ccdc)
-   `"light_purple"` - Violett (#e0d0e7)

#### Övriga

-   `"white"` - Vit (#ffffff)
-   `"black"` - Svart (#000000)

### Exempel

``` r
# Hämta Göteborgsblå
gbg_colors("blue")
# → "#0076bc"

# Hämta grön
gbg_colors("dark_green")
# → "#008767"

# Hämta alla färger
alla_farger <- gbg_colors()
# → List med 17 färger

# Använd i base R plot
plot(x, y, col = gbg_colors("blue"))

# Skapa vektor med flera färger
mina_farger <- c(
  gbg_colors("blue"),
  gbg_colors("dark_green"),
  gbg_colors("dark_yellow")
)
```

### Felhantering

Om en färg som inte finns efterfrågas:

``` r
gbg_colors("felaktig_färg")
# Error: Färgen 'felaktig_färg' finns inte.
# Tillgängliga färger: blue, dark_blue, dark_green, ...
```

------------------------------------------------------------------------

## gbg_palette() {#gbg_palette}

### Beskrivning

Hämtar färgpalett enligt Göteborgs Stads grafiska profil. Stödjer tre typer av paletter: sequential, diverging och categorical.

### Syntax

``` r
gbg_palette(type = "sequential", 
            palette = NULL, 
            n = NULL, 
            direction = 1)
```

### Parametrar

-   **type** (character): Typ av palett
    -   `"sequential"` - För ordnade värden (låg → hög)
    -   `"diverging"` - För avvikelser (negativ → neutral → positiv)
    -   `"categorical"` - För kategorier utan ordning
-   **palette** (character, valfritt): Namn på specifik palett
    -   Om `NULL`: Returnerar första paletten i typen (default)
    -   Se [Paletter](#paletter) för alla tillgängliga namn
-   **n** (integer, valfritt): Antal färger att interpolera till
    -   Om `NULL`: Returnerar palettens originalfärger
    -   Om specificerad: Interpolerar till exakt `n` färger
    -   Minimum: 2
-   **direction** (integer): Ordning på färgerna
    -   `1` - Normal ordning (default)
    -   `-1` - Omvänd ordning

### Returnerar

Character vector med hex-färgkoder

### Exempel

#### Sequential paletter

``` r
# Standard blå gradient (3 färger)
gbg_palette("sequential", "blue")
# → c("#bfe4f2", "#0076bc", "#3f5564")

# Grön gradient interpolerad till 7 färger
gbg_palette("sequential", "green", n = 7)
# → 7 gröna nyanser från ljus till mörk

# Omvänd ordning (mörk → ljus)
gbg_palette("sequential", "blue", direction = -1)
# → c("#3f5564", "#0076bc", "#bfe4f2")

# Första sequential paletten (default)
gbg_palette("sequential")
# → Samma som gbg_palette("sequential", "blue")
```

#### Diverging paletter

``` r
# Röd-Vit-Grön (5 färger)
gbg_palette("diverging", "red_green")
# → c("#d24723", "#faceb9", "#ffffff", "#b7e1c8", "#008767")

# Interpolera till 9 färger för fler nyanser
gbg_palette("diverging", "red_green", n = 9)

# Blå-Vit-Röd
gbg_palette("diverging", "blue_red")
```

#### Categorical paletter

``` r
# 4 kategorier (rekommenderad)
gbg_palette("categorical", "palette_4")
# → c("#0076bc", "#000000", "#ffcd37", "#008767")

# 7 kategorier (maximum)
gbg_palette("categorical", "palette_7")
# → 7 distinkta färger

# OBS: Interpolera inte categorical paletter!
# Använd alltid originalfärgerna (n = NULL)
```

### Best Practices

#### Sequential

``` r
# För kartor och diagram med numeriska värden
# Låg = ljus, Hög = mörk
ggplot(data, aes(fill = population_density)) + 
  geom_sf(color = "white") +
  scale_fill_gradientn(
    colors = gbg_palette("sequential", "blue", n = 7)
  )
```

#### Diverging

``` r
# För avvikelser från neutralvärde
# Negativ = röd, Neutral = vit, Positiv = grön
ggplot(data, aes(fill = change_percent)) + 
  geom_sf(color = "white") +
  scale_fill_gradientn(
    colors = gbg_palette("diverging", "red_green", n = 9),
    limits = c(-50, 50),
    values = scales::rescale(c(-50, -25, 0, 25, 50))
  )
```

#### Categorical

``` r
# För kategorier utan inbördes ordning
# MAX 7 kategorier rekommenderas
farger <- gbg_palette("categorical", "palette_5")
barplot(values, col = farger, names.arg = categories)
```

### Felhantering

``` r
# Ogiltig typ
gbg_palette("felaktig_typ")
# Error: Typ 'felaktig_typ' finns inte.
# Giltiga typer: sequential, diverging, categorical

# Ogiltig palett
gbg_palette("sequential", "finns_inte")
# Error: Paletten 'finns_inte' finns inte i typ 'sequential'.
# Tillgängliga: blue, green, yellow_red, ...

# För få färger
gbg_palette("sequential", "blue", n = 1)
# Error: Antal färger (n) måste vara minst 2
```

------------------------------------------------------------------------

## choose_text_color() {#choose_text_color}

### Beskrivning

Väljer optimal textfärg (svart eller vit) baserat på bakgrundsfärgens ljushet för att säkerställa tillräcklig kontrast enligt WCAG AA-standard.

### Syntax

``` r
choose_text_color(background_color)
```

### Parametrar

-   **background_color** (character): Hex-färgkod för bakgrundsfärg (med eller utan `#`)

### Returnerar

Character string: `"#000000"` (svart) eller `"#ffffff"` (vit)

### Algoritm

Använder W3C-formeln för perceived brightness:

```         
luminance = (0.299 × R + 0.587 × G + 0.114 × B) / 255
```

-   Om `luminance > 0.5`: Ljus bakgrund → returnera svart text
-   Om `luminance ≤ 0.5`: Mörk bakgrund → returnera vit text

### Exempel

``` r
# Göteborgsblå (mörk) → vit text
choose_text_color("#0076bc")
# → "#ffffff"

# Ljusgul (ljus) → svart text
choose_text_color("#fff2b0")
# → "#000000"

# Fungerar med eller utan #
choose_text_color("0076bc")
# → "#ffffff"

# Använd i ggplot2
library(ggplot2)
bakgrund <- gbg_colors("dark_green")
text <- choose_text_color(bakgrund)

ggplot(data, aes(x = category, y = value)) +
  geom_col(fill = bakgrund) +
  geom_text(
    aes(label = value),
    color = text,
    vjust = -0.5
  )
```

### Användningsområden

#### 1. Tabeller med färgade celler

``` r
library(gt)

data %>%
  gt() %>%
  tab_style(
    style = cell_fill(color = gbg_colors("blue")),
    locations = cells_body(columns = category)
  ) %>%
  tab_style(
    style = cell_text(color = choose_text_color(gbg_colors("blue"))),
    locations = cells_body(columns = category)
  )
```

#### 2. Labels på kartor

``` r
# Skapa labels med optimal kontrast
df$text_color <- sapply(df$fill_color, choose_text_color)

ggplot(df, aes(fill = fill_color)) +
  geom_sf() +
  geom_sf_text(aes(label = name, color = text_color)) +
  scale_fill_identity() +
  scale_color_identity()
```

#### 3. Badges och highlights

``` r
# Skapa färgade badges med rätt textfärg
create_badge <- function(text, bg_color) {
  text_color <- choose_text_color(bg_color)
  sprintf(
    '<span style="background:%s; color:%s; padding:2px 8px;">%s</span>',
    bg_color, text_color, text
  )
}

create_badge("Hög prioritet", gbg_colors("dark_red"))
```

------------------------------------------------------------------------

## show_palette() {#show_palette}

### Beskrivning

Visualiserar en färgpalett som en enkel ggplot2-graf. Användbart för att förhandsgranska paletter och verifiera färger.

### Syntax

``` r
show_palette(colors, labels = NULL)
```

### Parametrar

-   **colors** (character vector): Vektor med hex-färgkoder att visualisera
-   **labels** (character vector, valfritt): Anpassade etiketter för varje färg
    -   Om `NULL`: Använder hex-koder som etiketter
    -   Måste ha samma längd som `colors`

### Returnerar

Ett ggplot2-objekt som kan visas eller sparas

### Beroenden

Kräver paketet `ggplot2`

### Exempel

``` r
library(ggplot2)

# Visa sequential palett
show_palette(gbg_palette("sequential", "blue"))

# Visa categorical palett
show_palette(gbg_palette("categorical", "palette_4"))

# Med anpassade labels
farger <- gbg_palette("sequential", "blue", n = 5)
show_palette(
  farger,
  labels = c("Mycket låg", "Låg", "Medel", "Hög", "Mycket hög")
)

# Spara till fil
p <- show_palette(gbg_palette("diverging", "red_green"))
ggsave("min_palett.png", p, width = 8, height = 2, dpi = 300)

# Jämför flera paletter
library(patchwork)

p1 <- show_palette(gbg_palette("sequential", "blue"))
p2 <- show_palette(gbg_palette("sequential", "green"))
p3 <- show_palette(gbg_palette("sequential", "yellow_red"))

p1 / p2 / p3
```

### Anpassning

``` r
# Grundvisualisering kan anpassas med ggplot2-themes
p <- show_palette(gbg_palette("categorical", "palette_7"))

p + 
  labs(title = "Categorical Palette - 7 kategorier") +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))
```

### Tips

-   Använd för att verifiera paletter innan användning
-   Kombinera med `patchwork` för att jämföra flera paletter
-   Exportera för dokumentation eller presentationer

------------------------------------------------------------------------

## gbg_palette_gradient() {#gbg_palette_gradient}

### Beskrivning

Skapar en gradient mellan två eller flera färger genom interpolering. Användbart för att skapa anpassade färgskalor.

### Syntax

``` r
gbg_palette_gradient(colors, n = 10)
```

### Parametrar

-   **colors** (character vector): Vektor med 2+ hex-färgkoder
-   **n** (integer): Antal färger i gradienten (default: 10, minimum: 2)

### Returnerar

Character vector med `n` hex-färgkoder

### Exempel

``` r
# Gradient mellan ljusblå och mörkblå
gbg_palette_gradient(
  c(gbg_colors("light_cyan"), gbg_colors("blue")),
  n = 10
)

# Gradient mellan tre färger
gbg_palette_gradient(
  c("#bfe4f2", "#0076bc", "#3f5564"),
  n = 20
)

# Använd i ggplot2
custom_gradient <- gbg_palette_gradient(
  c(gbg_colors("light_green"), gbg_colors("dark_green")),
  n = 100
)

ggplot(data, aes(x = x, y = y, fill = value)) +
  geom_tile() +
  scale_fill_gradientn(colors = custom_gradient)
```

### Användningsområden

#### 1. Anpassade färgskalor

``` r
# Skapa gradient mellan godtyckliga färger
warm_gradient <- gbg_palette_gradient(
  c(gbg_colors("light_yellow"), 
    gbg_colors("dark_yellow"), 
    gbg_colors("dark_red")),
  n = 50
)
```

#### 2. Utvidga befintliga paletter

``` r
# Ta en 3-färgspalett och skapa 20 nyanser
original <- gbg_palette("sequential", "blue")
extended <- gbg_palette_gradient(original, n = 20)
```

#### 3. Testa färgkombinationer

``` r
# Experimentera med färgövergångar
test_gradient <- gbg_palette_gradient(
  c(gbg_colors("dark_purple"), gbg_colors("dark_cyan")),
  n = 7
)
show_palette(test_gradient)
```

------------------------------------------------------------------------

## Färgdefinitioner {#färgdefinitioner}

### Alla färger i detalj

#### GOTEBORG_BLUE - Huvudfärg

``` r
list(
  name = "Göteborgsblå",
  hex = "#0076bc",
  rgb = c(0, 119, 188),
  cmyk = c(96, 37, 0, 5),
  text_color = "white"
)
```

**Användning:** Profilerande element, logotyp, rubriker

#### DARK_COLORS - Komplementfärger (mörka)

| Namn        | Hex     | RGB          | Användning               | Text  |
|:------------|:--------|:-------------|:-------------------------|:------|
| **Mörkblå** | #3f5564 | 63, 85, 100  | Datavärden, kartor       | Vit   |
| **Grön**    | #008767 | 0, 135, 103  | Positiva värden, miljö   | Vit   |
| **Turkos**  | #008391 | 0, 131, 145  | Vatten, hav              | Vit   |
| **Gul**     | #ffcd37 | 255, 205, 55 | Varningar, uppmärksamhet | Svart |
| **Röd**     | #d24723 | 210, 71, 35  | Negativa värden, risk    | Vit   |
| **Rosa**    | #d53878 | 213, 56, 120 | Accenter, highlights     | Vit   |
| **Lila**    | #674a99 | 103, 74, 153 | Variation, kategorier    | Vit   |

#### LIGHT_COLORS - Komplementfärger (ljusa)

| Namn         | Hex     | RGB           | Användning                  | Text  |
|:-------------|:--------|:--------------|:----------------------------|:------|
| **Grå**      | #d1d9dc | 209, 217, 220 | Neutrala värden, bakgrund   | Svart |
| **Ljusgrön** | #b7e1c8 | 183, 225, 200 | Låga värden (grön skala)    | Svart |
| **Ljusblå**  | #bfe4f2 | 191, 228, 242 | Låga värden (blå skala)     | Svart |
| **Ljusgul**  | #fff2b0 | 255, 242, 176 | Låga värden (gul skala)     | Svart |
| **Aprikos**  | #faceb9 | 250, 206, 185 | Neutrala värden (diverging) | Svart |
| **Ljusrosa** | #f8ccdc | 248, 204, 220 | Låga värden (rosa skala)    | Svart |
| **Violett**  | #e0d0e7 | 224, 208, 231 | Låga värden (lila skala)    | Svart |

------------------------------------------------------------------------

## Paletter {#paletter}

### SEQUENTIAL_PALETTES (11 st)

#### Huvudpaletter (3 st)

**blue** - Standard blå gradient

``` r
c("#bfe4f2", "#0076bc", "#3f5564")
```

-   Ljusblå → Göteborgsblå → Mörkblå
-   Användning: Befolkningstäthet, standardkartor

**green** - Grön gradient

``` r
c("#b7e1c8", "#008767", "#3f5564")
```

-   Ljusgrön → Grön → Mörkblå
-   Användning: Miljödata, grönområden, positiva indikatorer

**yellow_red** - Varningsgradient

``` r
c("#fff2b0", "#ffcd37", "#d24723")
```

-   Ljusgul → Gul → Röd
-   Användning: Risk, varningar, negativa indikatorer

#### Single Hue (6 st)

Paletter baserade på en färgfamilj:

**dark_blue**

``` r
c("#d1d9dc", "#8ca3af", "#3f5564")
```

**cyan**

``` r
c("#bfe4f2", "#5fc3cd", "#008391")
```

**yellow**

``` r
c("#fff2b0", "#ffe073", "#ffcd37")
```

**red**

``` r
c("#faceb9", "#e6886e", "#d24723")
```

**pink**

``` r
c("#f8ccdc", "#e882aa", "#d53878")
```

**purple**

``` r
c("#e0d0e7", "#a38dc0", "#674a99")
```

#### Multi Hue (2 st)

Paletter med flera färger i gradienten:

**yellow_green** (7 steg)

``` r
c("#ffffcc", "#d9f0a3", "#addd8e", "#78c679", 
  "#41ab5d", "#238b45", "#005824")
```

**yellow_green_dark** (7 steg)

``` r
c("#ffffcc", "#d9f0a3", "#addd8e", "#78c679", 
  "#41ab5d", "#238443", "#005a32")
```

### DIVERGING_PALETTES (3 st)

**red_green** - Negativ → Neutral → Positiv

``` r
c("#d24723", "#faceb9", "#ffffff", "#b7e1c8", "#008767")
```

-   Röd → Aprikos → Vit → Ljusgrön → Grön
-   Användning: Befolkningsförändring, budget över/under, plus/minus

**blue_red** - Kallt → Neutral → Varmt

``` r
c("#0076bc", "#bfe4f2", "#ffffff", "#faceb9", "#d24723")
```

-   Blå → Ljusblå → Vit → Aprikos → Röd
-   Användning: Temperatur, opinion för/emot

**purple_green** (7 steg)

``` r
c("#762a83", "#af8dc3", "#e7d4e8", "#f7f7f7", 
  "#d9f0d3", "#7fbf7b", "#1b7837")
```

-   Mer nyanser för detaljerad diverging-visualisering

### CATEGORICAL_PALETTES (7 st)

Inspiration från Urban Institute färglogik.

**palette_1** (1 färg)

``` r
c("#0076bc")
```

-   Göteborgsblå
-   Användning: En kategori, framhävning

**palette_2** (2 färger)

``` r
c("#0076bc", "#000000")
```

-   Blå + Svart
-   Användning: Binära jämförelser, ja/nej

**palette_3** (3 färger)

``` r
c("#0076bc", "#000000", "#008767")
```

-   Blå + Svart + Grön

**palette_4** (4 färger) ⭐ REKOMMENDERAD

``` r
c("#0076bc", "#000000", "#ffcd37", "#008767")
```

-   Blå + Svart + Gul + Grön
-   Användning: Standard för kategoriska data

**palette_5** (5 färger)

``` r
c("#0076bc", "#000000", "#ffcd37", "#008767", "#d53878")
```

-   

    -   Rosa (accent)

**palette_6** (6 färger)

``` r
c("#0076bc", "#000000", "#3f5564", "#ffcd37", "#008767", "#d53878")
```

-   

    -   Mörkblå (variant)

**palette_7** (7 färger)

``` r
c("#0076bc", "#000000", "#d1d9dc", "#ffcd37", "#008767", "#d53878", "#3f5564")
```

-   

    -   Grå (neutral)

-   Användning: Max antal kategorier

**OBS:** Rekommenderar max 7 kategorier för läsbarhet!

------------------------------------------------------------------------

## Ändringshistorik

**Version 1.0** (2025-10-31) - Första versionen - Alla funktioner dokumenterade

------------------------------------------------------------------------

*Dokumentation skapad: 2025-10-31*\
*För: colors_gothenburg.R v1.0*
