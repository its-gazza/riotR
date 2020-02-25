require(R6)
require(glue)
require(httr)

tft_league_master <- "/tft/league/v1/master"
tft_league_grandmaster <- "/tft/league/v1/grandmaster"
tft_league_challenger <- "/tft/league/v1/challenger"
tft_league_by_summoner <- "/tft/league/v1/entries/by-summoner/{encryptedSummonerId}"
tft_league_by_tier <- "/tft/league/v1/entries/{tier}/{division}"
tft_league_by_id <- "/tft/league/v1/leagues/{leagueId}"

get_data <- function(URL, api) {
  GET(URL, query = list(api_key = api))
}

# ==== R6 Classes ==== #
# ---- RiotAPI ---- #
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
      self$tft <- TFT$new(self$baseURL, self$api)
    }
  ),
  lock_objects = FALSE
)

# ---- TFT ---- #
TFT <- R6Class(
  classname = "TFT",
  public = list(
    baseURL = NULL,
    api = NULL,
    master = function() get_data(glue("{self$baseURL}{master_endpoint}"), self$api),
    grandmaster = function() get_data(glue("{self$baseURL}{grandmaster_endpoint}"), self$api),
    # Initialize class
    initialize = function(baseURL, api) {
      self$baseURL <- baseURL
      self$api <- api
    }
  ),
  private = list(
    master_endpoint = tft_league_master,
    grandmaster_endpoint = tft_league_grandmaster,
    challenger_endpoint = tft_league_challenger,
    by_summoner_endpoint = tft_league_by_summoner,
    by_tier_endpoint = tft_league_by_tier,
    by_id_endpoint = tft_league_by_id
  )
)

b <- RiotAPI$new('RGAPI-ed01c315-58a8-40c9-b851-a48f22189215', 'oc1')
a <- b$tft$master()
a$content(type = "json")

