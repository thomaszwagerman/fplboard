test_that("is a plot", {
  expect_s3_class(
    plot_league_standings(570437),
    "ggplot"
  )

  expect_s3_class(
    plot_league_points(570437),
    "ggplot"
  )
})

