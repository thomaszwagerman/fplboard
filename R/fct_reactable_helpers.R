#' Getting column list for reactable
#'
#' @description Returning a list of column definitions for a reactable table.
#'
#' @param fdr_selected_gameweek the fdr_selected_gameweek() functions
#' @param input_gw the gameweek provided by user selection
#'
#' @export
#'
#' @importFrom rlang .data
get_rct_columns <- function(fdr_selected_gameweek, input_gw) {
  gw_columns <- paste0(
    "fixture_",
    c(min(input_gw):max(input_gw))
  )

  rating_columns <- paste0(
    "rating_",
    c(min(input_gw):max(input_gw))
  )

  gw_input <- c(min(input_gw):max(input_gw))

  fpl_color_pal = c("#375523", "#01fc7a", "#808080", "#ff1751", "#80072d")

  team_list <- list(
    team = reactable::colDef(
      maxWidth = 175,
      align = 'left',
      show = TRUE
    )
  )

  rating_cols <- lapply(gw_input, function(gw) {
    reactable::colDef(
      maxWidth = 175,
      style = reactablefmtr::color_scales(fdr_selected_gameweek,
                           colors = fpl_color_pal)
    )
  })

  # These need to be named lists!
  names(rating_cols) <- rating_columns

  fixture_cols <- lapply(rating_columns, function(gw) {
    reactable::colDef(
      style = reactablefmtr::color_scales(fdr_selected_gameweek,
                           colors = fpl_color_pal,
                           color_by = gw
      ),
      sortable = FALSE
    )
  })

  names(fixture_cols) <- gw_columns

  avg_fdr_list <- list(
    average_fdr = reactable::colDef(
      maxWidth = 175,
      style = reactablefmtr::color_scales(
        fdr_selected_gameweek,
        colors = fpl_color_pal
      )
    )
  )

  # Combine the lists into one list, and group them.
  # This is so gw rating and fixture appear together
  table_list <- list()
  table_list <- c(team_list, fixture_cols, rating_cols, avg_fdr_list)

}

#' Getting column groups for reactable
#'
#' @description Returning a list of column groups for a reactable table.
#'
#' @param input_gw the gameweek provided by user selection
#'
#' @export
#'
#' @importFrom rlang .data
# Create a a list of columns needed for reactable
get_rct_groups <- function(input_gw) {
  gw_input <- c(min(input_gw):max(input_gw))

  column_groups <- lapply(gw_input, function(gw) {
    reactable::colGroup(name = glue::glue("Gameweek {gw}"),
             columns = c(
               glue::glue("fixture_{gw}"),
               glue::glue("rating_{gw}")
             )
    )
  })
}
