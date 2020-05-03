
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dfprint

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of `dfprint` is to provide a nicer print method for data
frames.

## Installation

Get `dfprint` from [GitHub](https://github.com/):

``` r
# install.packages("remotes")
remotes::install_github("jchrom/dfprint")
```

## How it prints

`dfprint` includes text formatting, additional information such as
type/class of variables, robust printing of list columns, better use of
screen-estate, and better handling of some exotic phenomena such as list
columns with symbol elements or 2-d columns.

Chck out `vignette("print-data-frames")` to see how it prints (and why).

## Dependencies

Only what comes with base R. If your terminal does not fully support
ANSI strings, you may want to use `options()` to disable offending
features, eg. `options(dfprint_strong = FALSE)`.
