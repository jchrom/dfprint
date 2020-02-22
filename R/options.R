.onLoad <- function(libname, pkgname) {

  op = options()

  op_dfprint = list(
    dfprint_enable = TRUE,
    dfprint_italic = TRUE,
    dfprint_subtle = TRUE,
    dfprint_strong = TRUE
  )

  toset = !(names(op_dfprint) %in% names(op))

  if(any(toset)) options(op_dfprint[toset])

  invisible()
}
