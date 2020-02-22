require(httr)


get_data <- function(URL, api) {
  GET(URL, query = list(api_key = api))
}
