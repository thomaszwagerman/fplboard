#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      h1("fplboard"),
      navlistPanel(
        id = "tabset",
        # Mini league panel
        "Mini League Info",
        tabPanel("panel_league",
                 mod_ep_table_ui("ep_table_1")
        ),
        # Player data panel
        "Player Information",
        tabPanel("panel_players",
                 "Placeholder Players")
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "fplboard"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
