#' Set the Data Library Path for nzdatar
#'
#' This function sets the `NZDATAR_LIBRARY_PATH` in the user's `.Renviron` file,
#' making it persistent across R sessions. If the `.Renviron` file does not exist,
#' it will be created. Use this function to configure the path to your data library
#' before using the nzdatar package functionalities.
#'
#' @param path The file path to the data library that you want to set.
#' @return Invisible NULL. The function is used for its side effect of writing to the `.Renviron`.
#' @examples
#' \dontrun{
#' set_data_library_path("/path/to/your/data_library")
#' }
#' @export
set_data_library_path <- function(path) {
  # Define the .Renviron file path
  renviron_path <- file.path(Sys.getenv("HOME"), ".Renviron")

  # Read the current .Renviron, if it exists
  if (file.exists(renviron_path)) {
    env_content <- readLines(renviron_path)
  } else {
    env_content <- character(0)
  }

  # Define the new line to add or replace
  new_line <- paste0("NZDATAR_LIBRARY_PATH=", path)

  # Remove any existing NZDATAR_LIBRARY_PATH lines
  env_content <- env_content[!grepl("^NZDATAR_LIBRARY_PATH", env_content)]

  # Add the new line
  env_content <- c(env_content, new_line)

  # Write back to the .Renviron file
  writeLines(env_content, renviron_path)

  # Inform the user
  message("NZDATAR_LIBRARY_PATH has been set to '", path, "' in your .Renviron. Please restart R for this change to take effect.")

  invisible(NULL)
}



#' Retrieve the Data Library Path for nzdatar
#'
#' This function retrieves the `NZDATAR_LIBRARY_PATH` set in the current R session's options,
#' which should have been initialized from the user's `.Renviron` file upon the start of the session.
#' It is essential that the path is set before using any functionalities that rely on this setting.
#'
#' @return A character string representing the path to the data library.
#' If the path has not been set, this function will stop and prompt the user to set it.
#' @examples
#' \dontrun{
#' library_path <- get_data_library_path()
#' }
#' @export
get_data_library_path <- function() {
  library_path <- getOption("nzdatar_library_path")
  if (is.null(library_path)) {
    stop("NZDATAR_LIBRARY_PATH is not set. Please set it using set_data_library_path() or check your .Renviron.")
  }
  return(library_path)
}
