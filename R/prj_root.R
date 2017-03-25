
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

#' Return list of standard LR project sub-dirs
#'
#' ana        - Data Analysis (src/ana) \cr
#' dat        - Data directory (dat/) \cr
#' dat_raw    - Raw data directory (dat/raw) \cr
#' lib        - Library code (src/lib) \cr
#' mng        - Data Munging/Wrangling (src/mng) \cr
#' rpt        - Reports (src/rpt) \cr
#' src        - Source tree (src)
#'
#' @param prj_root Project Root dir. Discover it if NULL
#' @param marker Project root marker.
#'
#' @return list of LR project subdirs
#'
#' @examples
#' @export
LR_get.prj_dirs <- function(prj_root=NULL, marker='.PRJ_ROOT')
{
    if (is.null(prj_root)) prj_root <- LR_get.prj_root(marker = marker)
    dirs <- list(
        prj_root= prj_root,
        ana     = file.path(prj_root, 'src/ana'),
        dat     = file.path(prj_root, 'dat'),
        dat_raw = file.path(prj_root, 'dat/raw'),
        doc     = file.path(prj_root, 'doc'),
        lib     = file.path(prj_root, 'src/lib'),
        mng     = file.path(prj_root, 'src/mng'),
        rpt     = file.path(prj_root, 'src/rpt'),
        src     = file.path(prj_root, 'src')
                  )
    return (dirs)
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=2:
