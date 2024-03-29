#' Getting current gameweek information
#'
#' @description This function fetches the current gameweek information
#'
#' @examples
#' get_current_gw_info()
#'
#'
#' @export
#'
#' @importFrom rlang .data
get_current_gw_info <- function() {
  round_info <- fplscrapR::get_round_info()
  round_info$deadline_time <- lubridate::ymd_hms(round_info$deadline_time)
  # It appears all FPL deadlines in the API call are GMT, so to avoid a
  # 1-hour mismatch in summer time, I'm using lubridate's now(),
  # instead of Sys.time()
  #
  # Maybe a little bit lazy, but if I wanted to avoid a dependency on
  # lubridate I could come back and engineer something more complicated

  # Filterting for the gameweeks whose deadline has passed AND
  # gameweek that has not finished yet, givese us the current gameweek
  current_gw_info <- round_info |>
    dplyr::filter(.data$is_current == TRUE)
  return(current_gw_info)
}

#' Getting current gameweek number
#'
#' @description This function fetches the current gameweek number
#'
#' @examples
#'
#' get_current_gw_number()
#'
#' @export
#'
#' @importFrom rlang .data
get_current_gw_number <- function() {
  current_gw_number <- get_current_gw_info() |>
    dplyr::select(.data$id)

  if(nrow(current_gw_number) > 0) {
    return(current_gw_number$id)
  } else{
    # Important line for pre-season, because we can't have GW 0
    return(1)
  }
}

#' Getting next gameweek information
#'
#' @description This function fetches the next gameweek information
#'
#' @examples
#' get_next_gw_info()
#'
#'
#' @export
#'
#' @importFrom rlang .data
get_next_gw_info <- function() {
  round_info <- fplscrapR::get_round_info()
  round_info$deadline_time <- lubridate::ymd_hms(round_info$deadline_time)
  # It appears all FPL deadlines in the API call are GMT, so to avoid a
  # 1-hour mismatch in summer time, I'm using lubridate's now(),
  # instead of Sys.time()
  #
  # Maybe a little bit lazy, but if I wanted to avoid a dependency on
  # lubridate I could come back and engineer something more complicated

  # Filterting for the gameweeks whose deadline has passed AND
  # gameweek that has not finished yet, givese us the next gameweek
  next_gw_info <- round_info |>
    dplyr::filter(.data$is_next == TRUE)
  return(next_gw_info)
}

#' Getting next gameweek number
#'
#' @description This function fetches the next gameweek number
#'
#' @examples
#'
#' get_next_gw_number()
#'
#' @export
#'
#' @importFrom rlang .data
get_next_gw_number <- function() {
  next_gw_number <- get_next_gw_info() |>
    dplyr::select(.data$id)
  return(next_gw_number$id)
}
