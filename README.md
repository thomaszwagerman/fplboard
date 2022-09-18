
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

fplboard is built in a modular way using the golem framework. Each
module has its own functionality and is an individual menu item, meaning
features will be added to this package slowly over time.

## Installation

You can install the development version of fplboard like so:

``` r
remotes::install_github("thomaszwagerman/fplboard")

library(fplboard)
```

## Examples

This is a basic example which shows a function that return expected
points table for a given team.

Under the hood it relies on `fplscrapR`’s `get_entry_player_picks()` and
`get_player_info()` functions.

Let’s have a look at the table:

<p align="center">
<img src="man/figures/bencwarmer_table.png">
</p>

Another bit of functionality is plotting minileague point over time,
using `get_league_entries()` information:

<img src="man/figures/README-point_plot-1.png" width="100%" />

Or by rank for each gameweek:

<img src="man/figures/README-ranked_plot-1.png" width="100%" />
