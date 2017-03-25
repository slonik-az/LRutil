
#' Find the project root
#'
#' prj_root marker file (.PRJ_ROOT by default) must exist in the project root directory.
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
#' prj_root marker file (.PRJ_ROOT by default) must exist in the project root directory. \cr
#' Returns a list of functions that when called will resolve to the following directories:
#' \itemize{
#'   \item ana        - Data Analysis (src/ana)
#'   \item dat        - Data directory (dat/)
#'   \item dat_raw    - Raw data directory (dat/raw)
#'   \item lib        - Library code (src/lib)
#'   \item mng        - Data Munging/Wrangling (src/mng)
#'   \item rpt        - Reports (src/rpt)
#'   \item src        - Source tree (src)
#' }
#'
#' @return List of essential project subdirs as functions that when called with
#'   a filename produce the correspinding path; when called without a filename
#'   return the path to the subdir itself; see Examples for details.
#'
#' @examples
#' \dontrun{
#' prj_dirs <- LR.prj_dirs()
#' prj_dirs$root()  # return prj_root
#' prj_dirs$root('readme') # returns path to prj_root/readme
#' prj_dirs$dat_raw('foo.csv') #returns path to prj_root/dat/raw/foo.csv
#' }
#'
#' @param prj_root Project Root dir. Auto-discover if NULL
#' @param marker Project root marker.
#' @export
LR.prj_dirs <- function(prj_root=NULL, marker='.PRJ_ROOT')
{
    if (is.null(prj_root)) prj_root <- LR.prj_root(marker=marker)

    mkfn <- function(subdir=NULL) {
        dir <- if(is.null(subdir)){prj_root}else{file.path(prj_root,subdir)}
        function(filename=NULL) {
            if(is.null(filename)){dir}else{file.path(dir,filename)}
        }
    }

    dirs <- list(
        root    = mkfn(),
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
