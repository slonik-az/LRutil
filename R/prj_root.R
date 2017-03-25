
#' Find the project root
#'
#' @param dir where to start the search.
#' @param marker name of the project root marker file.
#'
#' @return project root or NULL if failed
#' @export
#'
#' @examples
LR.prj_root <- function(dir= getwd(), marker='.PRJ_ROOT')
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
LR.prj_dirs <- function(prj_root=NULL, marker='.PRJ_ROOT')
{
    if (is.null(prj_root)) prj_root <- LR.prj_root(marker=marker)

    mkfn <- function(subdir) {
        dir <- file.path(prj_root, subdir)
        return (function(filename=NULL) {
            if (is.null(filename)) {
                return (dir)
            } else {
                return (file.path(dir, filename))
            }
        })
    }

    dirs <- list(
        prj_root= prj_root,
        ana     = mkfn('src/ana'),
        dat     = mkfn('dat'),
        dat_raw = mkfn('dat/raw'),
        doc     = mkfn('doc'),
        lib     = mkfn('src/lib'),
        mng     = mkfn('src/mng'),
        rpt     = mkfn('src/rpt'),
        src     = mkfn('src')
                  )
    return (dirs)
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=2:
