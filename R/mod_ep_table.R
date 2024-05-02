#' The ep_table UI Function
#'
#' @description Shiny module leveraging `get_ep_for_league()`
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ep_table_ui <- function(id, current_theme) {
  ns <- NS(id)

  tagList(

    textOutput(ns("gameweek_number"), inline = TRUE),


    textInput(ns("league_number"),
              "Please enter your mini-league number."),

    actionButton(ns("confirm_selection"),
                 "Confirm"),

    tags$hr(),

    gt::gt_output(ns("ep_table"))
  )
}

#' The ep_table Server Functions
#'
#' @noRd
mod_ep_table_server <- function(id, current_theme) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(
      get_ep_for_league(
        input$league_number,
        get_current_gw_number()
      )
    )

    league_name <- reactive(
      get_league_name(
        input$league_number
      )
    )

    output$ep_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        data() |>
          dplyr::select(
            "Team" = "entry"_name,
            "Expected Points" = "expected_points_gw"
          ) |>
          gt::gt() |>
          gt::tab_header(
            title =  gt::md("Expected Points this Gameweek"),
            subtitle = gt::md(league_name())
          ) |>
          gt_table_theme(
            current_theme = current_theme
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
