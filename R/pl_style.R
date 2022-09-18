#' Add pl theme to ggplot chart
#'
#' This function allows you to add the pl theme to ggplot graphics.
#' @keywords pl_style
#' @export
pl_style <- function() {

  ggplot2::theme(

    legend.background = ggplot2::element_blank(),
    legend.title = ggplot2::element_blank(),
    legend.key = ggplot2::element_blank(),

    axis.title = ggplot2::element_blank(),
    axis.text.x = ggplot2::element_text(margin=ggplot2::margin(5, b = 10)),
    axis.ticks = ggplot2::element_blank(),
    axis.line = ggplot2::element_blank(),

    panel.grid.minor = ggplot2::element_blank(),
    panel.grid.major.y = ggplot2::element_line(color="#cbcbcb"),
    panel.grid.major.x = ggplot2::element_blank(),

    # Blank background
    # This sets the panel background as blank,
    # removing the standard grey ggplot background colour from the plot
    panel.background = ggplot2::element_blank(),
  )
}
