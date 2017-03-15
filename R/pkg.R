#|> Package utilities


#' LR_installed_packages
#'
#' @return data.table
#'
#' @examples
#' @export
LR_installed_packages <- function()
{
    return (data.table::as.data.table(installed.packages()))
}

####################################################
## vim:tw=105:ft=R:spell:fdm=indent:fdl=0:fdi=:sw=4:
