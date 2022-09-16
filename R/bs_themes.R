#' bs_themes for light mode
light <- bslib::bs_theme(
  base_font = bslib::font_google("Fira Sans"),
  heading_font = bslib::font_google("Fira Sans")
)

#' bs_themes for dark mode
dark <- bslib::bs_theme(
  base_font = bslib::font_google("Fira Sans"),
  heading_font = bslib::font_google("Fira Sans"),
  bg = "black",
  fg = "white",
  primary = "purple"
)
