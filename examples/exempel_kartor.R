# ═══════════════════════════════════════════════════════════════════════════
# EXEMPEL: Kartor med ggplot2 och colors_gothenburg
# ═══════════════════════════════════════════════════════════════════════════
#
# Detta skript visar hur man skapar kartor med ggplot2 + sf + färgsystemet
# För grundläggande färganvändning, se exempel_colors.R
#
# Senast uppdaterad: 2025-10-31
# ═══════════════════════════════════════════════════════════════════════════

# SETUP ====================================================================

# Ladda färgsystemet
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")

# Ladda bibliotek
library(ggplot2)
library(sf)

cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("SKAPA TESTDATA FÖR KARTOR\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("\n")

# Skapa test-geometri (simulerade stadsdelar)
set.seed(123)

# Skapa 10 polygoner
create_polygon <- function(id, center_x, center_y, size = 0.5) {
  angle <- seq(0, 2 * pi, length.out = 7)
  x <- center_x + size * cos(angle) + rnorm(7, 0, 0.05)
  y <- center_y + size * sin(angle) + rnorm(7, 0, 0.05)
  # Stäng polygonen: första punkten = sista punkten
  x <- c(x, x[1])
  y <- c(y, y[1])
  st_polygon(list(cbind(x, y)))
}

# Skapa grid av polygoner
grid_x <- rep(1:4, each = 3)[1:10]
grid_y <- rep(1:3, 4)[1:10]

geometries <- lapply(1:10, function(i) {
  create_polygon(i, grid_x[i], grid_y[i])
})

# Skapa sf-objekt med testdata
stadsdelar <- st_sf(
  id = 1:10,
  namn = c("Centrum", "Majorna", "Hisingen", "Örgryte", "Angered",
           "Askim", "Högsbo", "Kortedala", "Bergsjön", "Torslanda"),
  
  # Sequential data
  befolkning = c(25000, 35000, 15000, 40000, 30000, 
                 12000, 18000, 22000, 16000, 11000),
  befolkning_per_km2 = c(4500, 3200, 1200, 5000, 2800,
                         800, 1500, 2200, 1800, 600),
  
  # Diverging data  
  befolkning_förändring = c(-5, 12, -8, 15, 10, -3, 8, -2, 5, -10),
  
  # Categorical data
  typ = factor(c("Centrum", "Stad", "Förort", "Stad", "Förort",
                 "Förort", "Industri", "Förort", "Förort", "Förort")),
  
  geometry = st_sfc(geometries, crs = 3006)
)

cat("✓ Skapade testdata: 10 stadsdelar\n")


# 1. SEQUENTIAL - KONTINUERLIG SKALA ======================================

cat("\n=== 1. SEQUENTIAL - KONTINUERLIG SKALA ===\n")

# Befolkningstäthet med blå gradient
p1 <- ggplot(stadsdelar, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.5) +
  scale_fill_gbg_sequential(
    "blue",
    name = "Personer\nper km²"
  ) +
  labs(
    title = "Befolkningstäthet i Göteborg",
    subtitle = "Kontinuerlig blå gradient"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_1_sequential_continuous.png", p1, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_1_sequential_continuous.png\n")


# 2. SEQUENTIAL - DISKRET SKALA ===========================================

cat("\n=== 2. SEQUENTIAL - DISKRET SKALA ===\n")

# Klassindelad data med 5 klasser
stadsdelar$befolkning_klass <- cut(
  stadsdelar$befolkning_per_km2,
  breaks = 5,
  labels = c("Mycket låg", "Låg", "Medel", "Hög", "Mycket hög")
)

p2 <- ggplot(stadsdelar, aes(fill = befolkning_klass)) +
  geom_sf(color = "white", linewidth = 0.5) +
  scale_fill_gbg_sequential(
    "blue",
    n = 5,
    discrete = TRUE,
    name = "Täthet"
  ) +
  labs(
    title = "Befolkningstäthet i Göteborg",
    subtitle = "Diskret skala med 5 klasser"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_2_sequential_discrete.png", p2, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_2_sequential_discrete.png\n")


# 3. SEQUENTIAL - GRÖN GRADIENT (positiva värden) =========================

cat("\n=== 3. SEQUENTIAL - GRÖN GRADIENT ===\n")

p3 <- ggplot(stadsdelar, aes(fill = befolkning)) +
  geom_sf(color = "white", linewidth = 0.5) +
  geom_sf_text(aes(label = format(befolkning, big.mark = " ")),
               size = 3, color = "white") +
  scale_fill_gbg_sequential(
    "green",
    name = "Befolkning"
  ) +
  labs(
    title = "Befolkning per stadsdel",
    subtitle = "Grön gradient (positiva värden)"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_3_sequential_green.png", p3, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_3_sequential_green.png\n")


# 4. DIVERGING - BEFOLKNINGSFÖRÄNDRING ====================================

cat("\n=== 4. DIVERGING - BEFOLKNINGSFÖRÄNDRING ===\n")

# Röd-Vit-Grön för förändring
max_change <- max(abs(stadsdelar$befolkning_förändring))

p4 <- ggplot(stadsdelar, aes(fill = befolkning_förändring)) +
  geom_sf(color = "white", linewidth = 0.5) +
  geom_sf_text(aes(label = paste0(
    ifelse(befolkning_förändring > 0, "+", ""), 
    befolkning_förändring, "%"
  )), size = 3) +
  scale_fill_gbg_diverging(
    "red_green",
    name = "Förändring (%)",
    limits = c(-max_change, max_change)
  ) +
  labs(
    title = "Befolkningsförändring 2020-2024",
    subtitle = "Röd = minskning, Grön = ökning"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  ) +
  guides(fill = guide_colorbar(barwidth = 15, barheight = 0.5))

ggsave("karta_4_diverging_change.png", p4, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_4_diverging_change.png\n")


# 5. DIVERGING - DISKRET SKALA ============================================

cat("\n=== 5. DIVERGING - DISKRET SKALA ===\n")

# Klassindelad förändring
stadsdelar$förändring_klass <- cut(
  stadsdelar$befolkning_förändring,
  breaks = c(-Inf, -5, -2, 2, 5, Inf),
  labels = c("Stark minskning", "Minskning", "Stabil", "Ökning", "Stark ökning")
)

p5 <- ggplot(stadsdelar, aes(fill = förändring_klass)) +
  geom_sf(color = "white", linewidth = 0.5) +
  scale_fill_gbg_diverging(
    "red_green",
    n = 5,
    discrete = TRUE,
    name = "Förändring"
  ) +
  labs(
    title = "Befolkningsförändring klassindelad",
    subtitle = "5 klasser: Stark minskning → Stark ökning"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_5_diverging_discrete.png", p5, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_5_diverging_discrete.png\n")


# 6. CATEGORICAL - STADSDELSTYPER =========================================

cat("\n=== 6. CATEGORICAL - STADSDELSTYPER ===\n")

# Categorical med 4 färger (3 typer + background)
p6 <- ggplot(stadsdelar, aes(fill = typ)) +
  geom_sf(color = "white", linewidth = 0.5) +
  geom_sf_text(aes(label = namn), size = 2.5) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Typ"
  ) +
  labs(
    title = "Stadsdelstyper i Göteborg",
    subtitle = "Categorical palett med 4 färger"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_6_categorical.png", p6, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_6_categorical.png\n")


# 7. MED LABELS OCH ANNOTATIONS ===========================================

cat("\n=== 7. MED LABELS OCH ANNOTATIONS ===\n")

# Karta med mer information
p7 <- ggplot(stadsdelar, aes(fill = befolkning_per_km2)) +
  geom_sf(color = "white", linewidth = 0.5) +
  geom_sf_text(
    aes(label = namn),
    size = 2.5,
    color = "black",
    fontface = "bold"
  ) +
  scale_fill_gbg_sequential(
    "blue",
    name = "Personer/km²",
    breaks = c(1000, 2000, 3000, 4000, 5000),
    labels = c("1 000", "2 000", "3 000", "4 000", "5 000")
  ) +
  labs(
    title = "Befolkningstäthet i Göteborg",
    subtitle = "Antal invånare per kvadratkilometer",
    caption = "Källa: Testdata för demonstration"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 16),
    plot.subtitle = element_text(size = 12),
    plot.caption = element_text(hjust = 0, size = 9, color = "grey50"),
    legend.position = "right"
  )

ggsave("karta_7_with_labels.png", p7, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade karta_7_with_labels.png\n")


# 8. MINIMAL THEME ========================================================

cat("\n=== 8. MINIMAL THEME ===\n")

# Clean map utan distraherande element
p8 <- ggplot(stadsdelar, aes(fill = befolkning)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential(
    "blue",
    name = "Befolkning"
  ) +
  labs(title = "Befolkning per stadsdel") +
  theme_void() +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5, size = 14),
    legend.position = "bottom"
  ) +
  guides(fill = guide_colorbar(barwidth = 12, barheight = 0.5))

ggsave("karta_8_minimal.png", p8, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_8_minimal.png\n")


# 9. KOMBINERA FILL OCH COLOR =============================================

cat("\n=== 9. KOMBINERA FILL OCH COLOR ===\n")

# Använd både fill och color för border emphasis
p9 <- ggplot(stadsdelar, aes(fill = typ)) +
  geom_sf(aes(color = typ), linewidth = 1.5, alpha = 0.7) +
  scale_fill_gbg_categorical("palette_4", name = "Typ") +
  scale_color_gbg_categorical("palette_4", name = "Typ") +
  labs(
    title = "Stadsdelstyper med tydliga gränser",
    subtitle = "Använder både fill och color"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("karta_9_fill_and_color.png", p9, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade karta_9_fill_and_color.png\n")


# 10. FACETS MED OLIKA VARIABLER ==========================================

cat("\n=== 10. FACETS MED OLIKA VARIABLER ===\n")

# Skapa long format för faceting
library(tidyr)
stadsdelar_long <- stadsdelar %>%
  st_drop_geometry() %>%
  select(namn, befolkning, befolkning_per_km2, befolkning_förändring) %>%
  pivot_longer(cols = -namn, names_to = "variabel", values_to = "värde") %>%
  left_join(stadsdelar %>% select(namn, geometry), by = "namn") %>%
  st_as_sf()

# Lägg till bättre labels
stadsdelar_long$variabel_label <- factor(
  stadsdelar_long$variabel,
  levels = c("befolkning", "befolkning_per_km2", "befolkning_förändring"),
  labels = c("Befolkning", "Täthet (per km²)", "Förändring (%)")
)

p10 <- ggplot(stadsdelar_long, aes(fill = värde)) +
  geom_sf(color = "white", linewidth = 0.3) +
  scale_fill_gbg_sequential("blue") +
  facet_wrap(~ variabel_label) +  # Ta bort scales = "free"
  labs(
    title = "Befolkningsstatistik per stadsdel",
    subtitle = "OBS: Olika skalor för olika variabler",
    fill = "Värde"
  ) +
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    strip.text = element_text(face = "bold", size = 11),
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  ) +
  guides(fill = guide_colorbar(barwidth = 10, barheight = 0.5))

ggsave("karta_10_facets.png", p10, 
       width = 12, height = 4, dpi = 150)
cat("✓ Skapade karta_10_facets.png\n")


# SAMMANFATTNING ==========================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("SAMMANFATTNING - KARTOR\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Skapade kartexempel:\n")
cat("  1. karta_1_sequential_continuous.png   - Kontinuerlig blå gradient\n")
cat("  2. karta_2_sequential_discrete.png     - Diskret 5-klassskala\n")
cat("  3. karta_3_sequential_green.png        - Grön gradient\n")
cat("  4. karta_4_diverging_change.png        - Röd-Grön förändring\n")
cat("  5. karta_5_diverging_discrete.png      - Klassindelad förändring\n")
cat("  6. karta_6_categorical.png             - Categorical typer\n")
cat("  7. karta_7_with_labels.png             - Med labels & annotations\n")
cat("  8. karta_8_minimal.png                 - Minimal clean theme\n")
cat("  9. karta_9_fill_and_color.png          - Fill + color kombination\n")
cat(" 10. karta_10_facets.png                 - Facets med flera variabler\n")
cat("\n")
cat("Tekniker som demonstrerades:\n")
cat("  ✓ Sequential scales (kontinuerlig & diskret)\n")
cat("  ✓ Diverging scales (kontinuerlig & diskret)\n")
cat("  ✓ Categorical scales\n")
cat("  ✓ geom_sf_text() för labels\n")
cat("  ✓ Custom breaks och labels\n")
cat("  ✓ Theme-anpassningar\n")
cat("  ✓ Legend-positionering\n")
cat("  ✓ Kombinera fill och color\n")
cat("  ✓ Faceting\n")
cat("\n")
cat("Nästa steg:\n")
cat("  - Se exempel_diagram.R för diagram och andra visualiseringar\n")
cat("  - Se funktioner_katalog_ggplot.md för fullständig dokumentation\n")
cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")