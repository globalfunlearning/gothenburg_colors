# Göteborgs Stads Färgsystem
# Core färgdefinitioner och paletter
# Version: 1.0
# Skapad: 2025-10-31
#
# Detta skript innehåller färgdefinitioner och paletter enligt Göteborgs Stads
# grafiska profil. Det kan användas fristående utan ggplot2-beroenden.
#
# För ggplot2 integration, se: ggplot_scales_gothenburg.R


# 1. FÄRGDEFINITIONER ====================================================

#' Huvudfärg - Göteborgsblå
#' 
#' Används för profilerande element 
GOTEBORG_BLUE <- list(
  name = "Göteborgsblå",
  hex = "#0076bc",
  rgb = c(0, 119, 188),
  cmyk = c(96, 37, 0, 5),
  text_color = "white"
)

#' Komplementfärger - Mörka
#' 
#' Använd för datavärden, diagram och kartor
DARK_COLORS <- list(
  dark_blue = list(
    name = "Mörkblå",
    hex = "#3f5564",
    text_color = "white"
  ),
  dark_green = list(
    name = "Grön",
    hex = "#008767",
    text_color = "white"
  ),
  dark_cyan = list(
    name = "Turkos",
    hex = "#008391",
    text_color = "white"
  ),
  dark_yellow = list(
    name = "Gul",
    hex = "#ffcd37",
    text_color = "black"
  ),
  dark_red = list(
    name = "Röd",
    hex = "#d24723",
    text_color = "white"
  ),
  dark_pink = list(
    name = "Rosa",
    hex = "#d53878",
    text_color = "white"
  ),
  dark_purple = list(
    name = "Lila",
    hex = "#674a99",
    text_color = "white"
  )
)

#' Komplementfärger - Ljusa
#' 
#' Använd för bakgrunder, ljusa värden, highlights
LIGHT_COLORS <- list(
  light_gray = list(
    name = "Grå",
    hex = "#d1d9dc",
    text_color = "black"
  ),
  light_green = list(
    name = "Ljusgrön",
    hex = "#b7e1c8",
    text_color = "black"
  ),
  light_cyan = list(
    name = "Ljusblå",
    hex = "#bfe4f2",
    text_color = "black"
  ),
  light_yellow = list(
    name = "Ljusgul",
    hex = "#fff2b0",
    text_color = "black"
  ),
  light_orange = list(
    name = "Aprikos",
    hex = "#faceb9",
    text_color = "black"
  ),
  light_pink = list(
    name = "Ljusrosa",
    hex = "#f8ccdc",
    text_color = "black"
  ),
  light_purple = list(
    name = "Violett",
    hex = "#e0d0e7",
    text_color = "black"
  )
)

# 2. PALETTER ===========================================================

#' Sequential paletter (låg → hög)
#' 
#' Använd för numeriska värden som går från låg till hög
SEQUENTIAL_PALETTES <- list(
  # ============================================
  # SINGLE HUE (ljus → mörk, en färgfamilj)
  # ============================================
  
  # Blå gradient (standard) 
  blue = c("#bfe4f2", "#0076bc", "#3f5564"),
  
  # Grön gradient 
  green = c("#b7e1c8", "#008767", "#3f5564"),
  
  # Gul-Röd (varning) 
  yellow_red = c("#fff2b0", "#ffcd37", "#d24723"),
  
  # SINGLE HUE - Baserade på DARK_COLORS
  
  # Mörkblå (#3f5564)
  dark_blue = c("#d1d9dc", "#8ca3af", "#3f5564"),
  
  # Turkos (#008391)
  cyan = c("#bfe4f2", "#5fc3cd", "#008391"),
  
  # Gul (#ffcd37)
  yellow = c("#fff2b0", "#ffe073", "#ffcd37"),
  
  # Röd (#d24723)
  red = c("#faceb9", "#e6886e", "#d24723"),
  
  # Rosa (#d53878)
  pink = c("#f8ccdc", "#e882aa", "#d53878"),
  
  # Lila (#674a99)
  purple = c("#e0d0e7", "#a38dc0", "#674a99"),

  # ============================================
  # MULTI HUE (flera färger i gradient)
  # ============================================
  
  # Gul → Grön (7 steg)
  yellow_green = c("#ffffcc", "#d9f0a3", "#addd8e", "#78c679", "#41ab5d", "#238b45", "#005824"),
  
  # Gul → Grön → Mörkgrön (7 steg)
  yellow_green_dark = c("#ffffcc", "#d9f0a3", "#addd8e", "#78c679", "#41ab5d", "#238443", "#005a32")
)

#' Diverging paletter (negativ → neutral → positiv)
#' 
#' Använd för avvikelser från centralvärde, plus/minus värden
DIVERGING_PALETTES <- list(
  # Röd-Vit-Grön (negativ-neutral-positiv) 
  red_green = c("#d24723", "#faceb9", "#ffffff", "#b7e1c8", "#008767"),
  
  # Blå-Vit-Röd (kallt-neutral-varmt) 
  blue_red = c("#0076bc", "#bfe4f2", "#ffffff", "#faceb9", "#d24723"),
  
  # Lila-Vit-Grön (7 steg) 
  purple_green = c("#762a83", "#af8dc3", "#e7d4e8", "#f7f7f7", "#d9f0d3", "#7fbf7b", "#1b7837")
)

#' Categorical paletter (kategorier utan ordning)
#' 
#' Använd för kategoriska variabler, max 7 kategorier rekommenderas
#' Inspiration: Urban Institute färglogik
CATEGORICAL_PALETTES <- list(
  # 1 färg - Göteborgsblå (primär)
  palette_1 = c("#0076bc"),
  
  # 2 färger - Blå + Svart (kontrast)
  palette_2 = c("#0076bc", "#000000"),
  
  # 3 färger - Blå + Svart + Grön
  palette_3 = c("#0076bc", "#000000", "#008767"),
  
  # 4 färger - Blå + Svart + Gul + Grön
  palette_4 = c("#0076bc", "#000000", "#ffcd37", "#008767"),
  
  # 5 färger - Lägg till Rosa (accent)
  palette_5 = c("#0076bc", "#000000", "#ffcd37", "#008767", "#d53878"),
  
  # 6 färger - Lägg till Mörkblå (variant)
  palette_6 = c("#0076bc", "#000000", "#3f5564", "#ffcd37", "#008767", "#d53878"),
  
  # 7 färger - Lägg till Grå (neutral)
  palette_7 = c("#0076bc", "#000000", "#d1d9dc", "#ffcd37", "#008767", "#d53878", "#3f5564")
)

# 3. ANVÄNDAR-API =======================================================

#' Hämta Göteborgs Stads färger
#'
#' @param color Namn på färg (NULL returnerar alla)
#' @return Hex-färgkod eller lista med alla färger
#' @examples
#' gbg_colors()                # Alla färger
#' gbg_colors("blue")          # Göteborgsblå
#' gbg_colors("dark_green")    # Grön
#' @export
gbg_colors <- function(color = NULL) {
  
  # Samla alla färger i en lista
  all_colors <- list(
    blue = GOTEBORG_BLUE$hex,
    dark_blue = DARK_COLORS$dark_blue$hex,
    dark_green = DARK_COLORS$dark_green$hex,
    dark_cyan = DARK_COLORS$dark_cyan$hex,
    dark_yellow = DARK_COLORS$dark_yellow$hex,
    dark_red = DARK_COLORS$dark_red$hex,
    dark_pink = DARK_COLORS$dark_pink$hex,
    dark_purple = DARK_COLORS$dark_purple$hex,
    light_gray = LIGHT_COLORS$light_gray$hex,
    light_green = LIGHT_COLORS$light_green$hex,
    light_cyan = LIGHT_COLORS$light_cyan$hex,
    light_yellow = LIGHT_COLORS$light_yellow$hex,
    light_orange = LIGHT_COLORS$light_orange$hex,
    light_pink = LIGHT_COLORS$light_pink$hex,
    light_purple = LIGHT_COLORS$light_purple$hex,
    white = "#ffffff",
    black = "#000000"
  )
  
  # Om ingen färg specifik → returnera alla
  if (is.null(color)) {
    return(all_colors)
  }
  
  # Om specifik färg efterfrågad
  if (color %in% names(all_colors)) {
    return(all_colors[[color]])
  } else {
    stop(
      "Färgen '", color, "' finns inte. ",
      "Tillgängliga färger: ", paste(names(all_colors), collapse = ", ")
    )
  }
}

#' Hämta färgpalett
#'
#' @param type Typ av palett: "sequential", "diverging", "categorical"
#' @param palette Namn på specifik palett (NULL ger första/standard)
#' @param n Antal färger att interpolera till (NULL ger alla)
#' @param direction 1 = normal ordning, -1 = omvänd ordning
#' @return Vektor med hex-färger
#' @examples
#' gbg_palette("sequential")                    # Standard blå gradient
#' gbg_palette("sequential", "green")           # Grön gradient
#' gbg_palette("sequential", "blue", n = 7)     # 7 blå nyanser
#' gbg_palette("diverging", "red_green")        # Röd-Vit-Grön
#' gbg_palette("categorical", "palette_4")      # 4 kategorifärger
#' @export
gbg_palette <- function(type = "sequential", 
                        palette = NULL, 
                        n = NULL,
                        direction = 1) {
  
  # Validera type
  valid_types <- c("sequential", "diverging", "categorical")
  if (!type %in% valid_types) {
    stop(
      "Typ '", type, "' finns inte. ",
      "Giltiga typer: ", paste(valid_types, collapse = ", ")
    )
  }
  
  # Välj palett-lista baserat på typ
  palette_list <- switch(
    type,
    sequential = SEQUENTIAL_PALETTES,
    diverging = DIVERGING_PALETTES,
    categorical = CATEGORICAL_PALETTES
  )
  
  # Om ingen specifik palett → välj första
  if (is.null(palette)) {
    colors <- palette_list[[1]]
  } else {
    if (palette %in% names(palette_list)) {
      colors <- palette_list[[palette]]
    } else {
      stop(
        "Paletten '", palette, "' finns inte i typ '", type, "'. ",
        "Tillgängliga: ", paste(names(palette_list), collapse = ", ")
      )
    }
  }
  
  # Interpolera till önskat antal färger om n angivet
  if (!is.null(n)) {
    if (n < 2) {
      stop("Antal färger (n) måste vara minst 2")
    }
    colors <- colorRampPalette(colors)(n)
  }
  
  # Vänd ordning om direction = -1
  if (direction == -1) {
    colors <- rev(colors)
  }
  
  return(colors)
}

# 4. HJÄLPFUNKTIONER ====================================================

#' Välj textfärg baserat på bakgrundsfärg
#'
#' Returnerar svart eller vit text beroende på bakgrundens ljushet
#' för att säkerställa tillräcklig kontrast (WCAG AA standard)
#'
#' @param background_color Hex-färg för bakgrund
#' @return "#000000" (svart) eller "#ffffff" (vit)
#' @examples
#' choose_text_color("#0076bc")  # → "white"
#' choose_text_color("#fff2b0")  # → "black"
#' @export
choose_text_color <- function(background_color) {
  
  # Ta bort # om den finns
  hex <- gsub("#", "", background_color)
  
  # Konvertera hex till RGB
  r <- strtoi(substr(hex, 1, 2), 16L)
  g <- strtoi(substr(hex, 3, 4), 16L)
  b <- strtoi(substr(hex, 5, 6), 16L)
  
  # Beräkna luminans (relativ ljushet)
  # Använder W3C-formeln för perceived brightness
  luminance <- (0.299 * r + 0.587 * g + 0.114 * b) / 255
  
  # Om ljus bakgrund → svart text, om mörk → vit text
  if (luminance > 0.5) {
    return("#000000")
  } else {
    return("#ffffff")
  }
}

#' Visualisera färgpalett
#'
#' Skapar en enkel visualisering av en färgpalett
#' Kräver ggplot2 för att fungera
#'
#' @param colors Vektor med hex-färger
#' @param labels Etiketter för varje färg (valfritt)
#' @return Ett ggplot2-objekt
#' @examples
#' show_palette(gbg_palette("sequential"))
#' show_palette(gbg_palette("categorical", "palette_4"))
#' @export
show_palette <- function(colors, labels = NULL) {
  
  # Kräver ggplot2
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Paketet 'ggplot2' krävs för show_palette()")
  }
  
  n <- length(colors)
  
  # Skapa data för visualisering
  df <- data.frame(
    x = 1:n,
    y = 1,
    color = colors
  )
  
  # Om inga labels → använd färgkoder
  if (is.null(labels)) {
    labels <- colors
  }
  
  # Skapa plot
  p <- ggplot2::ggplot(df, ggplot2::aes(x = x, y = y, fill = color)) +
    ggplot2::geom_tile(color = "white", linewidth = 2) +
    ggplot2::scale_fill_identity() +
    ggplot2::geom_text(
      ggplot2::aes(label = labels),
      color = sapply(colors, choose_text_color),
      size = 4
    ) +
    ggplot2::theme_void() +
    ggplot2::theme(
      plot.margin = ggplot2::margin(10, 10, 10, 10)
    )
  
  return(p)
}

#' Skapa gradient mellan färger
#'
#' @param colors Vektor med 2+ hex-färger
#' @param n Antal färger i gradienten
#' @return Vektor med n hex-färger
#' @examples
#' gbg_palette_gradient(c("#bfe4f2", "#0076bc"), n = 10)
#' @export
gbg_palette_gradient <- function(colors, n = 10) {
  
  if (length(colors) < 2) {
    stop("Minst 2 färger krävs för att skapa gradient")
  }
  
  if (n < 2) {
    stop("Antal färger (n) måste vara minst 2")
  }
  
  return(colorRampPalette(colors)(n))
}
