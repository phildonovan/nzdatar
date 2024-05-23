.onLoad <- function(libname, pkgname) {
  check_nzdatar_path()
}

check_nzdatar_path <- function() {
  if (Sys.getenv("NZDATAR_LIBRARY_PATH") == "") {
    paste(
      "NZDATAR_LIBRARY_PATH is not set. Please use",
      "set_data_library_path(\"/path/to/your/data_library\") to add it to your",
      ".Renviron file and restart R.") |>
      str_wrap() |>
      warn()
  } else {
    options(nzdatar_library_path = Sys.getenv("NZDATAR_LIBRARY_PATH"))
  }
}
