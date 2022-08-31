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
        # What is the story so far?
        "Past",
        tabPanel("panel_present",
                 "Placeholder Past"),
        "Present",
        # How are we doing this gameweek?
        tabPanel("panel_team",
                 mod_ep_team_ui("ep_team_1")
        ),
        # What will we do next gameweek?
        "Future",
        tabPanel("panel_league",
                 mod_ep_table_ui("ep_table_1")
        )
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
