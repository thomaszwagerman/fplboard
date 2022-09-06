
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fplboard <img src="inst/app/www/favicon.png" align="right" width="120"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/thomaszwagerman/fplboard/branch/main/graph/badge.svg)](https://app.codecov.io/gh/thomaszwagerman/fplboard?branch=main)
<!-- badges: end -->

The goal of fplboard is to create a dashboard to easily extract useful
information from the FPL api.

This dashboard is built on top of
[fplscrapR](https://github.com/wiscostret/fplscrapR), but also has its
own native functions.

## Installation

You can install the development version of fplboard like so:

``` r
remotes::install_github("thomaszwagerman/fplboard")

library(fplboard)
```

## Example

This is a basic example which shows a function that return an expected
points (EP) table for a given mini league.

Under the hood it relies on `fplscrapR`’s `get_league_entries()` and
`get_player_info()` functions.

Let’s have a look at the ranks:

    #> Joining, by = "entry"
    #> Joining, by = "element"

Or visualising my mini league rank, using `get_league_entries()`
information.

<img src="man/figures/README-ranked_plot-1.png" width="100%" />
