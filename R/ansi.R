# Check Terminal Supports ANSI Formatting. Borrowed from `crayon::has_color()`.
has_color = function() {

  # if (!isatty(stdout())) return(FALSE)

  if (.Platform$OS.type == "windows") {
    if (Sys.getenv("ConEmuANSI") == "ON") return(TRUE)
    if (Sys.getenv("CMDER_ROOT") != "")   return(TRUE)
    return(FALSE)
  }

  if ("COLORTERM" %in% names(Sys.getenv())) return(TRUE)

  grepl("^screen|^xterm|^vt100|color|ansi|cygwin|linux", Sys.getenv("TERM"),
        ignore.case = TRUE, perl = TRUE)
}

apply_style = function(x, style) {
  paste0(style[1], unlist(x, use.names = FALSE), style[2])
}

subtle_gsub = function(x, pattern) {
  gsub(pattern, format_subtle("\\1"), x, perl = TRUE)
}

format_subtle = function(x) {

  if (!getOption("dfprint_subtle")) {
    return(x)
  }

  apply_style(x, style = c("\033[38;5;246m", "\033[39m"))
}

format_italic = function(x) {

  if (!getOption("dfprint_italic")) {
    return(x)
  }

  apply_style(x, style = c("\033[3m", "\033[23m"))
}

format_strong = function(x) {

  if (!getOption("dfprint_strong")) {
    return(x)
  }

  apply_style(x, style = c("\033[1m", "\033[22m"))
}
