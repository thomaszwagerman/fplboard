#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  observe(session$setCurrentTheme(
    if (isTRUE(input$light_mode)) light else dark
  ))

  # Creating a reactive with the light/dark theme.
  # This is to pass the theme to gt tables
  # Which do not get automatically updated by {thematic}
  current_theme <- reactive({
    if (isTRUE(input$light_mode)) {
      "light"
    } else {
      "dark"
    }
  })

  mod_ep_table_server("ep_table_1")
  mod_ep_team_server("ep_team_1")
  mod_plot_league_server("plot_league_1")
  mod_minileague_stats_server("minileague_stats_1", current_theme)

}
