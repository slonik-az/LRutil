
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


#' \code{setnames.dtb}
#'
#' Convenience wrapper around \code{\link[data.table]{setnames}} function.
#'
#' @param dtb -- \code{data.table} object
#' @param rename.map -- named array of the form \code{c('new1=old1',...)}
#'
#' @return The input is modified by reference, and returned (invisibly)
#' so it can be used in compound statements.
#' @export
#'
#' @examples
setnames.dtb <- function(dtb, rename.map)
{
    data.table::setnames(dtb, old=unname(rename.map), new=names(rename.map))
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4: