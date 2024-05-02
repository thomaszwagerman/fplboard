#' ep_team UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_ep_team_ui <- function(id, current_theme) {
  ns <- NS(id)

  tagList(
    textOutput(ns("gameweek_number"), inline = TRUE),

    textInput(ns("team_number"),
              "Please enter your team number."),


    actionButton(ns("confirm_selection"),
                 "Confirm"),
    tags$hr(),
    waiter::useWaiter(),

    fluidRow(
      column(6,
             waiter::withWaiter(
               gt::gt_output(ns("ep_table")),
               html = loading_screen
             )
      ),
      column(6,
             waiter::withWaiter(
               gt::gt_output(ns("not_owned_table")),
               html = loading_screen
             )
      )
    )
  )
}

#' ep_team Server Functions
#'
#' @noRd
mod_ep_team_server <- function(id, current_theme) {
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

    team_name <- reactive(
      fplscrapR::get_entry(
        input$team_number
      )$name
    )

    output$ep_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        data_team() |>
          dplyr::select("team"_code, "photo",
                        "Player" = "playername",
                        "Expected Points" = "ep_next",
                        "Selected by (%)" = "selected_by_percent") |>
          gt::gt() |>
          gtExtras::gt_img_rows("photo", img_source = "web") |>
          gtExtras::gt_img_rows("team"_code, img_source = "web") |>
          gt::cols_label(
            team_code = "",
            photo = ""
          ) |>
          gt::tab_row_group(
            label = "Bench",
            rows = c(12:15)
          ) |>
          gt::tab_row_group(
            label = "Starting 11",
            rows = c(1:11)
          ) |>
          gt::tab_header(
            title =  gt::md("Expected Points"),
            subtitle = gt::md(paste0(
              "Players owned by ",team_name()
            ))
          ) |>
          gt_table_theme(
            current_theme = current_theme
          )
      }

    })

    output$not_owned_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        # Only show the first 15 players to match team length
        data_not_owned()[1:15,] |>
          dplyr::select("team"_code, "photo",
                        "Player" = "playername",
                        "Expected Points" = "ep_next",
                        "Selected by (%)" = "selected_by_percent",
                        "Transfers In" = "transfers_in") |>
          gt::gt() |>
          gtExtras::gt_img_rows("photo", img_source = "web") |>
          gtExtras::gt_img_rows("team"_code, img_source = "web") |>
          gt::cols_label(
            team_code = "",
            photo = ""
          ) |>
          gt::tab_header(
            title =  gt::md("Expected Points"),
            subtitle = gt::md(paste0(
              "Players not owned by ", team_name()
            ))
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
