fn <- function(x, dig = 0, p = FALSE, pequalsign = FALSE, ...) {
  out <- formatC(x,
    format = "f", digits = dig, big.mark = ",",
    ...
  )
  if (p) {
    out <- replace(out, out == paste0("0.", paste0(rep(
      0,
      dig
    ), collapse = "")), paste0("<0.", paste0(rep(
      0,
      max(dig - 1, 0)
    ), collapse = ""), "1"))
    if (pequalsign) {
      out <- dplyr::if_else(stringr::str_detect(out, "<",
        negate = TRUE
      ), paste0("=", out), out)
    }
  }
  return(out)
}
