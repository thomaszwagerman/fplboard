#' bs_themes for light mode
light <- bslib::bs_theme(
  base_font = bslib::font_collection(
    bslib::font_google("Fira Sans"),
    "Arial",
    "Helvetica Neue",
    "Helvetica, sans-serif"),
  heading_font = bslib::font_google("Fira Sans"),
  fg = "#76766f",
  bg = "white",
  primary = "#37003c",
  secondary = "#00ff85"
) |>
  # Bit of a workaround, manually setting
  # the navbar header colour, and then all body text to be black
  bslib::bs_add_rules(
    ".navbar.navbar-default {
    background-color: #37003c !important;}

    .dropdown-menu {
    background-color: #37003c;
    color: #76766f;
    }

    .dropdown-item, .dropdown-menu>li>a {
    color: #76766f;
    }

    * {
    color: black;
    }

    .form-control {
    color: black;
    border: 1px solid black;
    }
    "
  )

#' bs_themes for dark mode
dark <- bslib::bs_theme(
  base_font = bslib::font_google("Fira Sans"),
  heading_font = bslib::font_google("Fira Sans"),
  bg = "#37003c",
  fg = "white",
  primary = "#04f5ff",
  seconday = "#e90052"
)
