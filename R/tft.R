require(R6)

tft_league_master <- "/tft/league/v1/master"
tft_league_grandmaster <- "/tft/league/v1/grandmaster"
tft_league_challenger <- "/tft/league/v1/challenger"
tft_league_by_summoner <- "/tft/league/v1/entries/by-summoner/{encryptedSummonerId}"
tft_league_by_tier <- "/tft/league/v1/entries/{tier}/{division}"
tft_league_by_id <- "/tft/league/v1/leagues/{leagueId}"

get_data <- function(URL, api) {
  GET(URL, query = list(api_key = api))
}


tft <- R6Class(
  classname = "tft",
  public = list(
    baseURL = NULL,
    master =

    # Initialize class
    initialize = function(baseURL, api) {
      stopifnot(is.character(baseURL), length(baseURL) == 1)

      self$baseURL <- baseURL
    }
  )
)

RiotAPI <- R6Class(
  classname = "RiotAPI",
  public = list(
    baseURL = "https://{region}.api.riotgames.com",
    region = NULL,

    initialize = function(api, region, dry_run = FALSE) {
      self$region <- region
      self$api <- api
      self$dry_run <- dry_run
      self$baseURL <- glue("https://{region}.api.riotgames.com")
      self$tft <- tft$new(self$baseURL, self$api)
    }
  ),
  lock_objects = FALSE
)

b <- RiotAPI$new('123', 'oc1')
b$baseURL
b$tft$master()


