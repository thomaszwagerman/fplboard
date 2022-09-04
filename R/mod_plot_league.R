#' plot_league UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_league_ui <- function(id){
  ns <- NS(id)
  tagList(

    tagList(

      textOutput(ns("gameweek_number"), inline = TRUE),


      textInput(ns("league_number"),
                "Please enter your mini-league number."),

      actionButton(ns("confirm_selection"),
                   "Confirm"),

      plotOutput(ns("league_points")),
      plotOutput(ns("league_rank"))

    )

  )
}

#' plot_league Server Functions
#'
#' @noRd
mod_plot_league_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    output$league_points <- renderPlot({
      if (input$confirm_selection == 0) {
        return()
      } else {
        plot_league_points(
          input$league_number
        )
      }

    })

    output$league_rank <- renderPlot({
      if (input$confirm_selection == 0) {
        return()
      } else {
        plot_league_standings(
          input$league_number
        )
      }

    })

    output$gameweek_number <- renderText({
      paste0(
        "We're in Gameweek ",
        get_current_gw_number()
      )
    })

  })
}

## To be copied in the UI
# mod_plot_league_ui("plot_league_1")

## To be copied in the server
# mod_plot_league_server("plot_league_1")
