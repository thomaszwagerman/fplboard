test_that("is a dataframe", {
  expect_s3_class(
    get_ep_for_entrant(9680, 1),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    names(get_ep_for_entrant(9680, 1)),
    c(
      "position",
      "is_captain",
      "is_vice_captain",
      "team_code",
      "photo",
      "playername",
      "ep_next",
      "value_form",
      "selected_by_percent")
  )
})

test_that("handles numeric and character", {
  df <- get_ep_for_entrant(9680, 1)

  expect_equal(
    get_ep_for_entrant(9680, 1),
    df
  )
  expect_equal(
    get_ep_for_entrant("9680", "1"),
    df
  )
})
