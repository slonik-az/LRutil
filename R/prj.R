#|> My favorite R project directory layout

prj_dirs <- matrix(c(
    '',        'root',  # this line must be the first!
    'bin',     'bin',
    'dat',     'dat',
    'dat/raw', 'dat_raw',
    'doc',     'doc',
    'doc/rpt', 'rpt',
    'lib',     'lib',
    'lib/R',   'lib_R',
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
#' @param dir where to start the search if a string. If \code{NULL} or \code{FALSE} then start at the
#'   current working directory (getwd()). If \code{TRUE} (should only be used in scripts that are
#'   sourced/executed) then try directory of the file being sourced, otherwise current working directory.
#' @param marker name of the project root marker file.
#'
#' @return project root or \code{NULL} if failed
#' @export
#'
#' @examples
LR.prj_root <- function(dir=NULL, marker='.PRJ_ROOT')
{
    dir <-     if (is.character(dir))   { dir
        } else if (isTRUE(dir) && sys.nframe()>0) {# recurse & return
            l <- sys.frame(1L)
            f <- if(!is.null(f<-l$filename) || !is.null(f<-l$ofile)) f else NULL
            return (if(!is.null(f)) LR.prj_root(dir=dirname(f), marker=marker)
                    else LR.prj_root(dir=getwd(), marker=marker))
        } else { getwd() }
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
#'   \item{lib}{        - Local Library   (lib)}
#'   \item{lib_R}{      - Local R Library (lib/R)}
#'   \item{mng}{        - Data Munging/Wrangling (src/mng)}
#'   \item{rpt}{        - Reports (doc/rpt)}
#'   \item{src}{        - Source tree (src)}
#'   \item{src_lib}{    - Common code under Source tree (src/lib)}
#'   \item{pkg}{        - In case some code is made into R-packages (pkg)}
#'
#' @param prj_root  Project Root directory if string.
#'   if \code{NULL} or \code{FALSE} -- auto-discover from current working directory \code{getwd()}.
#'   if \code{TRUE} -- (only use in scripts, never directly in console!)
#'     auto-discover from the path of the script being executed or sourced, otherwise \code{getwd()}.
#' @param marker  Project root marker file. Must exist in the project root directory.
#'
#' @examples
#' \dontrun{
#' if(!exists('prj')){ prj <- LRutil::LR.prj_path() }
#' prj$root()  # return prj_root
#' prj$root('readme') # returns path to prj_root/readme
#' prj$dat_raw('foo.csv') #returns path to prj_root/dat/raw/foo.csv
#' prj$src('subdir','test','t.R') #returns path to prj_root/src/subdir/test/t.R
#' prj$src(c('a.R','b.R')) #returns vector c('prj_root/src/a.R','prj_root/src/b.R')
#' }
#' @export
LR.prj_path <- function(prj_root=NULL, marker='.PRJ_ROOT')
{
    if (!is.character(prj_root)) {# discover root if prj_root is NULL or TRUE
        prj_root <- LR.prj_root(dir=prj_root, marker=marker)
    }
    mkfn <- function(subdir='') {
        pfx <- if(subdir==''){prj_root}else{file.path(prj_root,subdir)}
        return (function(...) { file.path(pfx, ...) })
    }
    res <- lapply(prj_dirs[1,], mkfn)
    names(res) <- prj_dirs[2,]
    return (res)

}

#' Create standard project skeleton sub-directores
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
LR.prj_skeleton <- function(root='.', marker='.PRJ_ROOT', mode='0750')
{
    dirs     <- file.path(root, prj_dirs[1,])
    keep_fls <- file.path(dirs[-1],'.keep')
    sapply(dirs, dir.create, showWarnings=FALSE,recursive=TRUE,mode=mode)
    file.create(file.path(root, marker))
    file.create(keep_fls, showWarnings=FALSE)
    Sys.chmod(keep_fls, mode='0640', use_umask=TRUE)
}

#z <- LR.prj_path(prj_root=TRUE)

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=2:
