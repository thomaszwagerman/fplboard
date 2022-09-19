#' plot_league UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_plot_league_ui <- function(id) {
  ns <- NS(id)
  tagList(

    tagList(
      waiter::useWaiter(),
      textOutput(ns("gameweek_number"), inline = TRUE),

      textInput(ns("league_number"),
                "Please enter your mini-league number."),
      actionButton(ns("confirm_selection"),
                   "Confirm"),
      tags$hr(),
      waiter::withWaiter(
        plotOutput(ns("league_points")),
        html = loading_screen
      ),
      waiter::withWaiter(
        plotOutput(ns("league_rank")),
        html = loading_screen
      )

    )

  )
}

#' plot_league Server Functions
#'
#' @noRd
mod_plot_league_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # Starting with league points
    league_points <- eventReactive(input$confirm_selection, {
      plot_league_points(
        input$league_number
      )
    })

    output$league_points <- renderPlot({
      league_points()
    })

    # Moving on to league rank
    league_rank <- eventReactive(input$confirm_selection, {
      plot_league_standings(
        input$league_number
      )
    })

    output$league_rank <- renderPlot({
      league_rank()
    })

    # Finally show the gameweek number
    output$gameweek_number <- renderText({
      paste0(
        "We're in Gameweek ",
        get_current_gw_number()
      )
    })

  })
}
