#' minileague_stats UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_minileague_stats_ui <- function(id){
  ns <- NS(id)
  tagList(
    textOutput(ns("gameweek_number"), inline = TRUE),

    textInput(ns("league_number"),
              "Please enter your mini-league number."),

    actionButton(ns("confirm_selection"),
                 "Confirm"),
    waiter::useWaiter(),
    fluidRow(
      waiter::withWaiter(
        gt::gt_output(ns("general_table")),
        html = loading_screen
      )
    ),
    fluidRow(
      column(4,
             waiter::withWaiter(
               gt::gt_output(ns("bench_table")),
               html = loading_screen
             )
      ),
      column(4,
             waiter::withWaiter(
               gt::gt_output(ns("value_table")),
               html = loading_screen
             )
      ),
      column(4,
             waiter::withWaiter(
               gt::gt_output(ns("hits_table")),
               html = loading_screen
             )
      )
    )
  )
}

#' minileague_stats Server Functions
#'
#' @noRd
mod_minileague_stats_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    league_name <- reactive(
      get_league_name(
        input$league_number
      )
    )

    general_information <- reactive(
      get_league_general_info(
        input$league_number
      )
    )

    output$general_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        general_information() |>
          dplyr::select(
            "Team" = .data$entry_name,
            "GW Points" = .data$points,
            "Total Points" = .data$total_points,
            "Overall Rank" = .data$overall_rank,
            .data$rank_change
          ) |>
          gt::gt() |>
          # This is to get a green/red arrow on rank change
          text_transform(
            locations = cells_body(columns = c(rank_change)),
            fn = function(x){

              rank_change <- as.integer(x)

              choose_logo <-function(x){
                if (x == 0){
                  gt::html(fontawesome::fa("equals", fill = "#7A7A7A"))
                } else if (x < 0){
                  gt::html(glue::glue("<span style='color:#05FA87;font-face:bold;font-size:10px;'>{x*-1}</span>"),
                           fontawesome::fa("arrow-up", fill = "#05FA87"))
                } else if (x > 0) {
                  gt::html(glue::glue("<span style='color:#FC2C80;font-face:bold;font-size:10px;'>{x}</span>"),
                           fontawesome::fa("arrow-down", fill = "#FC2C80"))
                }
              }

              lapply(rank_change, choose_logo)

            }) |>
          gt::cols_label(
            rank_change = ""
          ) |>
          gt::tab_header(
            title =  gt::md("League Standings and Overall Rank"),
            subtitle = gt::md(league_name())
          )
      }
    })

    bench_points <- reactive(
      get_league_bench_points(
        input$league_number
      )
    )

    output$bench_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        bench_points() |>
          dplyr::select(
            "Team" = .data$entry_name,
            "Points on bench" = .data$bench
          ) |>
          gt::gt() |>
          gt::tab_header(
            title =  gt::md("Total points on the bench"),
            subtitle = gt::md(league_name())
          )
      }
    })

    team_value <- reactive(
      get_league_team_value(
        input$league_number
      )
    )

    output$value_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        team_value() |>
          dplyr::select(
            "Team" = .data$entry_name,
            "Team Value" = .data$value
          ) |>
          gt::gt() |>
          gt::tab_header(
            title =  gt::md("Total team value"),
            subtitle = gt::md(league_name())
          )
      }
    })

    team_hits <- reactive(
      get_league_hits_taken(
        input$league_number
      )
    )

    output$hits_table <- gt::render_gt({
      if (input$confirm_selection == 0) {
        return()
      } else {
        team_hits() |>
          dplyr::select(
            "Team" = .data$entry_name,
            "Points deducted for transfers" = .data$transfer_cost
          ) |>
          gt::gt() |>
          gt::tab_header(
            title =  gt::md("Points deducted for transfers"),
            subtitle = gt::md(league_name())
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
# mod_minileague_stats_ui("minileague_stats_1")

## To be copied in the server
# mod_minileague_stats_server("minileague_stats_1")
