#' ep_team UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ep_team_ui <- function(id) {
  ns <- NS(id)

  tagList(

    textInput(ns("team_number"),
              "Please enter your team number."),

    selectInput(ns("gameweek_number"),
                "For which gameweek?",
                c(1:36)),

    actionButton(ns("confirm_selection"),
                 "Confirm"),

    tableOutput(ns("ep_table"))

  )
}

#' ep_team Server Functions
#'
#' @noRd
mod_ep_team_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(
      get_ep_for_entrant(
        input$team_number,
        input$gameweek_number
      )
    )

    output$ep_table <- renderTable({
      if (input$confirm_selection == 0) {
        return()
      } else {
        data()
      }

    })
  })
}