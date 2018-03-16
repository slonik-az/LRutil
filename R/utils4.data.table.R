#|> Utilities and Convenience functions for data.table

#' Conveniently set column names of a \verb{data.table}.
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

#' Apply convertion functions to multiple columns of a \verb{data.table} in place.
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

#' \verb{data.table::fread} variant that reads compressed files.
#'
#' Convenience wrapper around \code{\link[data.table]{fread}} that automatically deals with compressed
#' files. Currently supported are gzip and bzip2 compressions.
#'
#' @param file  path to a CVS file. If it has extensions \code{.gz} or \code{.bz2} (case-insensitive)
#'              decompress on a fly.
#' @param ...   other \code{\link[data.table]{fread}} parameters.
#'
#' @return  \code{data.table} instance.
#'
#' @examples
#' \dontrun{
#' dtb <- fread.dtb('foo.bz2', colClasses='character')
#' }
#'
#' @export
fread.dtb <- function(file, ...)
{
    input <-  if(grepl('\\.gz$', file, ignore.case=TRUE)) {
            paste0("zcat '",file,"'")
        } else if(grepl('\\.bz2$', file, ignore.case=TRUE)) {
            paste0("bzcat '",file,"'")
        } else {
            file
        }
    args_ <- c(list(input=input),list(...))
    #return (args_)
    return (do.call(data.table::fread, args_))
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4:
