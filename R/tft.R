require(R6)
require(httr)
require(glue)

# ==== TFT API ==== #
tft <- R6::R6Class(
  classname = "tft",
  public = list(
    # ---- Initialize Variables ---- #
    api = NA,
    region = NA,
    dry_run = FALSE,
    league = NULL,

    # ---- Constructor ---- #
    initialize = function(api, region, dry_run = FALSE) {
      self$api <- api
      self$region <- region
      self$dry_run <- FALSE
      self$league <- tft_league$new(api = self$api,region = self$region,dry_run = self$dry_run)
      self$match <- tft_match$new(api = self$api,region = self$region,dry_run = self$dry_run)
    },

    # ---- Methods ---- #
    match = function() {
      NULL
    },
    summoner = function() {
      NULL
    },

    # ---- Print ---- #
    print = function(...) {
      print(self$api)
      print(self$region)
      print(self$dry_run)
    }
  ),

  private = list(
    base_url = "https://{region}.api.riotgames.com"
  )
)


# ==== TFT League End Points ==== #
tft_league <- R6::R6Class(
  classname = "tft_league",
  public = list(
    # ---- Initialize Variables ---- #
    api = NA,
    region = NA,
    dry_run = FALSE,

    # ---- Constructor ---- #
    initialize = function(api, region, dry_run) {
      self$api <- api
      self$region <- region
      self$dry_run <- dry_run
    },

    # ---- Methods ---- #
    # Challenger ====
    challenger = function(region = self$region) {
      url <- private$glue_url(path = "/challenger", region = region)
      return(url)
    },

    # Grandmaster ====
    grandmaster = function(region = self$region) {
      url <- private$glue_url(path = "/grandmaster", region = region)
      return(url)
    },

    # Master ====
    master = function(region = self$region) {
      url <- private$glue_url(path = "/master", region = region)
      return(url)
    },

    # Search by summoner ====
    by_summoner = function(encryptedSummonerId = NULL, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/entries/by-summoner/{encryptedSummonerId}"),
        region = region
      )
      return(url)
    },

    # Search by tier ====
    by_tier = function(tier = NULL, division = NULL, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/league/v1/entries/{tier}/{division}"),
        region = region
      )

      return(url)
    },

    # Search by leagueId ====
    by_leagueId = function(leagueId, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/league/v1/leagues/{leagueId}"),
        region = region
      )
      return(url)
    }
  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/tft/league/v1/challenge",

    # Glue URL
    glue_url = function(path, region = self$region) {
      url <- httr::modify_url(
        url = glue::glue(private$base_url),
        path = glue::glue(path),
        query = list(api_key = self$api)
      )

      return(url)
    }
  )
)


# ==== TFT Match End Points ==== #
tft_match <- R6::R6Class(
  classname = "tft_match",
  public = list(
    # ---- Initialize Variables ---- #
    api = NA,
    region = NA,
    dry_run = FALSE,

    # ---- Constructor ---- #
    initialize = function(api, region, dry_run) {
      self$api <- api
      self$region <- region
      self$dry_run <- dry_run
    },

    # ---- Methods ---- #
    # Search by tier ====
    by_puuid = function(puuid, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/match/v1/matches/by-puuid/{puuid}/ids"),
        region = region
      )
      return(url)
    },

    # Search by match ID
    by_matchId = function(matchId, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/match/v1/matches/{matchId}"),
        region = region
      )

      return(url)
    }
  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/tft/league/v1/challenge",

    # Glue URL
    glue_url = function(path, region = self$region) {
      url <- httr::modify_url(
        url = glue::glue(private$base_url),
        path = glue::glue(path),
        query = list(api_key = self$api)
      )

      return(url)
    }
  )
)
