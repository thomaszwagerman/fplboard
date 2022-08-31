#' The ep_table UI Function
#'
#' @description Shiny module leveraging `get_ep_for_league()`
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ep_table_ui <- function(id) {
  ns <- NS(id)

  tagList(

    textOutput(ns("gameweek_number"), inline = TRUE),


    textInput(ns("league_number"),
              "Please enter your mini-league number."),

    actionButton(ns("confirm_selection"),
                 "Confirm"),

    tableOutput(ns("ep_table"))

  )
}

#' The ep_table Server Functions
#'
#' @noRd
mod_ep_table_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(
      get_ep_for_league(
        input$league_number,
        get_current_gw_number()
      )
    )

    output$ep_table <- renderTable({
      if (input$confirm_selection == 0) {
        return()
      } else {
        data()
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
