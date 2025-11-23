# Tester för ggplot_scales_gothenburg.R
# Kör med: testthat::test_file("tests/testthat/test-scales.R")

library(testthat)

# Ladda färgsystemet och ggplot2
if (!exists("GOTEBORG_BLUE")) {
  source("colors_gothenburg.R")
}
if (!exists("scale_fill_gbg_sequential")) {
  source("ggplot_scales_gothenburg.R")
}

skip_if_not_installed("ggplot2")
library(ggplot2)

# ==========================================================================
# TEST: scale_fill_gbg_sequential()
# ==========================================================================

test_that("scale_fill_gbg_sequential() skapar scale-objekt", {
  scale <- scale_fill_gbg_sequential("blue")
  expect_s3_class(scale, "ScaleContinuous")
})

test_that("scale_fill_gbg_sequential() accepterar alla paletter", {
  palettes <- c("blue", "green", "yellow_red", "dark_blue", "cyan", 
                "yellow", "red", "pink", "purple", "yellow_green", "yellow_green_dark")
  
  for (pal in palettes) {
    scale <- scale_fill_gbg_sequential(pal)
    expect_s3_class(scale, "Scale")
  }
})

test_that("scale_fill_gbg_sequential() med discrete = TRUE skapar diskret skala", {
  scale <- scale_fill_gbg_sequential("blue", n = 5, discrete = TRUE)
  expect_s3_class(scale, "ScaleDiscrete")
})

test_that("scale_fill_gbg_sequential() med discrete = FALSE skapar kontinuerlig skala", {
  scale <- scale_fill_gbg_sequential("blue", discrete = FALSE)
  expect_s3_class(scale, "ScaleContinuous")
})

test_that("scale_fill_gbg_sequential() ger error för ogiltig palett", {
  expect_error(
    scale_fill_gbg_sequential("ogiltig_palett"),
    "Ogiltig sequential palett"
  )
})

test_that("scale_fill_gbg_sequential() ger error för ogiltig direction", {
  expect_error(
    scale_fill_gbg_sequential("blue", direction = 0),
    "måste vara 1"
  )
})

test_that("scale_fill_gbg_sequential() ger error för ogiltigt n", {
  expect_error(
    scale_fill_gbg_sequential("blue", n = 1),
    "måste vara ett heltal >= 2"
  )
  expect_error(
    scale_fill_gbg_sequential("blue", n = "fem"),
    "måste vara ett heltal >= 2"
  )
})

# ==========================================================================
# TEST: scale_color_gbg_sequential()
# ==========================================================================

test_that("scale_color_gbg_sequential() skapar scale-objekt", {
  scale <- scale_color_gbg_sequential("blue")
  expect_s3_class(scale, "ScaleContinuous")
})

test_that("scale_color_gbg_sequential() accepterar alla paletter", {
  palettes <- c("blue", "green", "yellow_red")
  
  for (pal in palettes) {
    scale <- scale_color_gbg_sequential(pal)
    expect_s3_class(scale, "Scale")
  }
})

test_that("scale_color_gbg_sequential() ger error för ogiltig palett", {
  expect_error(
    scale_color_gbg_sequential("ogiltig"),
    "Ogiltig sequential palett"
  )
})

# ==========================================================================
# TEST: scale_fill_gbg_diverging()
# ==========================================================================

test_that("scale_fill_gbg_diverging() skapar scale-objekt", {
  scale <- scale_fill_gbg_diverging("red_green")
  expect_s3_class(scale, "ScaleContinuous")
})

test_that("scale_fill_gbg_diverging() accepterar alla paletter", {
  palettes <- c("red_green", "blue_red", "purple_green")
  
  for (pal in palettes) {
    scale <- scale_fill_gbg_diverging(pal)
    expect_s3_class(scale, "Scale")
  }
})

test_that("scale_fill_gbg_diverging() med discrete = TRUE skapar diskret skala", {
  scale <- scale_fill_gbg_diverging("red_green", n = 7, discrete = TRUE)
  expect_s3_class(scale, "ScaleDiscrete")
})

test_that("scale_fill_gbg_diverging() ger error för ogiltig palett", {
  expect_error(
    scale_fill_gbg_diverging("ogiltig"),
    "Ogiltig diverging palett"
  )
})

# ==========================================================================
# TEST: scale_color_gbg_diverging()
# ==========================================================================

test_that("scale_color_gbg_diverging() skapar scale-objekt", {
  scale <- scale_color_gbg_diverging("red_green")
  expect_s3_class(scale, "ScaleContinuous")
})

test_that("scale_color_gbg_diverging() accepterar alla paletter", {
  palettes <- c("red_green", "blue_red", "purple_green")
  
  for (pal in palettes) {
    scale <- scale_color_gbg_diverging(pal)
    expect_s3_class(scale, "Scale")
  }
})

# ==========================================================================
# TEST: scale_fill_gbg_categorical()
# ==========================================================================

test_that("scale_fill_gbg_categorical() skapar scale-objekt", {
  scale <- scale_fill_gbg_categorical("palette_4")
  expect_s3_class(scale, "ScaleDiscrete")
})

test_that("scale_fill_gbg_categorical() accepterar alla paletter", {
  palettes <- paste0("palette_", 1:7)
  
  for (pal in palettes) {
    scale <- scale_fill_gbg_categorical(pal)
    expect_s3_class(scale, "Scale")
  }
})

test_that("scale_fill_gbg_categorical() ger error för ogiltig palett", {
  expect_error(
    scale_fill_gbg_categorical("palette_8"),
    "Ogiltig categorical palett"
  )
  expect_error(
    scale_fill_gbg_categorical("ogiltig"),
    "Ogiltig categorical palett"
  )
})

test_that("scale_fill_gbg_categorical() ger error för ogiltig direction", {
  expect_error(
    scale_fill_gbg_categorical("palette_4", direction = 2),
    "måste vara 1"
  )
})

# ==========================================================================
# TEST: scale_color_gbg_categorical()
# ==========================================================================

test_that("scale_color_gbg_categorical() skapar scale-objekt", {
  scale <- scale_color_gbg_categorical("palette_4")
  expect_s3_class(scale, "ScaleDiscrete")
})

test_that("scale_color_gbg_categorical() accepterar alla paletter", {
  palettes <- paste0("palette_", 1:7)
  
  for (pal in palettes) {
    scale <- scale_color_gbg_categorical(pal)
    expect_s3_class(scale, "Scale")
  }
})

# ==========================================================================
# INTEGRATIONSTESTER
# ==========================================================================

test_that("Sequential scale fungerar i enkel ggplot", {
  # Skapa minimal testdata
  df <- data.frame(
    x = 1:10,
    y = 1:10,
    value = 1:10
  )
  
  # Skapa plot med scale
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gbg_sequential("blue")
  
  # Testa att plot kan byggas utan error
  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

test_that("Diverging scale fungerar i enkel ggplot", {
  df <- data.frame(
    x = 1:10,
    y = 1:10,
    value = -5:4
  )
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gbg_diverging("red_green")
  
  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

test_that("Categorical scale fungerar i enkel ggplot", {
  df <- data.frame(
    x = 1:4,
    y = 1:4,
    category = factor(c("A", "B", "C", "D"))
  )
  
  p <- ggplot(df, aes(x = x, y = y, fill = category)) +
    geom_tile() +
    scale_fill_gbg_categorical("palette_4")
  
  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

test_that("direction = -1 fungerar", {
  df <- data.frame(x = 1:10, y = 1:10, value = 1:10)
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gbg_sequential("blue", direction = -1)
  
  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

test_that("Custom breaks och labels fungerar", {
  df <- data.frame(x = 1:10, y = 1:10, value = 1:10)
  
  p <- ggplot(df, aes(x = x, y = y, fill = value)) +
    geom_tile() +
    scale_fill_gbg_sequential(
      "blue",
      breaks = c(2, 5, 8),
      labels = c("Låg", "Medel", "Hög"),
      name = "Värde"
    )
  
  expect_s3_class(p, "ggplot")
  expect_silent(ggplot_build(p))
})

# ==========================================================================
# SAMMANFATTNING
# ==========================================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("  TESTSAMMANFATTNING - ggplot_scales_gothenburg.R\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Alla tester för ggplot_scales_gothenburg.R har körts.\n")
cat("Se resultat ovan för detaljer.\n")
cat("\n")
cat("Testade funktioner:\n")
cat("  ✓ scale_fill_gbg_sequential()\n")
cat("  ✓ scale_color_gbg_sequential()\n")
cat("  ✓ scale_fill_gbg_diverging()\n")
cat("  ✓ scale_color_gbg_diverging()\n")
cat("  ✓ scale_fill_gbg_categorical()\n")
cat("  ✓ scale_color_gbg_categorical()\n")
cat("\n")
cat("Integrationstester:\n")
cat("  ✓ Sequential i ggplot\n")
cat("  ✓ Diverging i ggplot\n")
cat("  ✓ Categorical i ggplot\n")
cat("  ✓ direction = -1\n")
cat("  ✓ Custom breaks/labels\n")
cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")