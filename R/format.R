# rename = function(x, prefix) {
#   if (is.null(colnames(x))) paste0(prefix, "[, ", 1:ncol(x), "]")
#   else paste0(prefix, "$", colnames(x))
# }

format_vec = function(x, ...) {
  UseMethod("format_vec")
}

format_vec.default = function(x, name, ...) {

  abbrev = object_abbr(x)

  out = rform(
    obj  = format(x),
    name = name,
    abbr = abbrev
  )

  w = nchar(out[[1]])

  structure(out, width = w, trimmed = 0, na = is.na(x), abbr = abbrev)
}

format_vec.POSIXt = function(x, name, ...) {

  out = rform(
    obj  = format(x),
    name = name,
    abbr = object_sum(x)
  )

  w = nchar(out[[1]])

  structure(out, width = w, trimmed = 0, na = is.na(x), abbr = object_abbr(x))
}

format_vec.character = function(x, name, min_width = 8L, ...) {

  out = lform(
    obj  = format(x),
    name = name,
    abbr = "chr"
  )

  w = nchar(out[[1]])
  p = pmax(min_width, max(nchar(c(name, "chr"))))

  structure(out, width = p, trimmed = pmax(0, w - p), na = is.na(x),
            abbr = "chr")
}

format_vec.factor = function(x, name, ...) {

  levels = format(ifelse(is.na(x), "NA", paste0("|", as.integer(x))))
  labels = ifelse(is.na(x), "", as.character(x))

  out = rform(
    obj  = paste0(labels, levels),
    name = name,
    abbr = "factor"
  )

  w = nchar(out[[1]])

  structure(out, width = w, trimmed = 0, na = is.na(x), abbr = "factor")
}

format_vec.numeric = function(x, name) {

  abbrev = object_abbr(x)

  out = rform(
    obj  = format(x, digits = 2, nsmall = 0),
    name = name,
    abbr = abbrev
  )

  w = nchar(out[[1]])

  structure(out, width = w, trimmed = 0, na = is.na(x), abbr = abbrev)
}

format_vec.list = function(x, name) {

  out = rform(
    obj  = sprintf("[%s]", vapply(x, object_sum, "", default_fn = length)),
    name = name,
    abbr = "lst"
  )

  w = nchar(out[[1]])

  structure(out, width = w, trimmed = 0, na = is.na(x), abbr = "lst")
}

lform = function(obj, name, abbr) {
  format(c(name, abbr, obj), justify = "left")
}

rform = function(obj, name, abbr) {
  format(c(name, abbr, obj), justify = "right")
}
