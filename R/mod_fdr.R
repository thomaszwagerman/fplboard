#' fdr UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_fdr_ui <- function(id, current_theme) {
  ns <- NS(id)
  tagList(
    waiter::useWaiter(),
    selectInput(ns("type"),
      "Select type of difficulty",
      choices = c(
        "overall",
        "attack",
        "defence"
      ),
      selected = "overall"
    ),
    sliderInput(ns("gw"),
      "Select gameweek range: ",
      min = get_current_gw_number(), max = 36,
      value = c(
        get_current_gw_number() + 1,
        get_current_gw_number() + 5
      ),
      step = 1,
      round = TRUE
    ),
    waiter::withWaiter(
      reactable::reactableOutput(ns("table")),
      html = loading_screen
    )
  )
}

#' fdr Server Functions
#'
#' @noRd
mod_fdr_server <- function(id, current_theme) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    fdr_df <- reactive({
      get_fdr_for_selected_gameweek(input$gw, input$type)
    })

    fdr_column_list <- reactive({
      get_rct_columns(fdr_df(), input$gw)
    })

    fdr_column_groups <- reactive({
      get_rct_groups(input$gw)
    })

    output$table <- renderReactable({
      reactable::reactable(
        fdr_df(),
        compact = TRUE,
        pagination = FALSE,
        showSortIcon = FALSE,
        columns = fdr_column_list(),
        columnGroups = fdr_column_groups()
      )
    })
  })
}
