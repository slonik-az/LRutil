
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

#' LR.find_file(.)
#'
#' Convenience function finding files by regex pattern.
#'
#' @param dir  directory or array of directories to search in
#' @param pattern  regex matching file name
#' @param index  what to return. \code{"last"} for last found file, \code{"first"} for the first,
#'              \code{"all"} for all found files; numeric index or array of indexes
#'              to subset vector of matching files.
#' @param ignore.case  boolean, whether to ignore the case in regex matching
#' @param recursive  boolean, whether perform recursive search over sub-directories.
#'
#' @return NULL is no match found, otherwise path to found files as prescribed by \code{index} settings.
#' @export
#'
#' @examples
LR.find_file <- function(dir='.', pattern='', index='last', ignore.case=TRUE, recursive=FALSE)
{
    files <- list.files(path=dir, pattern=pattern, all.files=TRUE, full.names=TRUE,
        recursive=recursive, ignore.case=ignore.case)
    return (
        if (length(files)==0) { NULL }
        else if (index=='last' ) { files[length(files)] }
        else if (index=='first') { files[1] }
        else if (index=='all'  ) { files }
        else                     { files[index] }
    )
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4:
