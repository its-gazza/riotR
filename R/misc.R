paste_url <- function(end_point, region) {
  base_url <- ""
}

# Glue URL
glue_url = function(url, api, dry_run = FALSE) {
  url <- httr::modify_url(
    url = glue(url),
    query = list(api_key = api)
  ) %>%
    stringr::str_replace_all(" ", "+")

  if (dry_run) {
    return(url)
  } else {
    httr::GET(url) %>%
      return()
  }
}

route_tft <- function(region) {
  region <- tolower(region)
  if (str_detect(region, "(oc)|(na)|(br)|(lan)|(las)")) {
    output <- "americas"
  } else if (str_detect(region, "(kr)|(jp)")) {
    output <- "asia"
  } else if (str_detect(region, "(eu)|(tr)|(ru)")) {
    output <- "europe"
  } else {
    stop(glue::glue("{region} not defined"))
  }

  return(output)
}
