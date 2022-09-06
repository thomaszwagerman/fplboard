
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

## Examples

This is a basic example which shows a function that return an expected
points (EP) table for a given mini league.

Under the hood it relies on `fplscrapR`’s `get_league_entries()` and
`get_player_info()` functions.

Let’s have a look at the ranks:

| entry_name          | expected_points_gw |
|:--------------------|-------------------:|
| Yes Ndidi           |               77.7 |
| Cookie Monstars     |               71.8 |
| Erik Ten Haggis     |               70.5 |
| Humza’s hunneez     |               65.6 |
| Martial Law         |               63.1 |
| SROSS FC            |               62.9 |
| Rise of Haaland     |               62.7 |
| Route-One Direction |               62.0 |
| Newhaven FC         |               46.8 |

Or visualising my mini league point, using `get_league_entries()`
information.
<img src="man/figures/README-point_plot-1.png" width="100%" />

Or by rank:

<img src="man/figures/README-ranked_plot-1.png" width="100%" />
