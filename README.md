
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

<div id="qpjozegdlu" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#qpjozegdlu .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#qpjozegdlu .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qpjozegdlu .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#qpjozegdlu .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#qpjozegdlu .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qpjozegdlu .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#qpjozegdlu .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#qpjozegdlu .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#qpjozegdlu .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#qpjozegdlu .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#qpjozegdlu .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#qpjozegdlu .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#qpjozegdlu .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#qpjozegdlu .gt_from_md > :first-child {
  margin-top: 0;
}

#qpjozegdlu .gt_from_md > :last-child {
  margin-bottom: 0;
}

#qpjozegdlu .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#qpjozegdlu .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#qpjozegdlu .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#qpjozegdlu .gt_row_group_first td {
  border-top-width: 2px;
}

#qpjozegdlu .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qpjozegdlu .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#qpjozegdlu .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#qpjozegdlu .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qpjozegdlu .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#qpjozegdlu .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#qpjozegdlu .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#qpjozegdlu .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#qpjozegdlu .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qpjozegdlu .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qpjozegdlu .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#qpjozegdlu .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#qpjozegdlu .gt_left {
  text-align: left;
}

#qpjozegdlu .gt_center {
  text-align: center;
}

#qpjozegdlu .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#qpjozegdlu .gt_font_normal {
  font-weight: normal;
}

#qpjozegdlu .gt_font_bold {
  font-weight: bold;
}

#qpjozegdlu .gt_font_italic {
  font-style: italic;
}

#qpjozegdlu .gt_super {
  font-size: 65%;
}

#qpjozegdlu .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#qpjozegdlu .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#qpjozegdlu .gt_indent_1 {
  text-indent: 5px;
}

#qpjozegdlu .gt_indent_2 {
  text-indent: 10px;
}

#qpjozegdlu .gt_indent_3 {
  text-indent: 15px;
}

#qpjozegdlu .gt_indent_4 {
  text-indent: 20px;
}

#qpjozegdlu .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col">Player</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">Expected Points</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col">Selected by (%)</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="5" class="gt_group_heading">Starting 11</td>
    </tr>
    <tr class="gt_row_group_first"><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t4.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p98747.png" style="height:30px;"></td>
<td class="gt_row gt_left">Nick Pope</td>
<td class="gt_row gt_right">4.4</td>
<td class="gt_row gt_right">18.1</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t43.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p121145.png" style="height:30px;"></td>
<td class="gt_row gt_left">João Cancelo</td>
<td class="gt_row gt_right">5.8</td>
<td class="gt_row gt_right">51.2</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t6.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p45034.png" style="height:30px;"></td>
<td class="gt_row gt_left">Ivan Perišić</td>
<td class="gt_row gt_right">4.4</td>
<td class="gt_row gt_right">27.7</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t4.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p77794.png" style="height:30px;"></td>
<td class="gt_row gt_left">Kieran Trippier</td>
<td class="gt_row gt_right">4.2</td>
<td class="gt_row gt_right">44.2</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t6.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p445044.png" style="height:30px;"></td>
<td class="gt_row gt_left">Dejan Kulusevski</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">12.7</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t3.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p444145.png" style="height:30px;"></td>
<td class="gt_row gt_left">Gabriel Martinelli Silva</td>
<td class="gt_row gt_right">4.6</td>
<td class="gt_row gt_right">47.9</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t17.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p222531.png" style="height:30px;"></td>
<td class="gt_row gt_left">Morgan Gibbs-White</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">0.5</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t54.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p156689.png" style="height:30px;"></td>
<td class="gt_row gt_left">Andreas Hoelgebaum Pereira</td>
<td class="gt_row gt_right">3.8</td>
<td class="gt_row gt_right">26.2</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t4.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p219168.png" style="height:30px;"></td>
<td class="gt_row gt_left">Alexander Isak</td>
<td class="gt_row gt_right">4.5</td>
<td class="gt_row gt_right">7.8</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t43.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p223094.png" style="height:30px;"></td>
<td class="gt_row gt_left">Erling Haaland</td>
<td class="gt_row gt_right">12.0</td>
<td class="gt_row gt_right">80.7</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t3.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p205651.png" style="height:30px;"></td>
<td class="gt_row gt_left">Gabriel Fernando de Jesus</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">72.7</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="5" class="gt_group_heading">Bench</td>
    </tr>
    <tr class="gt_row_group_first"><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t13.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p95463.png" style="height:30px;"></td>
<td class="gt_row gt_left">Danny Ward</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">26.0</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t43.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p58621.png" style="height:30px;"></td>
<td class="gt_row gt_left">Kyle Walker</td>
<td class="gt_row gt_right">3.0</td>
<td class="gt_row gt_right">8.3</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t14.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p118748.png" style="height:30px;"></td>
<td class="gt_row gt_left">Mohamed Salah</td>
<td class="gt_row gt_right">7.0</td>
<td class="gt_row gt_right">35.9</td></tr>
    <tr><td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/badges/70/t36.png" style="height:30px;"></td>
<td class="gt_row gt_left"><img src="https://resources.premierleague.com/premierleague/photos/players/110x140/p204214.png" style="height:30px;"></td>
<td class="gt_row gt_left">Pervis Estupiñán</td>
<td class="gt_row gt_right">2.0</td>
<td class="gt_row gt_right">0.6</td></tr>
  </tbody>
  
  
</table>
</div>

Another bit of functionality is plotting minileague point over time,
using `get_league_entries()` information:

<img src="man/figures/README-point_plot-1.png" width="100%" />

Or by rank for each gameweek:

<img src="man/figures/README-ranked_plot-1.png" width="100%" />
