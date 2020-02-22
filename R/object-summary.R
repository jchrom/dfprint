# Object summary

object_sum = function(obj, sep = ", ", ...) {

  if (is.null(object_attr(obj, ...))) {
    return(object_abbr(obj))
  }

  paste(object_abbr(obj), object_attr(obj, ...), sep = sep)
}

# @return Abbreviated object type/class.
object_abbr = function(obj) {

  if (length(dim(obj))) {

    abbrev = c(data.frame = "df", matrix = "mat", array = "arr")

    for (cls in c("data.frame", "matrix", "array"))
      if (inherits(obj, cls)) return(abbrev[cls])
  }

  if (is.object(obj)) {
    for (cls in c("Date", "POSIXct", "POSIXlt", "difftime", "factor"))
      if (inherits(obj, cls)) return(cls)
  }

  if (is.language(obj)) {
    for (cls in c("call", "formula", "expression", "symbol"))
      if (inherits(obj, cls)) return(cls)
  }

  if (is.null(obj)) {
    return("")
  }

  switch(typeof(obj), logical = "lgl", integer = "int", double = "dbl",
         complex = "cplx", character = "chr", raw = "raw", list = "lst",
         closure = "function", environment = "env", typeof(obj))
}

# @return Where appropriate: dims, timezone, number of levels, length.
object_attr = function(obj, default_fn = function(x) NULL) {

  if (length(dim(obj))) {
    return(paste(dim(obj), collapse = "x"))
  }

  if (inherits(obj, "POSIXt")) {
    return(format(obj, "%Z")[1])
  }

  if (is.factor(obj)) {
    # Not used at the moment - what if there are too many levels?
    return(paste(length(levels(obj)), "lvl"))
  }

  if (is.language(obj) || is.function(obj) || is.null(obj)) {
    return()
  }

  default_fn(obj)
}
