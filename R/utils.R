
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

#' \code{convert_cols.dtb}
#'
#' Convenience function to convert \code{\link{data.table}} columns in place
#'
#'
#' @param dtb - \code{\link{data.table}} instance
#' @param ... - one or more lists of the form \code{list(c('col1','col2'), cvt_fn, optional_args...)}
#'   where \code{cvt_fn} is the conversion function that takes a column as its 1st argument
#'   and additional args can be supplied via \code{optional_args}
#'
#' @return modified in place \code{dtb} is returned.
#' @export
#'
#' @examples
convert_cols.dtb <- function(dtb, ...)
{ # mutate by reference
    cvt_lists <- list(...)
    for (cvtl in cvt_lists) { # e.g: cvtl = list(c('col1','col2'), cvt_fn, optional_args)
        cols <- cvtl[[1]]
        cvtf <- cvtl[-1] # convert function and its optional extra arguments list(cvt_fn,...)
        dtb[, (cols) := do.call(lapply, c(list(.SD),cvtf)), .SDcols=(cols)]
    }
    return(dtb)
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