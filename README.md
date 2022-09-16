
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fplboard <img src="inst/app/www/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/thomaszwagerman/fplboard/branch/main/graph/badge.svg)](https://app.codecov.io/gh/thomaszwagerman/fplboard?branch=main)
<!-- badges: end -->

The goal of fplboard is to create a dashboard to easily extract useful
information from the FPL API.

This dashboard is built on top of
[fplscrapR](https://github.com/wiscostret/fplscrapR), but also has its
own native functions.

## Installation

You can install the development version of fplboard like so:

``` r
remotes::install_github("thomaszwagerman/fplboard")

library(fplboard)
```

## Examples

This is a basic example which shows a function that return an expected
points (EP) table for a given mini league.

Under the hood it relies on `fplscrapR`’s `get_league_entries()` and
`get_player_info()` functions.

Let’s have a look at the ranks:

| entry_name          | expected_points_gw |
|:--------------------|-------------------:|
| Rise of Haaland     |               56.3 |
| Yes Ndidi           |               51.0 |
| Humza’s hunneez     |               47.9 |
| SROSS FC            |               47.7 |
| Cookie Monstars     |               46.7 |
| Erik Ten Haggis     |               46.7 |
| Martial Law         |               46.2 |
| Route-One Direction |               42.0 |
| Newhaven FC         |               32.7 |

Or visualising my mini league point, using `get_league_entries()`
information:

<img src="man/figures/README-point_plot-1.png" width="100%" />

Or by rank:

<img src="man/figures/README-ranked_plot-1.png" width="100%" />
