library(shiny)
library(reactable)

ui <- fluidPage(
  reactableOutput("table")
)

server <- function(input, output) {

  fdr <- fplscrapR::get_fdr() |>
    dplyr::select(short_name, contains("strength"))

  fixtures <- fplscrapR::get_game_list() |>
    dplyr::filter(GW > get_current_gw_number())

  fixtures <- rbind(
    fixtures |>
      dplyr::mutate(team = home,
             oppo = away,
             homeaway = "home"),
    fixtures |>
      dplyr::mutate(team = away,
             oppo = home,
             homeaway = "away")
  )  |>
    dplyr::select(GW, team, oppo, team_fixture = homeaway)

  fdr <- tidyr::pivot_longer(
    fdr,
    cols = contains("strength"),
    names_to = c("category", "opposition_fixture"),
    names_pattern = "strength_(.*)_(.*)",
    values_to = "rating",
  )

  fdr <- fdr |>
    dplyr::filter(rating > 999)

  # Join by the opposition and remove home-home, away-away matches
  fdr <- dplyr::left_join(fixtures, fdr, by = c("oppo" = "short_name"))
  fdr <- fdr[duplicated(fdr[c("team_fixture", "opposition_fixture"),]),]

  output$table <- renderReactable({
    reactable(fdr)
  })
}

shinyApp(ui, server)
