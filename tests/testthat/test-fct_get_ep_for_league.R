test_that("is a dataframe", {
  expect_s3_class(
    get_ep_for_league(570437, 1),
    "data.frame"
    )
})

