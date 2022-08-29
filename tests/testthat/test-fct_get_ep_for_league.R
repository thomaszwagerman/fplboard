test_that("is a dataframe", {
  expect_s3_class(
    get_ep_for_league(570437, 1),
    "data.frame"
    )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_ep_for_league(570437, 1)),
    c("entry_name", "expected_points_gw")
  )
})

test_that("handles numeric and character", {
  df <- get_ep_for_league(570437, 1)

  expect_equal(
    get_ep_for_league(570437, 1),
    df
  )
  expect_equal(
    get_ep_for_league("570437", "1"),
    df
  )
})
