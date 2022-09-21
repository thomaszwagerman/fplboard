library(shiny)
library(reactable)
library(reactablefmtr)
library(fplscrapR)

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

  fixtures$oppo_fixture <- rev(fixtures$team_fixture)

  fdr <- tidyr::pivot_longer(
    fdr,
    cols = contains("strength"),
    names_to = c("category", "opposition_strength"),
    names_pattern = "strength_(.*)_(.*)",
    values_to = "rating",
  ) |>
    dplyr::filter(rating > 999)

  # Join by the opposition and remove home-home, away-away matches
  fdr <- dplyr::left_join(fixtures, fdr, by = c("oppo" = "short_name"))

  # Match the team's fixture to opposition strength
  fdr <- fdr |>
    filter(opposition_strength == team_fixture & team_fixture != oppo_fixture)

  overall <- fdr |>
    dplyr::filter(category == "overall") |>
    dplyr::select(GW, team, oppo, team_fixture, rating) |>
    tidyr::unite(
      col = "fixture",
      3:4,
      sep = " "
    )

  overall$fixture <- gsub("home", "(H)", overall$fixture)
  overall$fixture <- gsub("away", "(A)", overall$fixture)

  overall[is.na(overall$rating)] <- 0

  table_by_gameweek <- tidyr::pivot_wider(
    overall,
    names_from = "GW",
    values_from = c("fixture", "rating")
  )

  gw_input <- c(
    c(9:16)
  )

  gw_columns <- glue::glue("fixture_{gw_input}")
  rating_columns <- glue::glue("rating_{gw_input}")

  # Create a totals column based on the number of gameweeks
  totals <- table_by_gameweek |>
    dplyr::select(team, all_of(rating_columns)) |>
    tidyr::pivot_longer(
      cols = rating_columns,
      names_to = "gw",
      values_to = "rating"
    )

  # Getting Average FDR to allow sorting for selected gameweeks.
  # Filter out blank gameweeks and divide by number of games (rating),
  # This is so blank gameweeks don't skew overall picture
  avgs <- totals |>
    group_by(team) |>
    filter(rating > 0) |>
    summarise(average_fdr = sum(rating, na.rm = TRUE) / length(rating))

  avgs$average_fdr <- as.integer(avgs$average_fdr)

  # Create a list of column definitions, as required
  # by reactable
  fpl_color_pal = c("#375523", "#01fc7a", "#808080", "#ff1751", "#80072d")

  team_list <- list(
    team = colDef(
      maxWidth = 175,
      align = 'left',
      show = TRUE
    )
  )

  rating_cols <- lapply(gw_input, function(gw) {
    colDef(
      maxWidth = 175,
      style = color_scales(table_df,
                           colors = fpl_color_pal)
    )
  })

  # These need to be named lists!
  names(rating_cols) <- rating_columns

  fixture_cols <- lapply(gw_input, function(gw) {
    colDef(
      style = color_scales(table_df,
                           colors = fpl_color_pal,
                           color_by = glue::glue(
                             "rating_{gw}"
                           )
      ),
      sortable = FALSE
    )
  })

  names(fixture_cols) <- gw_columns

  avg_fdr_list <- list(
    average_fdr = colDef(
      maxWidth = 175
    )
  )

  # Combine the lists into one list, and group them.
  # This is so gw rating and fixture appear together
  table_list <- c(team_list, fixture_cols, rating_cols, avg_fdr_list)

  column_groups <- lapply(gw_input, function(gw) {
    colGroup(name = glue::glue("Gameweek {gw}"), columns = c(
      glue::glue("fixture_{gw}"),
      glue::glue("rating_{gw}")
    )
    )
  })

  # Joining the totals, so  table can be sorted for selected GWs
  table_by_gameweek <- left_join(table_by_gameweek, avgs)

  table_df <- table_by_gameweek |>
    select(team, all_of(gw_columns), average_fdr, all_of(rating_columns))

  output$table <- renderReactable({
    reactable(
      table_df,
      compact = TRUE,
      pagination = FALSE,
      showSortIcon = FALSE,
      columns = table_list,
      columnGroups = column_groups
    )
  })
}
shinyApp(ui, server)
