#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {

  observe(session$setCurrentTheme(
    if (isTRUE(input$dark_mode)) dark else light
  ))

  mod_ep_table_server("ep_table_1")
  mod_ep_team_server("ep_team_1")
  mod_plot_league_server("plot_league_1")

}
