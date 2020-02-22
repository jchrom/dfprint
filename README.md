
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dfprint

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

The goal of `dfprint` is to provide a nicer print method for data
frames, inspired by tibbles.

## Installation

You can install `dfprint` from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("jchrom/dfprint")
```

## How does it print

`dfprint` includes text formatting, additional information such as
type/class of variables, robust printing of list columns, better use of
screen-estate, and better handling of some exotic phenomena such as list
columns with symbol elements or 2-d columns.

``` r
library(dfprint)
#> Registered S3 method overwritten by 'dfprint':
#>   method           from
#>   print.data.frame base
```

The readme files on GitHub do not seem to support ANSI formatting, so
you better be viewing this page on the package website.

``` r
set.seed(1)
iris2 = iris[sample.int(nrow(iris), nrow(iris)), ]
iris2
```

<PRE class="fansi fansi-output"><CODE>#&gt; <span style='color: #949494;'># data.frame 150 rows, 5 columns (7.7 Kb)</span><span> 
#&gt; </span><span style='color: #949494;font-style: italic;'>   </span><span> </span><span style='font-weight: bold;'>Sepal.Length</span><span> </span><span style='font-weight: bold;'>Sepal.Width</span><span> </span><span style='font-weight: bold;'>Petal.Length</span><span> </span><span style='font-weight: bold;'>Petal.Width</span><span> </span><span style='font-weight: bold;'>     Species</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'>   </span><span> </span><span style='color: #949494;font-style: italic;'>         dbl</span><span> </span><span style='color: #949494;font-style: italic;'>        dbl</span><span> </span><span style='color: #949494;font-style: italic;'>         dbl</span><span> </span><span style='color: #949494;font-style: italic;'>        dbl</span><span> </span><span style='color: #949494;font-style: italic;'>      factor</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 68</span><span>          5.8         2.7          4.1         1.0 versicolor</span><span style='color: #949494;'>|2</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'>129</span><span>          6.4         2.8          5.6         2.1  virginica</span><span style='color: #949494;'>|3</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 43</span><span>          4.4         3.2          1.3         0.2     setosa</span><span style='color: #949494;'>|1</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 14</span><span>          4.3         3.0          1.1         0.1     setosa</span><span style='color: #949494;'>|1</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 51</span><span>          7.0         3.2          4.7         1.4 versicolor</span><span style='color: #949494;'>|2</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 85</span><span>          5.4         3.0          4.5         1.5 versicolor</span><span style='color: #949494;'>|2</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 21</span><span>          5.4         3.4          1.7         0.2     setosa</span><span style='color: #949494;'>|1</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'>106</span><span>          7.6         3.0          6.6         2.1  virginica</span><span style='color: #949494;'>|3</span><span>
#&gt; </span><span style='color: #949494;font-style: italic;'> 74</span><span>          6.1         2.8          4.7         1.2 versicolor</span><span style='color: #949494;'>|2</span><span>
#&gt; </span><span style='color: #949494;'># showing 9 rows out of 150</span><span>
</span></CODE></PRE>

See `vignette("print-data-frames")` for more examples and additional
info.

## Dependencies

Only what comes with base R. If your terminal does not fully support
ANSI strings, use `options()` to disable offending features, eg.
`options(dfprint_strong = FALSE)`.
