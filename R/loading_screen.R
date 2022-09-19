# Loading screen for waiter
url <- "https://www.premierleague.com/resources/prod/v6.98.1-4068/i/elements/premier-league-logo.svg"
loading_screen <- tagList(
  h3("Getting FPL data"),
  img(src = url, height = "200px"),
  p("With larger leagues this may take a while..."),
  waiter::spin_loaders(42),
  color = "#37003c"
)
