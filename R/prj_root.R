
#' Find the project root
#'
#' @param dir where to start the search.
#' @param marker name of the project root marker file.
#'
#' @return project root or NULL if failed
#' @export
#'
#' @examples
LR_get.prj_root <- function(dir= getwd(), marker='.PRJ_ROOT')
{
    dir_parts <- unlist(strsplit(dir, split='/', fixed=TRUE))
    for(i in length(dir_parts):1) {
        d <- do.call(file.path, as.list(dir_parts[1:i]))
        f <- file.path(d,marker)
        #print(f)
        if (file.exists(f)) return (d)
    }
    return (NULL)
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=2:
