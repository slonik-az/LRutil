#' LRutil: useful utilities by Leo Razoumov
#'
#' This package is a collection of useful utilities and wrappers that helps me in developting of R code.
#'
#' @section Coding conventions:
#'
#' \strong{Naming functions:} \code{fread.dtb} is a simple "free-standing" function.
#' The suffix \code{.dtb} has no special significance.
#' On the other hand \code{foo.Dtb} is a S3-method dispatched to an instance of \code{Dtb} class.
#'
#' \strong{Naming S3 classes:} Start with capital (upper-case) letter like \code{Dtb}, \code{Shadow_price},
#' \code{RBT}, \code{MIMO}.
#'
#' @docType package
#' @name LRutil
NULL
