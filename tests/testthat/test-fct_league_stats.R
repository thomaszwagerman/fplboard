# General information
test_that("is a dataframe", {
  expect_s3_class(
    get_league_general_info(570437),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_league_general_info(570437)),
    c("entry_name", "points",
      "total_points", "overall_rank",
      "rank_change")
  )
})

test_that("handles numeric and character", {
  df <- get_league_general_info(570437)

  expect_equal(
    get_league_general_info(570437),
    df
  )
  expect_equal(
    get_league_general_info("570437"),
    df
  )
})

# Bench points
test_that("is a dataframe", {
  expect_s3_class(
    get_league_bench_points(570437),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_league_bench_points(570437)),
    c("entry_name", "bench")
  )
})

test_that("handles numeric and character", {
  df <- get_league_bench_points(570437)

  expect_equal(
    get_league_bench_points(570437),
    df
  )
  expect_equal(
    get_league_bench_points("570437"),
    df
  )
})

# Team value
test_that("is a dataframe", {
  expect_s3_class(
    get_league_team_value(570437),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_league_team_value(570437)),
    c("entry_name", "value")
  )
})

test_that("handles numeric and character", {
  df <- get_league_team_value(570437)

  expect_equal(
    get_league_team_value(570437),
    df
  )
  expect_equal(
    get_league_team_value("570437"),
    df
  )
})

# Hits taken
test_that("is a dataframe", {
  expect_s3_class(
    get_league_hits_taken(570437),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_league_hits_taken(570437)),
    c("entry_name", "transfer_cost")
  )
})

test_that("handles numeric and character", {
  df <- get_league_hits_taken(570437)

  expect_equal(
    get_league_hits_taken(570437),
    df
  )
  expect_equal(
    get_league_hits_taken("570437"),
    df
  )
})
