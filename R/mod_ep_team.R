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
    textOutput(ns("gameweek_number"), inline = TRUE),

    textInput(ns("team_number"),
              "Please enter your team number."),


    actionButton(ns("confirm_selection"),
                 "Confirm"),

    tableOutput(ns("ep_table")),

    tableOutput(ns("not_owned_table")))
}

#' ep_team Server Functions
#'
#' @noRd
mod_ep_team_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data_team <- reactive(
      get_ep_for_entrant(
        input$team_number,
        get_current_gw_number()
      )
    )

    data_not_owned <- reactive(
      get_ep_not_owned(
        input$team_number,
        get_current_gw_number()
      )
    )

    output$ep_table <- renderTable({
      if (input$confirm_selection == 0) {
        return()
      } else {
        data_team()
      }

    })

    output$not_owned_table <- renderTable({
      if (input$confirm_selection == 0) {
        return()
      } else {
        # Only show the first 15 players to match team length
        data_not_owned()[1:15,]
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
