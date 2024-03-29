#' Getting fdr table by gameweek
#'
#' @description This function combines the fixtures and fdr ratings to get
#' a table by gamweek.
#'
#' @examples
#' get_fdr_by_gameweek()
#'
#'
#' @export
#'
#' @importFrom rlang .data
get_fdr_by_gameweek <- function() {
  fdr <- fplscrapR::get_fdr() |>
    dplyr::select(.data$short_name, dplyr::contains("strength"))

  fixtures <- fplscrapR::get_game_list() |>
    dplyr::filter(.data$GW > get_current_gw_number())

  fixtures <- rbind(
    fixtures |>
      dplyr::mutate(team = .data$home,
                    oppo = .data$away,
                    homeaway = "home"),
    fixtures |>
      dplyr::mutate(team = .data$away,
                    oppo = .data$home,
                    homeaway = "away")
  )  |>
    dplyr::select(
      .data$GW,
      .data$team,
      .data$oppo,
      team_fixture = .data$homeaway
    )

  fixtures$oppo_fixture <- rev(fixtures$team_fixture)

  fdr <- tidyr::pivot_longer(
    fdr,
    cols = dplyr::contains("strength"),
    names_to = c("category", "opposition_strength"),
    names_pattern = "strength_(.*)_(.*)",
    values_to = "rating",
  ) |>
    dplyr::filter(.data$rating > 999)

  # Join by the opposition and remove home-home, away-away matches
  fdr <- dplyr::left_join(fixtures, fdr, by = c("oppo" = "short_name"))

  # Match the team's fixture to opposition strength
  fdr <- fdr |>
    dplyr::filter(
      .data$opposition_strength == .data$team_fixture &
        .data$team_fixture != .data$oppo_fixture)

  difficulty_options <- c(
    "overall", "attack", "defence"
  )

  tables_by_gameweek <- lapply(difficulty_options, function(input_type) {
    overall <- fdr |>
      dplyr::filter(.data$category == input_type) |>
      dplyr::select(
        .data$GW,
        .data$team,
        .data$oppo,
        .data$team_fixture,
        .data$rating) |>
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
      values_from = c("fixture", "rating"),
      values_fn = function(x) paste(x, collapse=", ")
    )

    # Taking an average rating for double Gws
    list_averaged <- lapply(unique(fdr$GW), function(n) {
      varname <- paste0("rating_", n)
      # Only do this if double gameweeks occur, ie ratings are longer than 4 characters
      if(max(nchar(table_by_gameweek[[varname]], keepNA = FALSE)) > 4) {
        averaged <- table_by_gameweek |>
          tidyr::separate(col = varname, sep = ",", into = c("min", "max")) |>
          dplyr::mutate(
            max = as.numeric(ifelse(is.na(max), min, max)),
            min = as.numeric(min),
            "rating_{n}" := round((min + max)/2)
          )
        return(averaged[[varname]])
      }
    })

    names(list_averaged) <- paste0("rating_", unique(fdr$GW))
    ratings_averaged <- dplyr::bind_cols(list_averaged) |>
      dplyr::mutate(dplyr::across(dplyr::everything(), as.character))

    table_by_gameweek[names(ratings_averaged)] <- ratings_averaged

    return(table_by_gameweek)
  })

  names(tables_by_gameweek) <- difficulty_options

  return(tables_by_gameweek)
}

#' Getting fdr table by specific gameweeks
#'
#' @description This function combines the fixtures and fdr ratings to get
#' a table by gameweek, and then select specific columns for gameweeks specified.
#' If you want the table to be update according to user input, these should be reactive
#'
#' @param input_gw the gameweeks you want the fdr table for
#' @param input_type one of "overall", "attack", "defence". Defaults to "overall"
#'
#' @examples
#' gw_columns <- c(30:35)
#' input_type <- "attack"
#'
#' get_fdr_for_selected_gameweek(gw_columns, input_type)
#'
#'
#' @export
#'
#' @importFrom rlang .data
get_fdr_for_selected_gameweek <- function(input_gw, input_type = "overall") {
  gw_columns <- paste0(
    "fixture_",
    c(min(input_gw):max(input_gw))
  )

  rating_columns <- paste0(
    "rating_",
    c(min(input_gw):max(input_gw))
  )

  totals <- get_fdr_by_gameweek()[[input_type]] |>
    dplyr::select(
      .data$team,
      dplyr::all_of(rating_columns)
    ) |>
    tidyr::pivot_longer(
      cols = dplyr::all_of(rating_columns),
      names_to = "gw",
      values_to = "rating"
    )

  avgs <- totals |>
    dplyr::group_by(.data$team) |>
    dplyr::filter(.data$rating > 0) |>
    dplyr::summarise(
      average_fdr = sum(as.numeric(.data$rating), na.rm = TRUE) / length(as.numeric(.data$rating))
    )

  avgs$average_fdr <- as.integer(avgs$average_fdr)

  # Joining the totals, so  table can be sorted for selected GWs
  table_by_gameweek <- dplyr::left_join(get_fdr_by_gameweek()[[input_type]], avgs)

  table_df <- table_by_gameweek |>
    dplyr::select(
      .data$team,
      dplyr::all_of(gw_columns),
      .data$average_fdr,
      dplyr::all_of(rating_columns))

  table_df <- table_df |>
    dplyr::mutate_at(dplyr::vars(rating_columns), as.numeric)
}
