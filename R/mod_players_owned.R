#' players_owned UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_players_owned_ui <- function(id){
  ns <- NS(id)
  tagList(

    waiter::useWaiter(),
    textOutput(ns("gameweek_number"), inline = TRUE),

    textInput(ns("team_number"),
              "Please enter your team number."),

    sliderInput(ns("gw"),
                "Select gameweek range: ",
                min = 1, max = get_current_gw_number(),
                value = c(
                  1,
                  get_current_gw_number()
                ),
                step = 1,
                round = TRUE
    ),

    actionButton(ns("confirm_selection"),
                 "Confirm"),

    tags$hr(),

    waiter::withWaiter(
      plotOutput(ns("plot_players_owned")),
      html = loading_screen
    ),
    waiter::withWaiter(
      plotOutput(ns("plot_starting_eleven")),
      html = loading_screen
    )

  )
}

#' players_owned Server Functions
#'
#' @noRd
mod_players_owned_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    # Starting with league points
    players_owned <- eventReactive(input$confirm_selection, {
      plot_players_owned(
        input$team_number,
        min(input$gw):max(input$gw)
      )
    })

    output$plot_players_owned <- renderPlot({
      players_owned()
    })

    # Moving on to league rank
    starting_eleven <- eventReactive(input$confirm_selection, {
      plot_starting_eleven(
        input$team_number,
        min(input$gw):max(input$gw)
      )
    })

    output$plot_starting_eleven <- renderPlot({
      starting_eleven()
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

## To be copied in the UI
# mod_players_owned_ui("players_owned_1")

## To be copied in the server
# mod_players_owned_server("players_owned_1")
