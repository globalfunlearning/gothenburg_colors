# ═══════════════════════════════════════════════════════════════════════════
# EXEMPEL: Grundläggande användning av colors_gothenburg.R
# ═══════════════════════════════════════════════════════════════════════════
#
# Detta skript visar hur man använder färgsystemet utan ggplot2
# För ggplot2-exempel, se exempel_kartor.R och exempel_diagram.R
#
# Senast uppdaterad: 2025-10-31
# ═══════════════════════════════════════════════════════════════════════════

# SETUP ====================================================================

# Ladda färgsystemet
source("colors_gothenburg.R")

# OBS: Detta skript kräver INTE ggplot2 (förutom för show_palette)


# 1. HÄMTA ENSKILDA FÄRGER ================================================

cat("\n=== 1. HÄMTA ENSKILDA FÄRGER ===\n\n")

# Göteborgsblå (huvudfärg)
goteborg_bla <- gbg_colors("blue")
cat("Göteborgsblå:", goteborg_bla, "\n")

# Mörka färger
gron <- gbg_colors("dark_green")
rod <- gbg_colors("dark_red")
gul <- gbg_colors("dark_yellow")

cat("Grön:", gron, "\n")
cat("Röd:", rod, "\n")
cat("Gul:", gul, "\n")

# Ljusa färger
ljusbla <- gbg_colors("light_cyan")
ljusgul <- gbg_colors("light_yellow")

cat("Ljusblå:", ljusbla, "\n")
cat("Ljusgul:", ljusgul, "\n")

# Hämta alla färger
alla_farger <- gbg_colors()
cat("\nTotalt antal färger:", length(alla_farger), "\n")


# 2. ANVÄNDA FÄRGER I BASE R PLOTS ========================================

cat("\n=== 2. ANVÄNDA FÄRGER I BASE R PLOTS ===\n")

# Enkel scatter plot
set.seed(123)
x <- rnorm(100)
y <- rnorm(100)

png("exempel_1_scatter.png", width = 800, height = 600, res = 120)
plot(x, y, 
     col = gbg_colors("blue"), 
     pch = 16, 
     cex = 1.5,
     main = "Scatter Plot med Göteborgsblå",
     xlab = "X-variabel",
     ylab = "Y-variabel")
dev.off()
cat("✓ Skapade exempel_1_scatter.png\n")

# Linjediagram med flera färger
png("exempel_2_lines.png", width = 800, height = 600, res = 120)
x <- 1:100
y1 <- cumsum(rnorm(100))
y2 <- cumsum(rnorm(100))
y3 <- cumsum(rnorm(100))

plot(x, y1, type = "l", lwd = 2, col = gbg_colors("blue"),
     ylim = range(c(y1, y2, y3)),
     main = "Linjediagram med tre kategorier",
     xlab = "Tid", ylab = "Värde")
lines(x, y2, lwd = 2, col = gbg_colors("dark_green"))
lines(x, y3, lwd = 2, col = gbg_colors("dark_red"))
legend("topleft", 
       legend = c("Kategori A", "Kategori B", "Kategori C"),
       col = c(gbg_colors("blue"), gbg_colors("dark_green"), gbg_colors("dark_red")),
       lwd = 2)
dev.off()
cat("✓ Skapade exempel_2_lines.png\n")


# 3. CATEGORICAL PALETTER I BARPLOT =======================================

cat("\n=== 3. CATEGORICAL PALETTER I BARPLOT ===\n")

# 4 kategorier
data_4 <- c(25, 35, 20, 20)
kategorier_4 <- c("Kategori A", "Kategori B", "Kategori C", "Kategori D")
farger_4 <- gbg_palette("categorical", "palette_4")

png("exempel_3_barplot_4.png", width = 800, height = 600, res = 120)
barplot(data_4, 
        names.arg = kategorier_4,
        col = farger_4,
        main = "Barplot med 4 kategorier",
        ylab = "Värde",
        ylim = c(0, 40))
dev.off()
cat("✓ Skapade exempel_3_barplot_4.png (4 kategorier)\n")

# 7 kategorier
data_7 <- c(15, 12, 18, 10, 15, 12, 18)
kategorier_7 <- paste("Kat", LETTERS[1:7])
farger_7 <- gbg_palette("categorical", "palette_7")

png("exempel_4_barplot_7.png", width = 800, height = 600, res = 120)
barplot(data_7, 
        names.arg = kategorier_7,
        col = farger_7,
        main = "Barplot med 7 kategorier (MAX)",
        ylab = "Värde",
        ylim = c(0, 20))
dev.off()
cat("✓ Skapade exempel_4_barplot_7.png (7 kategorier)\n")


# 4. SEQUENTIAL PALETTER ==================================================

cat("\n=== 4. SEQUENTIAL PALETTER ===\n")

# Heatmap med blå gradient
data_matrix <- matrix(rnorm(100), nrow = 10)

png("exempel_5_heatmap_blue.png", width = 800, height = 600, res = 120)
heatmap(data_matrix, 
        col = gbg_palette("sequential", "blue", n = 20),
        main = "Heatmap med blå gradient",
        scale = "none",
        Rowv = NA, Colv = NA)
dev.off()
cat("✓ Skapade exempel_5_heatmap_blue.png\n")

# Heatmap med gul-röd gradient (varning)
png("exempel_6_heatmap_warning.png", width = 800, height = 600, res = 120)
heatmap(abs(data_matrix), 
        col = gbg_palette("sequential", "yellow_red", n = 20),
        main = "Heatmap med varningsgradient",
        scale = "none",
        Rowv = NA, Colv = NA)
dev.off()
cat("✓ Skapade exempel_6_heatmap_warning.png\n")


# 5. PIE CHART MED CATEGORICAL ============================================

cat("\n=== 5. PIE CHART MED CATEGORICAL ===\n")

# Pie chart (använd sparsamt!)
data_pie <- c(30, 25, 20, 15, 10)
labels_pie <- c("Del A", "Del B", "Del C", "Del D", "Del E")
farger_pie <- gbg_palette("categorical", "palette_5")

png("exempel_7_piechart.png", width = 800, height = 600, res = 120)
pie(data_pie, 
    labels = labels_pie,
    col = farger_pie,
    main = "Pie Chart med 5 kategorier")
dev.off()
cat("✓ Skapade exempel_7_piechart.png\n")


# 6. TEXTFÄRG FÖR OPTIMAL KONTRAST ========================================

cat("\n=== 6. TEXTFÄRG FÖR OPTIMAL KONTRAST ===\n")

# Demonstrera choose_text_color()
test_farger <- c(
  gbg_colors("blue"),           # Mörk → vit text
  gbg_colors("light_yellow"),   # Ljus → svart text
  gbg_colors("dark_red"),       # Mörk → vit text
  gbg_colors("light_green")     # Ljus → svart text
)

test_labels <- c("Göteborgsblå", "Ljusgul", "Röd", "Ljusgrön")

png("exempel_8_text_contrast.png", width = 800, height = 400, res = 120)
par(mfrow = c(1, 4), mar = c(1, 1, 3, 1))

for (i in 1:length(test_farger)) {
  bg_color <- test_farger[i]
  text_color <- choose_text_color(bg_color)
  
  plot(0, 0, type = "n", xlim = c(0, 1), ylim = c(0, 1), 
       axes = FALSE, xlab = "", ylab = "",
       main = test_labels[i])
  rect(0, 0, 1, 1, col = bg_color, border = NA)
  text(0.5, 0.5, "Text", col = text_color, cex = 3, font = 2)
  text(0.5, 0.2, text_color, col = text_color, cex = 1.2)
}
dev.off()
cat("✓ Skapade exempel_8_text_contrast.png\n")


# 7. INTERPOLERA PALETTER =================================================

cat("\n=== 7. INTERPOLERA PALETTER ===\n")

# Skapa många nyanser från en palett
blue_7 <- gbg_palette("sequential", "blue", n = 7)
blue_20 <- gbg_palette("sequential", "blue", n = 20)

cat("\nBlå palette med 7 färger:\n")
print(blue_7)

cat("\nBlå palette med 20 färger:\n")
print(blue_20)

# Visualisera skillnaden
png("exempel_9_interpolation.png", width = 800, height = 400, res = 120)
par(mfrow = c(2, 1), mar = c(2, 2, 3, 2))

# 7 färger
barplot(rep(1, 7), col = blue_7, border = NA, 
        main = "Blå gradient - 7 färger", axes = FALSE)

# 20 färger
barplot(rep(1, 20), col = blue_20, border = NA, 
        main = "Blå gradient - 20 färger", axes = FALSE)
dev.off()
cat("✓ Skapade exempel_9_interpolation.png\n")


# 8. CUSTOM GRADIENT ======================================================

cat("\n=== 8. CUSTOM GRADIENT ===\n")

# Skapa egen gradient mellan valfria färger
custom_gradient <- gbg_palette_gradient(
  c(gbg_colors("light_cyan"), 
    gbg_colors("blue"), 
    gbg_colors("dark_blue")),
  n = 15
)

png("exempel_10_custom_gradient.png", width = 800, height = 400, res = 120)
barplot(rep(1, 15), col = custom_gradient, border = NA,
        main = "Custom gradient: Ljusblå → Göteborgsblå → Mörkblå",
        axes = FALSE)
dev.off()
cat("✓ Skapade exempel_10_custom_gradient.png\n")


# 9. VISUALISERA PALETTER (kräver ggplot2) ================================

cat("\n=== 9. VISUALISERA PALETTER (kräver ggplot2) ===\n")

if (requireNamespace("ggplot2", quietly = TRUE)) {
  library(ggplot2)
  
  # Sequential
  p1 <- show_palette(
    gbg_palette("sequential", "blue"),
    labels = c("Låg", "Medel", "Hög")
  )
  ggsave("exempel_11_palette_sequential.png", p1, 
         width = 8, height = 2, dpi = 150)
  cat("✓ Skapade exempel_11_palette_sequential.png\n")
  
  # Diverging
  p2 <- show_palette(
    gbg_palette("diverging", "red_green"),
    labels = c("Negativ", "-", "Neutral", "+", "Positiv")
  )
  ggsave("exempel_12_palette_diverging.png", p2, 
         width = 8, height = 2, dpi = 150)
  cat("✓ Skapade exempel_12_palette_diverging.png\n")
  
  # Categorical
  p3 <- show_palette(
    gbg_palette("categorical", "palette_7")
  )
  ggsave("exempel_13_palette_categorical.png", p3, 
         width = 8, height = 2, dpi = 150)
  cat("✓ Skapade exempel_13_palette_categorical.png\n")
  
} else {
  cat("⚠ ggplot2 ej tillgängligt - hoppar över visualiseringar\n")
}


# 10. JÄMFÖRA ALLA PALETTYPER =============================================

cat("\n=== 10. JÄMFÖRA ALLA PALETTYPER ===\n")

# Skapa jämförelse-plot
png("exempel_14_palette_comparison.png", width = 1000, height = 800, res = 120)
par(mfrow = c(4, 3), mar = c(2, 4, 2, 1))

# Sequential paletter
for (pal in c("blue", "green", "yellow_red")) {
  farger <- gbg_palette("sequential", pal, n = 7)
  barplot(rep(1, 7), col = farger, border = NA, 
          main = paste("Sequential:", pal), axes = FALSE, las = 1)
}

# Diverging paletter
for (pal in c("red_green", "blue_red", "purple_green")) {
  farger <- gbg_palette("diverging", pal)
  barplot(rep(1, length(farger)), col = farger, border = NA,
          main = paste("Diverging:", pal), axes = FALSE, las = 1)
}

# Categorical paletter (urval)
for (i in c(2, 4, 7)) {
  pal_name <- paste0("palette_", i)
  farger <- gbg_palette("categorical", pal_name)
  barplot(rep(1, length(farger)), col = farger, border = NA,
          main = paste("Categorical:", pal_name), axes = FALSE, las = 1)
}

dev.off()
cat("✓ Skapade exempel_14_palette_comparison.png\n")


# SAMMANFATTNING ==========================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("SAMMANFATTNING\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Skapade exempel:\n")
cat("  1. exempel_1_scatter.png           - Scatter plot\n")
cat("  2. exempel_2_lines.png             - Linjediagram\n")
cat("  3. exempel_3_barplot_4.png         - Barplot (4 kategorier)\n")
cat("  4. exempel_4_barplot_7.png         - Barplot (7 kategorier)\n")
cat("  5. exempel_5_heatmap_blue.png      - Heatmap (blå)\n")
cat("  6. exempel_6_heatmap_warning.png   - Heatmap (varning)\n")
cat("  7. exempel_7_piechart.png          - Pie chart\n")
cat("  8. exempel_8_text_contrast.png     - Textkontrast\n")
cat("  9. exempel_9_interpolation.png     - Interpolering\n")
cat(" 10. exempel_10_custom_gradient.png  - Custom gradient\n")
cat(" 11. exempel_11_palette_sequential.png  - Visualisering\n")
cat(" 12. exempel_12_palette_diverging.png   - Visualisering\n")
cat(" 13. exempel_13_palette_categorical.png - Visualisering\n")
cat(" 14. exempel_14_palette_comparison.png  - Jämförelse\n")
cat("\n")
cat("Nästa steg:\n")
cat("  - Se exempel_kartor.R för ggplot2 kartor\n")
cat("  - Se exempel_diagram.R för ggplot2 diagram\n")
cat("  - Se funktioner_katalog_colors.md för fullständig dokumentation\n")
cat("\n")
cat("═══════════════════════════════════════════════════════════════════════════\n")
