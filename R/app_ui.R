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
    navbarPage(
      title = tags$img(
        src = "www/logo.png",
        height = "100px"
      ),
      windowTitle = "fplboard",
      theme = dark,
      bslib::nav(
        "Getting Started",
        htmltools::includeMarkdown(app_sys("app/www/getting_started.md")),
        align = "middle"
      ),
      bslib::nav_menu(
        "Past",
        bslib::nav(
          "Mini-league Standings",
          mod_plot_league_ui("plot_league_1"),
          align = "middle"
        )
      ),
      bslib::nav_menu(
        "Present",
        bslib::nav(
          "Current Team Expected Points",
          mod_ep_team_ui("ep_team_1"),
          align = "middle"
        ),
        bslib::nav(
          "Mini-league Stats",
          mod_minileague_stats_ui("minileague_stats_1"),
          align = "left"
        )
      ),
      bslib::nav_menu(
        "Future",
        bslib::nav(
          "Mini-league Expected Points",
          mod_ep_table_ui("ep_table_1"),
          align = "middle"
        )
      ),
      bslib::nav(
        "About",
        htmltools::includeMarkdown(app_sys("app/www/about.md")),
        align = "middle"
      ),
      bslib::nav_item(
        tags$a(
          icon("github"),
          "Source Code",
          href = "https://github.com/thomaszwagerman/fplboard",
          target = "_blank"
        ),
        bslib::nav_item(
          shinyWidgets::materialSwitch("light_mode", label = icon("sun"))
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
