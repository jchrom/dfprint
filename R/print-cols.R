# Print Column Names
#
# Print column names in the footer.
#
# @param x Data frame.
# @param start_from Which column to start from.
# @param n_extra How many column names to print in full.

print_cols = function(x, start_from = 1, n_extra = 20) {

  if (ncol(x) == 0) return(invisible(x))

  cols = unlist(format_cols(x), use.names = FALSE)
  cols = cols[seq_len(length(cols)) >= start_from]

  if (!length(cols)) return()

  additional = if (start_from > 1) " additional"

  if (length(cols) > n_extra) {
    plus_more = paste0("+", length(cols) - n_extra, " more")
  } else {
    plus_more = NULL
  }

  text = paste0("# ", length(cols), additional, " column", plural(length(cols)),
                ":")

  if (n_extra > 0) {

    if (has_color()) {
      cols = subtle_gsub(cols, "(\\(.+\\)$)")
      text = format_subtle(text)
    }

    lines = paste(c(text, cols[seq(n_extra)], plus_more), collapse = " ")

  } else {

    lines = paste(c(text, plus_more), collapse = " ")

  }

  cat(lines, sep = "")

}

format_cols = function(x) {

  mapply(x, names(x), SIMPLIFY = FALSE, FUN = function(x, name) {

    if (length(dim(x)) < 2)
      return(sprintf("%s (%s)", name, object_abbr(x)))

    df = stats::setNames(
      object = as.data.frame(x, stringsAsFactors = FALSE),
      nm = nested_colnames(x, prefix = name))

    format_cols(df)
  })
}

nested_colnames = function(x, prefix) {

  if (is.matrix(x) && is.null(colnames(x)))
    sprintf('%s[,%s]', prefix, seq_len(ncol(x)))

  else if (is.matrix(x))
    sprintf('%s[,"%s"]', prefix, colnames(x))

  else
    sprintf("%s$%s", prefix, colnames(x))
}
