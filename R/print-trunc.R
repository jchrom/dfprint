print_trunc = function(df_trunc, row_names) {

  if (has_color()) {
    row_names = format_italic(format_subtle(row_names))
    df_trunc  = format_ansi(df_trunc)
  }

  out = c(row_names, unlist(df_trunc, use.names = FALSE))

  mat = matrix(
    out,
    nrow = length(row_names),
    ncol = length(df_trunc) + 1,
    byrow = FALSE
  )

  lines = apply(mat, 1, paste, collapse = " ")

  for (line in lines) {
    cat(escape(line), "\n", sep = "")
  }
}

escape = function(x) {

  specials = c("\n", "\r", "\t")
  escapes  = c("\\n", "\\r", "\\t")

  for (i in seq_along(specials)) {
    x = gsub(specials[i], escapes[i], x, fixed = TRUE)
  }

  x
}

format_trunc = function(df, offset = 1) {

  flat_df = flatten(format_df(df), depth = Inf)
  availbl = getOption("width") - offset

  trunc_resize(flat_df, space = availbl)
}

format_ansi = function(df_trunc) {

  lapply(df_trunc, function(x) {

    type = attr(x, "abbr")
    na   = attr(x, "na")
    body = -(1:2)

    x[body] = switch(
      type,
      chr = format_italic(x[body]),
      lst = format_subtle(x[body]),
      factor = subtle_gsub(x[body], "(\\|[0-9]+\\s*?$)"),
      x[body])

    if (any(na)) x[body][na] = format_subtle(x[body][na])

    x[1] = format_strong(x[1])
    x[2] = format_italic(format_subtle(x[2]))

    x
  })
}

# Recursively Format Data Frame Columns
#
# Returns formatted columns with information about width, missing values, type.
# Applies recursively over matrix/data frame columns as well.
#
# @param x data frame
# @return A list of formatted chr vectors.
format_df = function(x) {

  mapply(x, names(x), SIMPLIFY = FALSE, FUN = function(x, name) {

    if (length(dim(x)) < 2) return(format_vec(x, name))

    df = stats::setNames(
      object = as.data.frame(x, stringsAsFactors = FALSE),
      nm = nested_colnames(x, prefix = name))

    format_df(df)
  })
}

# Truncate And Resize
#
# Truncate columns and keep only those that fit; redistribute remaining space.
# @param x a vector of formatted columns
trunc_resize = function(x, space = getOption("width")) {

  w = vapply(x, attr, 0, "width")
  out = x[cumsum(w + 1) < space]

  w = vapply(out, attr, 0, "width")
  p = vapply(out, attr, 0, "trimmed")

  space_left = space - sum(w) - length(w)

  if (any(p > 0)) {
    p = floor((p / sum(p)) * space_left)
    w = w + p
  }

  mapply(str_trim, out, w, SIMPLIFY = FALSE)
}

str_trim = function(x, width) {

  fit = nchar(trimws(x)) <= width

  if (all(fit)) return(x)

  out = strtrim(trimws(x), width)

  if (has_color()) {
    out[!fit] = sub(".$", "\u2026", strtrim(out[!fit], width))
  } else {
    out[!fit] = sub("...$", "...", strtrim(out[!fit], width))
  }

  out[] = format(out, justify = "left") #to keep attributes
  out
}
