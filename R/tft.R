require(R6)
require(httr)
require(glue)

# ==== TFT API ==== #
#' @title R6 Class for Teamfight Tactics end point (TFT)
#'
#' @description R6 class to access the Teamfight Tactics API. This class is
#'   base on the different API path as illustrated in the Riot API website.
#'
#' @exportClass tft
#' @export
tft <- R6::R6Class(
  classname = "tft",
  public = list(
    # ---- Initialize Variables ---- #
    #' @field api Riot API
    api = NA,
    #' @field region API region, acceptable values: BR1, EUN1, EUW1, JP1, KR, LA1, LA2, NA1, OC1, TR1, RU
    region = NA,
    #' @field dry_run If true all end point call will return glued URL
    dry_run = FALSE,
    #' @field league TFT search by league end points. See [tft_league] for more info
    league = NULL,
    #' @field match TFT search by match end points. See [tft_match] for more info
    match = NULL,
    #' @field summoner TFT search by summoner end points. See [tft_summoner] for more info
    summoner = NULL,

    # ---- Constructor ---- #
    #' @description
    #' Create a new tft object
    #' @param api Riot API
    #' @param region Access region
    #' @param dry_run Whether to call API
    #' @return A new `tft` object
    initialize = function(api, region, dry_run = FALSE) {
      self$api <- api
      self$region <- region
      self$dry_run <- FALSE
      self$league <- tft_league$new(api = self$api,region = self$region,dry_run = self$dry_run)
      self$match <- tft_match$new(api = self$api,region = self$region,dry_run = self$dry_run)
      self$summoner <- tft_summoner$new(api = self$api,region = self$region,dry_run = self$dry_run)
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
#' @title TFT League End Point R6 class
#'
#' @description Sub class for [tft] to access [TFT-LEAGUE-V1](https://developer.riotgames.com/apis#tft-league-v1)
#'   end points.
#'
#' @exportClass tft_league
#' @export
tft_league <- R6::R6Class(
  classname = "tft_league",
  public = list(
    # ---- Initialize Variables ---- #
    #' @field api Riot API
    api = NA,
    #' @field region API region, acceptable values: BR1, EUN1, EUW1, JP1, KR, LA1, LA2, NA1, OC1, TR1, RU
    region = NA,
    #' @field dry_run If true all end point call will return glued URL
    dry_run = FALSE,

    # ---- Constructor ---- #
    #' @description
    #' Create a new tft object
    #' @param api Riot API
    #' @param region Access region
    #' @param dry_run Whether to call API
    #' @return A new `tft` object
    initialize = function(api, region, dry_run) {
      self$api <- api
      self$region <- region
      self$dry_run <- dry_run
    },

    # ---- Methods ---- #
    # Challenger ====
    #' @description
    #' Get challenger league.
    #' For more info see [here](https://developer.riotgames.com/apis#tft-league-v1/GET_getChallengerLeague)
    #'
    #' @param region Region to query. Default to class's region. Can overwrite.
    challenger = function(region = self$region) {
      url <- private$glue_url(path = "/challenger", region = region)
      return(url)
    },

    # Grandmaster ====
    #' @description
    #' Get grandmaster league.
    #' For more info see [here](https://developer.riotgames.com/apis#tft-league-v1/GET_getGrandmasterLeague)
    #'
    #' @param region Region to query. Default to class's region. Can overwrite.
    grandmaster = function(region = self$region) {
      url <- private$glue_url(path = "/grandmaster", region = region)
      return(url)
    },

    # Master ====
    #' @description
    #' Get master league.
    #' For more info see [here](https://developer.riotgames.com/apis#tft-league-v1/GET_getMasterLeague)
    #'
    #' @param region Region to query. Default to class's region. Can overwrite.
    master = function(region = self$region) {
      url <- private$glue_url(path = "/master", region = region)
      return(url)
    },

    # Search by summoner ====
    #' @description
    #' Search client by
    by_summoner = function(summonerName = NULL, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/entries/by-summoner/{summonerName}"),
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

# ==== TFT Summoner End Points ==== #
tft_summoner <- R6::R6Class(
  classname = "tft_summoner",
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
    # Search by account id ====
    by_account = function(encryptedAccountId, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/summoner/v1/summoners/by-account/{encryptedAccountId}"),
        region = region
      )
      return(url)
    },

    # Search by summoner name
    by_name = function(summonerName, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/summoner/v1/summoners/by-name/{summonerName}"),
        region = region
      )
      return(url)
    },

    # Sarch by puuid
    by_puuid = function(encryptedPUUID, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/summoner/v1/summoners/by-puuid/{encryptedPUUID}"),
        region = region
      )
      return(url)
    },

    # Search by summoner id
    by_summonerId = function(encryptedSummonerId, region = self$region) {
      url <- private$glue_url(
        path = glue::glue("/tft/summoner/v1/summoners/{encryptedSummonerId}"),
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
