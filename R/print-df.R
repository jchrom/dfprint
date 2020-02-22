#' Printing Data Frames
#'
#' This method overloads `base::print.data.frame()` to provide a nicer print
#' method for data frames.
#'
#' # Options
#'
#' You can disable selected features or revert back to base R method via options.
#' This is important because some editors may not support certain ANSI features
#' such as bold font. At the moment, the print method only uses 3 types of ANSI
#' formatting:
#'
#' * use `options(dfprint_strong = FALSE)` to disable bold font, used in variable
#'   names
#'
#' * use `options(dfprint_italic = FALSE)` to disable italic, used for character
#'   vector elements and column summaries
#'
#' * use `options(dfprint_subtle = FALSE)` to disable the grey font, used for
#'   list columns, row names, missing and NULL values, factor orderings,
#'   and column summaries
#'
#' To revert back to base R print method, use `options(dfprint_enable = FALSE)`.
#' This may be useful if detaching the package is for some reason not desirable.
#'
#' # How it prints
#'
#' See `vignette("print-data-frames")`.
#'
#' @param df Data frame.
#' @param n_extra How many extra columns to print. These are the columns that
#'   did not fit the console width, so only their names and type/class
#'   are printed in the footer. Defaults to 20.
#' @param n How many rows to print. Defaults to 9.
#' @param ... Additional arguments. Currently ignored, unless you revert back
#'   to base R printing via options (see details).
#'
#' @return df, invisibly
#' @export
#'
#' @examples
#' iris
print.data.frame = function(df, n_extra = 20, n = 9, ...) {

  if (!getOption("dfprint_enable")) {
    return(base::print.data.frame(df, ...))
  }

  stopifnot(is.numeric(n_extra))
  stopifnot(is.numeric(n))

  n = pmin(nrow(df), n)

  print_header(df)

  if (!nrow(df)) {
    print_cols(df, start_from = 1, n_extra = n_extra)
    return(invisible(df))
  }

  row_names = format(
    c("", "", rownames(df)[seq_len(n)]),
    justify = "right"
  )

  row_names_width = nchar(row_names[1])

  df_trunc = format_trunc(
    utils::head(df, n),
    offset = row_names_width
  )

  print_trunc(df_trunc, row_names)

  print_footer(df, n = n)

  print_cols(
    df,
    start_from = length(df_trunc) + 1,
    n_extra = n_extra
  )

  invisible(df)
}

plural = function(x) ifelse(x == abs(1), "", "s")

print_header = function(x) {

  s = utils::object.size(x)
  u = c("B", "KB", "MB", "GB", "TB")[s < 1024^(1:5)][1]

  nr = nrow(x)
  nc = ncol(x)

  header = sprintf("# data.frame %1$d row%2$s, %3$d column%4$s (%5$s)",
                   nr, plural(nr), nc, plural(nc),
                   format(s, units = u))

  cat(if (has_color())
    format_subtle(header) else header, "\n")
}

print_footer = function(df, n) {

  if (nrow(df) - n < 1) return()

  footer_text = paste0("# showing ", n, " rows out of ", nrow(df))

  cat(
    if (has_color()) format_subtle(footer_text)
    else footer_text,
    sep = "\n")
}
