#|> Package utilities


#' LR_installed_packages
#'
#' @return All installed packages as a data.table
#'
#' @examples
#' @export
LR.installed_packages <- function()
{
    return (data.table::data.table(installed.packages(fields=
        c('Repository','RemoteType','RemoteRepo','RemoteRef','RemoteHost')),
        stringsAsFactors=TRUE))
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

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4:
