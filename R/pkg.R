#|> Package utilities


#' Wrapper around \code{\link{install.packages}} to install tests by default.
#'
#' An option \code{"--install-tests"} is automatically prepended to \code{INSTALL_opts}
#' @param pkgs  character vector of the names of packages whose current versions should be downloaded
#'      from the repositories.
#' @param INSTALL_opts  Optional character vector of additional options. \code{"--install-tests"} will be
#'      automatically prepended. For the rest, see \code{\link{install.packages}}.
#' @param ...  The rest of parameters are passed directly to \code{\link{install.packages}}.
#'
#' @return The results of calling \code{\link{install.packages}}.
#'
#' @examples
#' @export
LR.install.packages <- function(pkgs, INSTALL_opts=NULL, ...)
{
    INSTALL_opts <- c("--install-tests", INSTALL_opts)
    install.packages(pkgs, INSTALL_opts=INSTALL_opts, ...)
}

#' LR_installed_packages
#'
#' @return All installed packages as a data.table
#'
#' @examples
#' @export
LR.installed_packages <- function()
{
    dtb <- data.table::data.table(installed.packages(fields=
        c('URL','Repository','RemoteUrl','RemoteType','RemoteUsername','RemoteRepo','RemoteBranch'
          ,'RemoteRef','RemoteHost','RemoteSha')),
        stringsAsFactors=FALSE)
    factor_names <- grep(
        'repo|remot|LibPath|priorit|licens|needsCompil',
        colnames(dtb), ignore.case=TRUE, value=TRUE)
    convert_cols.dtb(dtb, list(factor_names, as.factor))
    return (dtb)
}

# Built: R 3.3.2; x86_64-apple-darwin13.4.0; 2017-01-25 01:48:02 UTC; unix
# RemoteType: github
# RemoteHost: https://api.github.com
# RemoteRepo: roxygen
# RemoteUsername: klutometis
# RemoteRef: master
# RemoteSha: fc1040acb0337a3afd81a060ba5bffe4768140a6
# GithubRepo: roxygen
# GithubUsername: klutometis
# GithubRef: master
# GithubSHA1: fc1040acb0337a3afd81a060ba5bffe4768140a6



#' LR.list_package_dirs  list all the directories of the installed package.
#'
#' @param pkg  package to consider
#' @param lib.loc  a character vector describing the location of R library trees to search through,
#'       or NULL. The default value of NULL corresponds to checking the loaded namespace,
#'       then all libraries currently known in .libPaths().
#'
#' @return  List of directories (recursively)
#' @examples
#'
#' @export
LR.list_package_dirs <- function(pkg, lib.loc=NULL)
{
   list.dirs(find.package(pkg, lib.loc=lib.loc),
             full.names= TRUE,
             recursive = TRUE)

}

#' LR.list_package_files  List all file in an installed package.
#'
#' @param pkg  package to consider
#' @param lib.loc  a character vector describing the location of R library trees to search through,
#'       or NULL. The default value of NULL corresponds to checking the loaded namespace,
#'       then all libraries currently known in .libPaths().
#'
#' @return  List of files
#' @examples
#'
#' @export
LR.list_package_files <- function(pkg, lib.loc=NULL)
{
    list.files(find.package(pkg, lib.loc=lib.loc),
               full.names= TRUE,
               recursive = TRUE,
               all.files = TRUE)
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4:
