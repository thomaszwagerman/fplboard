test_that("is a plot", {
  expect_s3_class(
    plot_players_owned(9680, c(1:16)),
    "ggplot"
  )

  expect_s3_class(
    plot_starting_eleven(9680, c(1:16)),
    "ggplot"
  )
})

