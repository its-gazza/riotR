# Glue URL
glue_url = function(url, api) {
  url <- httr::modify_url(
    url = glue(url),
    query = list(api_key = api)
  )

  httr::GET(url) %>%
    return()
}
