## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------------------------------------------
### Project local '.Rprofile'. Lives in '.PRJ_ROOT':
if (file.exists('~/.Rprofile')) { # read user's ~/.Rprofile
    source('~/.Rprofile')
}
### library containing locally installed packages:
.libPaths('lib/R')

