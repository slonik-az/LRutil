#|> My favorite R project directory layout

#' @importFrom stringr  str_replace_all

prj_dirs <- matrix(c(
    '',        'root',
    'bin',     'bin',
    'dat',     'dat',
    'dat/raw', 'dat_raw',
    'doc',     'doc',
    'doc/rpt', 'rpt',
    'lib',     'lib',
    'src',     'src',
    'src/ana', 'ana',
    'src/lib', 'src_lib',
    'src/mng', 'mng',
    'pkg',     'pkg'
), nrow=2)

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

#' Discover standard LR project directory hierarchy.
#'
#' Discover standard LR project directory hierarchy.
#' prj_root marker file (.PRJ_ROOT by default) must exist in the project root directory.
#'
#' @return List of essential project subdirs as functions that when called with
#'   a filename produce the correspinding path; when called without a filename
#'   return the path to the subdir itself; see Examples for details.
#'   \item{root}{       - project root}
#'   \item{ana}{        - Data Analysis (src/ana)}
#'   \item{dat}{        - Data directory (dat)}
#'   \item{dat_raw}{    - Raw data directory (dat/raw)}
#'   \item{doc}{        - Documentation directory (doc)}
#'   \item{lib}{        - Library code (src/lib)}
#'   \item{mng}{        - Data Munging/Wrangling (src/mng)}
#'   \item{rpt}{        - Reports (doc/rpt)}
#'   \item{src}{        - Source tree (src)}
#'   \item{pkg}{        - In case some code is made into R-packages (pkg)}
#'
#' @examples
#' \dontrun{
#' prj_path <- LR.prj_path()
#' prj_path$root()  # return prj_root
#' prj_path$root('readme') # returns path to prj_root/readme
#' prj_path$dat_raw('foo.csv') #returns path to prj_root/dat/raw/foo.csv
#' }
#'
#' @param prj_root Project Root dir. Auto-discover if NULL
#' @param marker Project root marker file. Must exist in the project root directory.
#' @export
LR.prj_path <- function(prj_root=NULL, marker='.PRJ_ROOT')
{
    if (is.null(prj_root)) prj_root <- LR.prj_root(marker=marker)
    mkfn <- function(subdir='') {
        dir <- if(subdir==''){prj_root}else{file.path(prj_root,subdir)}
        return (function(filename=NULL) {
            if(is.null(filename)){dir}else{file.path(dir,filename)}
        })
    }
    res <- lapply(prj_dirs[1,], mkfn)
    names(res) <- prj_dirs[2,]
    return (res)

#     dirs <- list(
#         root    = mkfn(),
#         ana     = mkfn('src/ana'),
#         dat     = mkfn('dat'),
#         dat_raw = mkfn('dat/raw'),
#         doc     = mkfn('doc'),
#         lib     = mkfn('src/lib'),
#         mng     = mkfn('src/mng'),
#         rpt     = mkfn('src/rpt'),
#         src     = mkfn('src')
#                   )
#     return (dirs)
}

#' LR.prj_skeleton(.) create standard project skeleton sub-directores
#'
#' For project directory structure see \code{\link{LR.prj_path}}.
#'
#' @param root project root
#' @param marker project root marker
#' @param mode mode for the directories
#'
#' @return nothing
#'
#' @examples
#' @export
LR.prj_skeleton <- function(root='.', marker='.PRJ_ROOT', mode='0755')
{
    sapply(file.path(root, prj_dirs[1,]), dir.create,
            showWarnings=FALSE,recursive=TRUE,mode=mode)
    file.create(file.path(root, marker))
}


####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=2:
