
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fplboard

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![Codecov test
coverage](https://codecov.io/gh/thomaszwagerman/fplboard/branch/main/graph/badge.svg)](https://app.codecov.io/gh/thomaszwagerman/fplboard?branch=main)
<!-- badges: end -->

# {fplboard} <img src="https://raw.githubusercontent.com/thomaszwagerman/fplboard/main/inst/www/favicon.png" align="right" width="120"/>

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
points (EP) table for a given miniweek.

Under the hood it relies on `fplscrapR`’s `get_league_entries()` and
`get_player_info()` functions.

Let’s have a look at FPL Focal’s mini league top 10 for EP in gameweek
1:

    #> Joining, by = "entry"
    #> Joining, by = "element"

| entry_name         | expected_points_gw |
|:-------------------|-------------------:|
| CA ElAntilope      |               82.7 |
| Hotel? Thiago.     |               82.2 |
| 22                 |               81.5 |
| FYewFc             |               81.2 |
| SmithRoweYourBoat  |               81.2 |
| 八百六十八包夜     |               78.5 |
| Adem_Ouis_Dz       |               78.1 |
| Groß & Petit Piton |               77.9 |
| Miami’s McMayhem   |               77.9 |
| Núnez\>Haaland     |               77.9 |
