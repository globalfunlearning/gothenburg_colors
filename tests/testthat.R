# Huvudfil för testning av Gothenburg Colors
# Kör alla tester med: source("tests/testthat.R")
#
# Detta skript:
# 1. Kontrollerar att testthat är installerat
# 2. Laddar färgsystemet
# 3. Kör alla tester i tests/testthat/
#
# Senast uppdaterad: 2025-11-23

# =============================================================================
# KONTROLLERA TESTTHAT
# =============================================================================

if (!requireNamespace("testthat", quietly = TRUE)) {
  stop(
    "Paketet 'testthat' krävs för att köra tester.\n",
    "Installera med: install.packages('testthat')"
  )
}

library(testthat)

# =============================================================================
# LADDA FÄRGSYSTEMET
# =============================================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("  GOTHENBURG COLORS - TESTSUITE\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")

cat("Laddar färgsystem...\n")

# Ladda colors_gothenburg.R
if (file.exists("colors_gothenburg.R")) {
  source("colors_gothenburg.R")
  cat("✓ colors_gothenburg.R laddat\n")
} else {
  stop("Kan inte hitta colors_gothenburg.R. Kör detta skript från projektets rot.")
}

# Ladda ggplot_scales_gothenburg.R
if (file.exists("ggplot_scales_gothenburg.R")) {
  source("ggplot_scales_gothenburg.R")
  cat("✓ ggplot_scales_gothenburg.R laddat\n")
} else {
  warning("ggplot_scales_gothenburg.R hittades inte. Scale-tester kommer skippas.")
}

cat("\n")

# =============================================================================
# KÖR TESTER
# =============================================================================

cat("Kör tester...\n\n")

# Kör alla tester i tests/testthat/
test_results <- test_dir(
  "tests/testthat",
  reporter = "progress"  # Visar progress bar
)

# =============================================================================
# SAMMANFATTNING
# =============================================================================

cat("\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("  TESTSAMMANFATTNING\n")
cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")

# Sammanfatta resultat
if (all(test_results$failed == 0)) {
  cat("✅ ALLA TESTER GODKÄNDA!\n\n")
  cat("Testade filer:\n")
  cat("  • tests/testthat/test-colors.R\n")
  cat("  • tests/testthat/test-scales.R\n")
  cat("\n")
} else {
  cat("❌ NÅGRA TESTER MISSLYCKADES\n\n")
  cat("Se detaljer ovan.\n\n")
}

cat("═══════════════════════════════════════════════════════════════\n")
cat("\n")

# Returnera resultat (osynligt)
invisible(test_results)