test_that("is a dataframe", {
  expect_s3_class(
    get_current_gw_info(),
    "data.frame"
  )
})

test_that("colnames are correct", {
  expect_equal(
    length(names(get_current_gw_info())),
    23
  )
})

test_that("gw is numeric", {
  expect_length(
    get_current_gw_number(),
    1
  )

  expect_type(
    get_current_gw_number(),
    "integer"
  )
})

