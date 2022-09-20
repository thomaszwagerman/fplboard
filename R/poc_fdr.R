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

  test <- tidyr::pivot_wider(
    overall,
    names_from = "GW",
    values_from = c("fixture", "rating")
  )

  output$table <- renderReactable({
    gw_input <- c(
      c(9:13)
    )

    gw_columns <- glue::glue("fixture_{gw_input}")
    rating_columns <- glue::glue("rating_{gw_input}")

    totals <- test |>
      dplyr::select(team, all_of(rating_columns)) |>
      tidyr::pivot_longer(
        cols = rating_columns,
        names_to = "gw",
        values_to = "rating"
      )

    totals$rating[is.na(totals$rating)] <- 0

    totals <- totals |>
      group_by(team) |>
      summarise(total = sum(rating))

    team_list <- list(
      team = colDef(
        maxWidth = 175,
        align = 'left',
        show = TRUE
      )
    )

    column_groups <- lapply(gw_input, function(gw) {
      colGroup(name = glue::glue("Gameweek {gw}"), columns = c(
        glue::glue("fixture_{gw}"),
        glue::glue("rating_{gw}")
      )
      )
    })

    fixture_cols <- lapply(gw_input, function(gw) {
      colDef(
        style = color_scales(test,
                             color_by = glue::glue(
                               "rating_{gw}"
                             )
        ),
        sortable = FALSE
      )
    })

    names(fixture_cols) <- gw_columns

    # We'd like to hide these
    rating_cols <- lapply(gw_input, function(gw) {
      colDef(
        maxWidth = 175,
        style = color_scales(test)
      )
    })

    names(rating_cols) <- rating_columns

    total_list <- list(
      total = colDef(
        maxWidth = 175
      )
    )

    table_list <- c(team_list, fixture_cols, rating_cols, total_list)

    test <- left_join(test, totals)

    table_df <- test |>
      select(team, all_of(gw_columns), total, all_of(rating_columns))

    reactable(
      table_df,
      compact = TRUE,
      pagination = FALSE,
      showSortIcon = FALSE,

      columns = table_list,
      columnGroups = column_groups
    )
  })

  shinyApp(ui, server)
