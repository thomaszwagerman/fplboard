test_that("is a dataframe", {
  expect_s3_class(
    get_league_historic_standings(570437),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    length(names(get_league_historic_standings(570437))),
    13
  )
})

test_that("handles numeric and character", {
  df <- get_league_historic_standings(570437)

  expect_equal(
    get_league_historic_standings(570437),
    df
  )
  expect_equal(
    get_league_historic_standings("570437"),
    df
  )
})

test_that("gets correct name", {
  expect_equal(
    get_league_name(570437),
    "Brotchie's Benchwarmers"
  )
})
