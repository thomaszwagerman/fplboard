test_that("is a dataframe", {
  expect_s3_class(
    get_fdr_by_gameweek()$overall,
    "data.frame"
  )
})

test_that("col length is correct", {
  expect_equal(
    length(names(get_fdr_by_gameweek()$overall)),
      ((38 - get_current_gw_number()) * 2) + 1
  )
})
