# Changelog

Alla viktiga ändringar i detta projekt dokumenteras i denna fil.

Formatet är baserat på [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
och projektet följer [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Input-validering i alla funktioner för bättre felhantering
- `check_color_contrast()` - Kontrollera färgkontrast enligt WCAG AA/AAA
- Automatiserade tester med testthat för alla funktioner
- Dokumentation om färgblindanpassning i README

### Changed
- Förbättrad felhantering i `gbg_palette()` med validering av direction-parameter
- Starkare input-validering i alla ggplot2 scale-funktioner
- Uppdaterad dokumentation i funktionskataloger med nya funktioner

### Fixed
- Bättre felmeddelanden vid ogiltiga parametervärden

## [1.0.0] - 2025-10-31

### Added
- Initial release av Gothenburg Colors
- CORE färgsystem (`colors_gothenburg.R`)
  - 17 färger enligt Göteborgs Stads grafiska profil
  - 11 sequential paletter (single hue + multi hue)
  - 3 diverging paletter
  - 7 categorical paletter
  - `gbg_colors()` - Hämta enskilda färger
  - `gbg_palette()` - Hämta färgpaletter
  - `choose_text_color()` - Optimal textfärg för kontrast
  - `show_palette()` - Visualisera paletter
  - `gbg_palette_gradient()` - Skapa custom gradienter
- EXTENSION ggplot2-integration (`ggplot_scales_gothenburg.R`)
  - `scale_fill_gbg_sequential()` / `scale_color_gbg_sequential()`
  - `scale_fill_gbg_diverging()` / `scale_color_gbg_diverging()`
  - `scale_fill_gbg_categorical()` / `scale_color_gbg_categorical()`
- Komplett dokumentation
  - README.md med installation och snabbstart
  - SNABBGUIDE.md för snabbreferens
  - Funktionskataloger för colors och ggplot
- Exempel-skript
  - `exempel_colors.R` - Base R användning
  - `exempel_kartor.R` - ggplot2 kartor med sf
  - `exempel_diagram.R` - ggplot2 diagram
- MIT License
- .gitignore för R-projekt

### Notes
- Testat med R >= 4.0
- ggplot2 >= 3.0 krävs för scale-funktioner
- Alla paletter är färgblindanpassade
- Följer WCAG AA-standard för kontrast

---

## Versionshantering

**Format:** [MAJOR.MINOR.PATCH]

- **MAJOR**: Brytande ändringar i API
- **MINOR**: Nya funktioner (bakåtkompatibla)
- **PATCH**: Buggfixar (bakåtkompatibla)

**Kategorier:**
- **Added**: Nya funktioner
- **Changed**: Ändringar i befintlig funktionalitet
- **Deprecated**: Funktioner som snart tas bort
- **Removed**: Borttagna funktioner
- **Fixed**: Buggfixar
- **Security**: Säkerhetsuppdateringar