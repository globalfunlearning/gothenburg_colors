# Färgblindanpassning i Gothenburg Colors

Detta dokument beskriver hur Gothenburg Colors-paletten är anpassad för personer med olika typer av färgblindhet och hur du kan verifiera tillgänglighet.

---

## Typer av färgblindhet

**Protanopi** (röd-grön färgblindhet)
- Påverkar ~1% av män, <0.01% av kvinnor
- Svårighet att se skillnad mellan rött och grönt
- Rött ser mörkare ut

**Deuteranopi** (grön färgblindhet)
- Påverkar ~1% av män, <0.01% av kvinnor  
- Svårighet att se skillnad mellan rött och grönt
- Vanligaste formen av färgblindhet

**Tritanopi** (blå-gul färgblindhet)
- Mycket ovanlig (~0.001% av befolkningen)
- Svårighet att se skillnad mellan blått och grönt, gult och rött

---

## Hur Gothenburg Colors är anpassad

### Sequential paletter

Alla sequential paletter använder **ljushet-gradient** som primär kodning:
- Låga värden = ljusa färger
- Höga värden = mörka färger

Detta fungerar även om färgnyansen inte går att uppfatta.

**Exempel:**
```r
# Blå gradient
gbg_palette("sequential", "blue")
# → "#bfe4f2" (ljus) → "#0076bc" (medel) → "#3f5564" (mörk)

# Även färgblinda kan se skillnad på ljusheten
```

### Diverging paletter

Diverging paletter använder:
1. **Kontrast mellan varm och kall färg**
2. **Symmetrisk ljushet** runt neutral mittfärg (vit)

**OBS:** `red_green`-paletten kan vara problematisk för protanopi/deuteranopi. 
Använd alternativ palett vid behov:

```r
# Undvik för röd-grön färgblinda:
scale_fill_gbg_diverging("red_green")

# Använd istället:
scale_fill_gbg_diverging("blue_red")    # Kallt-varmt
scale_fill_gbg_diverging("purple_green") # Fler nyanser
```

### Categorical paletter

Categorical paletter maximerar **skillnad i både färgton OCH ljushet**:

```r
# palette_4 kombinerar:
# - Blå (#0076bc) - mörk, kall
# - Svart (#000000) - mörkast
# - Gul (#ffcd37) - ljus, varm
# - Grön (#008767) - mörk, medelvarm

# Varje färg är distinkt även utan färgseende
```

**Max 7 kategorier rekommenderas** - fler blir svåra att skilja även med perfekt färgseende.

---

## Verifiera tillgänglighet

### 1. Använd check_color_contrast()

Kontrollera kontrast mellan färger:

```r
# Kontrollera text på färgad bakgrund
check_color_contrast(
  gbg_colors("blue"),    # Bakgrund
  gbg_colors("white")    # Text
)

# Output visar WCAG AA/AAA-status
```

### 2. Använd choose_text_color()

Välj automatiskt optimal textfärg:

```r
# Välj svart eller vit text
bakgrund <- gbg_colors("dark_yellow")
text <- choose_text_color(bakgrund)

ggplot(data, aes(x = x, fill = category)) +
  geom_col() +
  geom_text(aes(label = value), color = text)
```

### 3. Simulera färgblindhet

#### Online-verktyg:
- **Coblis Color Blindness Simulator:** https://www.color-blindness.com/coblis-color-blindness-simulator/
- **Colorbrewer:** https://colorbrewer2.org/ (välj "colorblind safe")

#### R-paket:
```r
# Installera colorblindcheck
install.packages("colorblindcheck")
library(colorblindcheck)

# Testa palett
palette <- gbg_palette("sequential", "blue", n = 7)
palette_check(palette, plot = TRUE)
```

#### Adobe-verktyg:
- Adobe Color Accessibility Tools
- Använd "Vision Simulator" i Adobe Illustrator/Photoshop

---

## Best Practices

### 1. Använd redundant kodning

Kombinera färg med andra visuella element:

```r
# Bra: Färg + form + etikett
ggplot(data, aes(x = x, y = y, color = type, shape = type)) +
  geom_point(size = 3) +
  geom_text(aes(label = type), nudge_y = 0.5) +
  scale_color_gbg_categorical("palette_4")
```

### 2. Lägg till mönster för print

Vid utskrift i svartvitt:

```r
# Använd fill + pattern
library(ggpattern)

ggplot(data, aes(x = category, y = value)) +
  geom_col_pattern(
    aes(fill = category, pattern = category),
    pattern_spacing = 0.02,
    pattern_density = 0.5
  ) +
  scale_fill_gbg_categorical("palette_4")
```

### 3. Direkt märkning istället för legend

```r
# Undvik:
ggplot(data, aes(x = x, y = y, color = category)) +
  geom_line() +
  scale_color_gbg_categorical("palette_4")

# Bättre:
ggplot(data, aes(x = x, y = y, color = category)) +
  geom_line() +
  geom_text(
    data = data %>% group_by(category) %>% slice_max(x),
    aes(label = category),
    hjust = -0.1
  ) +
  scale_color_gbg_categorical("palette_4") +
  theme(legend.position = "none")
```

### 4. Testa i gråskala

Exportera och titta på i svartvitt:

```r
# Spara plot
ggsave("test_plot.png", width = 8, height = 6)

# Konvertera till gråskala (ImageMagick)
system("convert test_plot.png -colorspace Gray test_plot_gray.png")
```

---

## Designprinciper sammanfattat

✅ **GÖR:**
- Använd ljushet-gradient för sequential
- Kombinera färg med form/text/mönster
- Testa paletter i gråskala
- Använd max 7 kategorier
- Kontrollera kontrast med `check_color_contrast()`

❌ **UNDVIK:**
- Enbart färg för viktig information
- Röd-grön utan alternativ kodning
- Fler än 7 kategorier i categorical
- Subtila färgskillnader (använd kontrast)
- Pastellfärger på vit bakgrund (dålig kontrast)

---

## Exempel: Tillgänglig karta

```r
library(ggplot2)
library(sf)

# Ladda färgsystem
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")

# Skapa tillgänglig karta
ggplot(kommuner, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.5) +  # Tydliga gränser
  geom_sf_text(                                 # Direkt märkning
    aes(label = round(befolkning_per_km2, 0)),
    color = "black",
    size = 3
  ) +
  scale_fill_gbg_sequential(
    "blue",
    name = "Befolkning per km²",
    breaks = c(0, 100, 500, 1000, 2000),
    labels = c("0", "100", "500", "1 000", "2 000")
  ) +
  labs(
    title = "Befolkningstäthet",
    subtitle = "Antal invånare per kvadratkilometer",
    caption = "Källa: SCB"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 14),
    panel.grid = element_blank()
  )
```

**Varför detta är tillgängligt:**
- Sequential blå palett (ljus → mörk)
- Vita gränser mellan områden
- Direkta labels med siffror
- Tydlig title och caption
- God kontrast

---

## Referenser och verktyg

**Dokumentation:**
- [WCAG 2.1 Färgkontrast](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html)
- [Colorbrewer - Colorblind Safe Palettes](https://colorbrewer2.org/)
- [Urban Institute - Do No Harm Guide](https://www.urban.org/research/publication/do-no-harm-guide-centering-accessibility-data-visualization)

**R-paket:**
- `colorblindcheck` - Testa paletter för färgblindhet
- `viridis` - Färgblindvänliga paletter (jämförelse)
- `khroma` - Vetenskapliga färgpaletter

**Online-verktyg:**
- Coblis Simulator: https://www.color-blindness.com/coblis-color-blindness-simulator/
- Adobe Color: https://color.adobe.com/create/color-accessibility
- Contrast Checker: https://webaim.org/resources/contrastchecker/

**R-funktioner i detta paket:**
```r
check_color_contrast()   # Kontrollera kontrast
choose_text_color()      # Välj optimal textfärg
show_palette()           # Visualisera palett
```

---

## Testa dina visualiseringar

### Checklista:

- [ ] Kontrast minst 4.5:1 för text (kör `check_color_contrast()`)
- [ ] Fungerar i gråskala
- [ ] Max 7 kategorier för categorical
- [ ] Direkt märkning där möjligt
- [ ] Testas med färgblindhetssimulator
- [ ] Redundant kodning (färg + form/text)
- [ ] Tydliga gränser mellan områden (kartor)
- [ ] Alternativ till röd-grön vid behov

### Testkommando:

```r
# Installera och testa
install.packages("colorblindcheck")
library(colorblindcheck)

# Testa en palett
pal <- gbg_palette("categorical", "palette_7")
palette_check(pal, plot = TRUE)

# Output visar hur paletten ser ut för olika typer av färgblindhet
```

---

*Senast uppdaterad: 2025-11-23*  
*För: Gothenburg Colors v1.1*