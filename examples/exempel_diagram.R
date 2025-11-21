# ═══════════════════════════════════════════════════════════════════════════
# EXEMPEL: Diagram med ggplot2 och colors_gothenburg
# ═══════════════════════════════════════════════════════════════════════════
#
# Detta skript visar hur man skapar diagram med ggplot2 + färgsystemet
# För kartor, se exempel_kartor.R
#
# Senast uppdaterad: 2025-10-31
# ═══════════════════════════════════════════════════════════════════════════

# SETUP ====================================================================

# Ladda färgsystemet
source("colors_gothenburg.R")
source("ggplot_scales_gothenburg.R")

# Ladda bibliotek
library(ggplot2)
library(dplyr)

cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("SKAPA TESTDATA FÖR DIAGRAM\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("\n")

# Skapa olika typer av testdata
set.seed(123)

# Tidsserie-data
tidsserie <- data.frame(
  år = rep(2015:2024, each = 4),
  kvartal = rep(paste0("Q", 1:4), 10),
  kategori = rep(c("Kategori A", "Kategori B", "Kategori C", "Kategori D"), each = 10),
  värde = c(
    cumsum(rnorm(10, 2, 5)) + 100,   # A
    cumsum(rnorm(10, 1.5, 5)) + 90,  # B
    cumsum(rnorm(10, 1, 5)) + 85,    # C
    cumsum(rnorm(10, 0.5, 5)) + 80   # D
  )
)

# Förändring-data
förändring_data <- data.frame(
  stadsdel = c("Centrum", "Majorna", "Hisingen", "Örgryte", "Angered",
               "Askim", "Högsbo", "Kortedala", "Bergsjön", "Torslanda"),
  förändring = c(-5, 12, -8, 15, 10, -3, 8, -2, 5, -10)
)

# Kategorisk data
kategori_data <- data.frame(
  kategori = c("Kategori A", "Kategori B", "Kategori C", "Kategori D", 
               "Kategori E", "Kategori F", "Kategori G"),
  värde = c(35, 25, 20, 10, 5, 3, 2)
)

cat("✓ Skapade testdata för diagram\n")


# 1. LINJEDIAGRAM - CATEGORICAL ==========================================

cat("\n=== 1. LINJEDIAGRAM - CATEGORICAL ===\n")

p1 <- ggplot(tidsserie, aes(x = år, y = värde, color = kategori)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Utveckling över tid",
    subtitle = "4 kategorier med categorical palett",
    x = "År",
    y = "Värde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_1_line_categorical.png", p1, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_1_line_categorical.png\n")


# 2. STAPELDIAGRAM - CATEGORICAL ==========================================

cat("\n=== 2. STAPELDIAGRAM - CATEGORICAL ===\n")

p2 <- ggplot(kategori_data, aes(x = reorder(kategori, värde), y = värde, fill = kategori)) +
  geom_col() +
  scale_fill_gbg_categorical(
    "palette_7",
    name = "Kategori"
  ) +
  labs(
    title = "Fördelning per kategori",
    subtitle = "7 kategorier (max rekommenderat)",
    x = "Kategori",
    y = "Värde"
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_2_bar_categorical.png", p2, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade diagram_2_bar_categorical.png\n")


# 3. GRUPPERADE STAPLAR - CATEGORICAL =====================================

cat("\n=== 3. GRUPPERADE STAPLAR - CATEGORICAL ===\n")

# Skapa data för grupperade staplar
grouped_data <- tidsserie %>%
  filter(år %in% c(2020, 2022, 2024)) %>%
  group_by(år, kategori) %>%
  summarise(medel = mean(värde), .groups = "drop")

p3 <- ggplot(grouped_data, aes(x = as.factor(år), y = medel, fill = kategori)) +
  geom_col(position = "dodge", width = 0.7) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Jämförelse mellan år",
    subtitle = "Grupperade staplar",
    x = "År",
    y = "Medelvärde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_3_grouped_bars.png", p3, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_3_grouped_bars.png\n")


# 4. DIVERGING - FÖRÄNDRING ===============================================

cat("\n=== 4. DIVERGING - FÖRÄNDRING ===\n")

p4 <- ggplot(förändring_data, aes(x = reorder(stadsdel, förändring), y = förändring, fill = förändring)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey30") +
  scale_fill_gbg_diverging(
    "red_green",
    name = "Förändring (%)"
  ) +
  labs(
    title = "Befolkningsförändring per stadsdel",
    subtitle = "Röd = minskning, Grön = ökning",
    x = "Stadsdel",
    y = "Förändring (%)"
  ) +
  coord_flip() +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  ) +
  guides(fill = guide_colorbar(barwidth = 15, barheight = 0.5))

ggsave("diagram_4_diverging_change.png", p4, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade diagram_4_diverging_change.png\n")


# 5. SCATTER PLOT - SEQUENTIAL ============================================

cat("\n=== 5. SCATTER PLOT - SEQUENTIAL ===\n")

# Skapa scatter data
scatter_data <- data.frame(
  x = rnorm(200, 50, 15),
  y = rnorm(200, 50, 15)
)
scatter_data$z <- with(scatter_data, x + y + rnorm(200, 0, 10))

p5 <- ggplot(scatter_data, aes(x = x, y = y, color = z)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_gbg_sequential(
    "blue",
    name = "Z-värde"
  ) +
  labs(
    title = "Scatter plot med sequential färgskala",
    subtitle = "Färg representerar tredje variabel",
    x = "X-variabel",
    y = "Y-variabel"
  ) +
  theme_minimal() +
  theme(
    legend.position = "right",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_5_scatter_sequential.png", p5, 
       width = 9, height = 6, dpi = 150)
cat("✓ Skapade diagram_5_scatter_sequential.png\n")


# 6. BOXPLOT - CATEGORICAL ================================================

cat("\n=== 6. BOXPLOT - CATEGORICAL ===\n")

p6 <- ggplot(tidsserie, aes(x = kategori, y = värde, fill = kategori)) +
  geom_boxplot(alpha = 0.7) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Spridning per kategori",
    subtitle = "Boxplot visar median, kvartiler och outliers",
    x = "Kategori",
    y = "Värde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_6_boxplot.png", p6, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade diagram_6_boxplot.png\n")


# 7. AREA CHART - CATEGORICAL =============================================

cat("\n=== 7. AREA CHART - CATEGORICAL ===\n")

p7 <- ggplot(tidsserie, aes(x = år, y = värde, fill = kategori)) +
  geom_area(alpha = 0.8) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Stackad area chart",
    subtitle = "Visar relativ andel över tid",
    x = "År",
    y = "Kumulativt värde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_7_area.png", p7, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_7_area.png\n")


# 8. HEATMAP - SEQUENTIAL =================================================

cat("\n=== 8. HEATMAP - SEQUENTIAL ===\n")

# Skapa heatmap-data
heatmap_data <- tidsserie %>%
  group_by(år, kategori) %>%
  summarise(medel = mean(värde), .groups = "drop")

p8 <- ggplot(heatmap_data, aes(x = år, y = kategori, fill = medel)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = round(medel, 0)), color = "white", size = 3) +
  scale_fill_gbg_sequential(
    "blue",
    name = "Medelvärde"
  ) +
  labs(
    title = "Heatmap över tid och kategori",
    subtitle = "Medelvärde per år och kategori",
    x = "År",
    y = "Kategori"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

ggsave("diagram_8_heatmap.png", p8, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_8_heatmap.png\n")


# 9. FACETS - SEQUENTIAL ==================================================

cat("\n=== 9. FACETS - SEQUENTIAL ===\n")

p9 <- ggplot(tidsserie, aes(x = år, y = värde, fill = värde)) +
  geom_col() +
  scale_fill_gbg_sequential(
    "green",
    name = "Värde"
  ) +
  facet_wrap(~ kategori, ncol = 2) +
  labs(
    title = "Utveckling per kategori",
    subtitle = "Facets med sequential färgskala",
    x = "År",
    y = "Värde"
  ) +
  theme_minimal() +
  theme(
    strip.text = element_text(face = "bold"),
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_9_facets.png", p9, 
       width = 10, height = 8, dpi = 150)
cat("✓ Skapade diagram_9_facets.png\n")


# 10. KOMBINERAT EXEMPEL ==================================================

cat("\n=== 10. KOMBINERAT EXEMPEL ===\n")

# Skapa komplext diagram med flera element
summary_data <- tidsserie %>%
  group_by(år, kategori) %>%
  summarise(
    medel = mean(värde),
    min = min(värde),
    max = max(värde),
    .groups = "drop"
  )

p10 <- ggplot(summary_data, aes(x = år, y = medel, color = kategori)) +
  geom_ribbon(aes(ymin = min, ymax = max, fill = kategori), 
              alpha = 0.2, color = NA) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  scale_color_gbg_categorical("palette_4", name = "Kategori") +
  scale_fill_gbg_categorical("palette_4", name = "Kategori") +
  labs(
    title = "Utveckling med spridning",
    subtitle = "Linje = medel, band = min-max spridning",
    x = "År",
    y = "Värde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_10_combined.png", p10, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_10_combined.png\n")


# 11. BONUS: DENSITY PLOT =================================================

cat("\n=== 11. BONUS: DENSITY PLOT ===\n")

p11 <- ggplot(tidsserie, aes(x = värde, fill = kategori)) +
  geom_density(alpha = 0.7) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Densitetsfördelning per kategori",
    subtitle = "Visar fördelning av värden",
    x = "Värde",
    y = "Densitet"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_11_density.png", p11, 
       width = 10, height = 6, dpi = 150)
cat("✓ Skapade diagram_11_density.png\n")


# 12. BONUS: VIOLIN PLOT ==================================================

cat("\n=== 12. BONUS: VIOLIN PLOT ===\n")

p12 <- ggplot(tidsserie, aes(x = kategori, y = värde, fill = kategori)) +
  geom_violin(alpha = 0.7, draw_quantiles = c(0.25, 0.5, 0.75)) +
  geom_jitter(width = 0.1, alpha = 0.2, size = 1) +
  scale_fill_gbg_categorical(
    "palette_4",
    name = "Kategori"
  ) +
  labs(
    title = "Violin plot med datapunkter",
    subtitle = "Visar fördelning och individuella observationer",
    x = "Kategori",
    y = "Värde"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", size = 14)
  )

ggsave("diagram_12_violin.png", p12, 
       width = 8, height = 6, dpi = 150)
cat("✓ Skapade diagram_12_violin.png\n")


# SAMMANFATTNING ==========================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("SAMMANFATTNING - DIAGRAM\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Skapade diagramexempel:\n")
cat("  1. diagram_1_line_categorical.png      - Linjediagram\n")
cat("  2. diagram_2_bar_categorical.png       - Stapeldiagram\n")
cat("  3. diagram_3_grouped_bars.png          - Grupperade staplar\n")
cat("  4. diagram_4_diverging_change.png      - Diverging förändring\n")
cat("  5. diagram_5_scatter_sequential.png    - Scatter plot\n")
cat("  6. diagram_6_boxplot.png               - Boxplot\n")
cat("  7. diagram_7_area.png                  - Area chart\n")
cat("  8. diagram_8_heatmap.png               - Heatmap\n")
cat("  9. diagram_9_facets.png                - Facets\n")
cat(" 10. diagram_10_combined.png             - Kombinerat exempel\n")
cat(" 11. diagram_11_density.png              - Density plot\n")
cat(" 12. diagram_12_violin.png               - Violin plot\n")
cat("\n")
cat("Diagramtyper som demonstrerades:\n")
cat("  ✓ Linjediagram (geom_line)\n")
cat("  ✓ Stapeldiagram (geom_col)\n")
cat("  ✓ Scatter plot (geom_point)\n")
cat("  ✓ Boxplot (geom_boxplot)\n")
cat("  ✓ Area chart (geom_area)\n")
cat("  ✓ Heatmap (geom_tile)\n")
cat("  ✓ Density plot (geom_density)\n")
cat("  ✓ Violin plot (geom_violin)\n")
cat("\n")
cat("Färgskalor som användes:\n")
cat("  ✓ scale_color_gbg_categorical()\n")
cat("  ✓ scale_fill_gbg_categorical()\n")
cat("  ✓ scale_fill_gbg_sequential()\n")
cat("  ✓ scale_fill_gbg_diverging()\n")
cat("\n")
cat("Tekniker:\n")
cat("  ✓ Faceting\n")
cat("  ✓ Gruppering\n")
cat("  ✓ Transparens (alpha)\n")
cat("  ✓ Legend-positionering\n")
cat("  ✓ Theme-anpassningar\n")
cat("  ✓ Kombinera flera geoms\n")
cat("\n")
cat("Fullständig dokumentation:\n")
cat("  - funktioner_katalog_ggplot.md\n")
cat("  - SNABBGUIDE.md\n")
cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
