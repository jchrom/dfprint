# TIDYBASE

flatten = function(x, depth = 1, use_names = TRUE) {

  if (!inherits(x, "list") || depth < 0) return(list(x))

  unlist(
    c(lapply(x, flatten, depth = depth - 1, use_names = use_names)),
    recursive = FALSE,
    use.names = use_names
  )
}

ifnull = function(lhs, rhs) {
  if (is.null(lhs)) rhs else lhs
}

iflen = function(lhs, rhs) {
  if (length(lhs)) lhs else rhs
}

ifmiss = function(lhs, rhs)
  if (missing(lhs)) rhs else lhs

ifstop = function(lhs, rhs, f)
  if (f(lhs)) stop(rhs, call. = FALSE) else lhs

ifwarn = function(lhs, rhs, f)
  if (f(lhs)) warning(rhs, call. = FALSE) else lhs
