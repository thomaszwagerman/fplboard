test_that("is a dataframe", {
  expect_s3_class(
    get_fdr_by_gameweek(),
    "data.frame"
  )
})

test_that("col length is correct", {
  expect_equal(
    length(names(get_fdr_by_gameweek())),
      ((38 - get_current_gw_number()) * 2) + 1
  )
})

test_that("is a dataframe", {
  expect_s3_class(
    get_fdr_for_selected_gameweek((get_current_gw_number()+1):38),
    "data.frame"
  )
})

