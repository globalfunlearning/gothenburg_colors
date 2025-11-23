# Tester för colors_gothenburg.R
# Kör med: testthat::test_file("tests/testthat/test-colors.R")

library(testthat)

# Ladda färgsystemet (om inte redan laddat)
if (!exists("GOTEBORG_BLUE")) {
  source("colors_gothenburg.R")
}

# ==========================================================================
# TEST: gbg_colors()
# ==========================================================================

test_that("gbg_colors() returnerar korrekt färg för blue", {
  expect_equal(gbg_colors("blue"), "#0076bc")
})

test_that("gbg_colors() returnerar korrekt färg för dark_green", {
  expect_equal(gbg_colors("dark_green"), "#008767")
})

test_that("gbg_colors() returnerar alla färger när color = NULL", {
  all_colors <- gbg_colors()
  expect_type(all_colors, "list")
  expect_equal(length(all_colors), 17)
  expect_true("blue" %in% names(all_colors))
  expect_true("white" %in% names(all_colors))
})

test_that("gbg_colors() ger error för ogiltig färg", {
  expect_error(gbg_colors("felaktig_färg"), "finns inte")
})

test_that("gbg_colors() ger error för ogiltig input-typ", {
  expect_error(gbg_colors(123), "måste vara en character string")
  expect_error(gbg_colors(c("blue", "red")), "måste vara en character string")
})

# ==========================================================================
# TEST: gbg_palette()
# ==========================================================================

test_that("gbg_palette() returnerar sequential palette", {
  pal <- gbg_palette("sequential", "blue")
  expect_type(pal, "character")
  expect_equal(length(pal), 3)
  expect_equal(pal[2], "#0076bc")
})

test_that("gbg_palette() interpolerar till n färger", {
  pal <- gbg_palette("sequential", "blue", n = 7)
  expect_equal(length(pal), 7)
})

test_that("gbg_palette() vänder ordning med direction = -1", {
  pal_normal <- gbg_palette("sequential", "blue")
  pal_reverse <- gbg_palette("sequential", "blue", direction = -1)
  expect_equal(pal_normal, rev(pal_reverse))
})

test_that("gbg_palette() ger error för ogiltig typ", {
  expect_error(gbg_palette("ogiltig_typ"), "måste vara en av")
})

test_that("gbg_palette() ger error för ogiltig palett", {
  expect_error(gbg_palette("sequential", "finns_inte"), "finns inte")
})

test_that("gbg_palette() ger error för ogiltigt n", {
  expect_error(gbg_palette("sequential", "blue", n = 1), "måste vara ett heltal >= 2")
  expect_error(gbg_palette("sequential", "blue", n = -5), "måste vara ett heltal >= 2")
  expect_error(gbg_palette("sequential", "blue", n = "fem"), "måste vara ett heltal >= 2")
})

test_that("gbg_palette() ger error för ogiltig direction", {
  expect_error(gbg_palette("sequential", "blue", direction = 0), "måste vara 1")
  expect_error(gbg_palette("sequential", "blue", direction = 2), "måste vara 1")
})

test_that("gbg_palette() fungerar för diverging paletter", {
  pal <- gbg_palette("diverging", "red_green")
  expect_type(pal, "character")
  expect_equal(length(pal), 5)
})

test_that("gbg_palette() fungerar för categorical paletter", {
  pal <- gbg_palette("categorical", "palette_4")
  expect_type(pal, "character")
  expect_equal(length(pal), 4)
})

# ==========================================================================
# TEST: choose_text_color()
# ==========================================================================

test_that("choose_text_color() returnerar vit för mörka färger", {
  expect_equal(choose_text_color("#0076bc"), "#ffffff")
  expect_equal(choose_text_color("#000000"), "#ffffff")
  expect_equal(choose_text_color("#008767"), "#ffffff")
})

test_that("choose_text_color() returnerar svart för ljusa färger", {
  expect_equal(choose_text_color("#ffffff"), "#000000")
  expect_equal(choose_text_color("#fff2b0"), "#000000")
  expect_equal(choose_text_color("#bfe4f2"), "#000000")
})

test_that("choose_text_color() fungerar utan # prefix", {
  expect_equal(choose_text_color("0076bc"), "#ffffff")
  expect_equal(choose_text_color("ffffff"), "#000000")
})

test_that("choose_text_color() ger error för ogiltig hex-färg", {
  expect_error(choose_text_color("blue"), "måste vara en giltig hex-färg")
  expect_error(choose_text_color("#gggggg"), "måste vara en giltig hex-färg")
  expect_error(choose_text_color("#00"), "måste vara en giltig hex-färg")
})

test_that("choose_text_color() ger error för ogiltig input", {
  expect_error(choose_text_color(123), "måste vara en character string")
  expect_error(choose_text_color(c("#0076bc", "#ffffff")), "måste vara en character string")
})

# ==========================================================================
# TEST: check_color_contrast()
# ==========================================================================

test_that("check_color_contrast() beräknar korrekt kontrast", {
  result <- check_color_contrast("#000000", "#ffffff")
  expect_type(result, "list")
  expect_true(result$ratio >= 20)  # Svart-vit har högst kontrast
  expect_true(result$wcag_aa_normal)
  expect_true(result$wcag_aaa_normal)
})

test_that("check_color_contrast() identifierar dålig kontrast", {
  result <- check_color_contrast("#0076bc", "#008767")
  expect_false(result$wcag_aa_normal)
})

test_that("check_color_contrast() fungerar med Göteborgs färger", {
  result <- check_color_contrast(gbg_colors("blue"), gbg_colors("white"))
  expect_true(result$wcag_aa_normal)
})

test_that("check_color_contrast() ger error för ogiltiga färger", {
  expect_error(check_color_contrast("blue", "#ffffff"), "Ogiltig hex-färg")
  expect_error(check_color_contrast("#0076bc", 123), "måste vara en character string")
})

test_that("check_color_contrast() har korrekt klass", {
  result <- check_color_contrast("#000000", "#ffffff")
  expect_s3_class(result, "gbg_contrast")
})

# ==========================================================================
# TEST: show_palette()
# ==========================================================================

test_that("show_palette() skapar ggplot-objekt", {
  skip_if_not_installed("ggplot2")
  
  colors <- gbg_palette("categorical", "palette_4")
  p <- show_palette(colors)
  expect_s3_class(p, "gg")
  expect_s3_class(p, "ggplot")
})

test_that("show_palette() fungerar med custom labels", {
  skip_if_not_installed("ggplot2")
  
  colors <- gbg_palette("categorical", "palette_3")
  labels <- c("Kategori A", "Kategori B", "Kategori C")
  p <- show_palette(colors, labels = labels)
  expect_s3_class(p, "ggplot")
})

test_that("show_palette() ger error för ogiltig input", {
  expect_error(show_palette(123), "måste vara en character vektor")
  expect_error(show_palette(character(0)), "måste vara en character vektor")
})

test_that("show_palette() ger error för labels med fel längd", {
  skip_if_not_installed("ggplot2")
  
  colors <- gbg_palette("categorical", "palette_4")
  labels <- c("A", "B")  # För få labels
  expect_error(show_palette(colors, labels = labels), "samma längd")
})

# ==========================================================================
# TEST: gbg_palette_gradient()
# ==========================================================================

test_that("gbg_palette_gradient() skapar gradient", {
  gradient <- gbg_palette_gradient(c("#bfe4f2", "#0076bc"), n = 10)
  expect_equal(length(gradient), 10)
  expect_type(gradient, "character")
})

test_that("gbg_palette_gradient() startar och slutar med givna färger", {
  colors <- c("#bfe4f2", "#0076bc")
  gradient <- gbg_palette_gradient(colors, n = 5)
  # Jämför case-insensitive (colorRampPalette kan returnera versaler)
  expect_equal(tolower(gradient[1]), tolower(colors[1]))
  expect_equal(tolower(gradient[5]), tolower(colors[2]))
})

test_that("gbg_palette_gradient() ger error för för få färger", {
  expect_error(
    gbg_palette_gradient("#0076bc", n = 10),
    "måste vara en character vektor med minst 2 färger"
  )
})

test_that("gbg_palette_gradient() ger error för ogiltigt n", {
  expect_error(
    gbg_palette_gradient(c("#bfe4f2", "#0076bc"), n = 1),
    "måste vara ett heltal >= 2"
  )
})

# ==========================================================================
# SAMMANFATTNING
# ==========================================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("  TESTSAMMANFATTNING - colors_gothenburg.R\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")
cat("Alla tester för colors_gothenburg.R har körts.\n")
cat("Se resultat ovan för detaljer.\n")
cat("\n")
cat("Testade funktioner:\n")
cat("  ✓ gbg_colors()\n")
cat("  ✓ gbg_palette()\n")
cat("  ✓ choose_text_color()\n")
cat("  ✓ check_color_contrast()\n")
cat("  ✓ show_palette()\n")
cat("  ✓ gbg_palette_gradient()\n")
cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")