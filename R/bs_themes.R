#' bs_themes for light mode
light <- bslib::bs_theme(
  base_font = bslib::font_collection(
    bslib::font_google("Fira Sans"),
    "Arial",
    "Helvetica Neue",
    "Helvetica, sans-serif"),
  heading_font = bslib::font_google("Fira Sans"),
  primary = "#37003c",
  secondary = "#00ff85"
) |>
  bs_add_rules(
    ".navbar-default {
    background-color: #37003c !important;}"
    )


# light <- bslib::bs_add_rules(light, ".navbar-default {background-color: #37003c !important;}")


#' bs_themes for dark mode
dark <- bslib::bs_theme(
  base_font = bslib::font_google("Fira Sans"),
  heading_font = bslib::font_google("Fira Sans"),
  bg = "#37003c",
  fg = "white",
  primary = "#e90052",
  seconday = "#04f5ff"
)
