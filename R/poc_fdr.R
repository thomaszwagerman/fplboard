library(shiny)
library(reactable)
library(reactablefmtr)
library(fplscrapR)

ui <- fluidPage(
  selectInput("type",
              "Select type of difficulty",
              choices = c(
                "overall",
                "attack",
                "defence"
              ),
              selected = "overall"
  ),
  sliderInput("gw", "Select gameweek range: ",
              min = get_current_gw_number(), max = 36,
              value = c(get_current_gw_number()+1, get_current_gw_number() + 5), step = 1,
              round = TRUE),
  reactableOutput("table")
)

server <- function(input, output) {
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
    reactable(
      fdr_df(),
      compact = TRUE,
      pagination = FALSE,
      showSortIcon = FALSE,
      #columns = fdr_column_list(),
      columnGroups = fdr_column_groups()
    )
  })
}
shinyApp(ui, server)
