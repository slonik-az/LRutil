
#' Return (scalar or vector) TRUE if elements of its arg are NA or FALSE
#'
#' @param x R object (scalar or vector)
#'
#' @return R object (scalar or vector)
#'
#' @examples
#' @export
is.naf <- function(x) # NA or FALSE
{
    is.na(x) | (x==FALSE)
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4: