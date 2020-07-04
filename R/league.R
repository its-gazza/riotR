# ==== League API ==== #
#' @title R6 Class for League of Legends end point
#'
#' @description R6 class to access the Teamfight Tactics API. This class is
#'   base on the different API path as illustrated in the Riot API website.
#'
#' @exportClass league
#' @export
league <- R6::R6Class(
  classname = "league",
  public = list(
    # ---- Initialize Variables ---- #
    #' @field api Riot API
    api = NA,
    #' @field region API region, acceptable values: BR1, EUN1, EUW1, JP1, KR, LA1, LA2, NA1, OC1, TR1, RU
    region = NA,
    #' @field dry_run If true all end point call will return glued URL
    dry_run = FALSE,
    #' @field league search by league end points. See [league_league] for more info
    league = NULL,
    #' @field match search by match end points. See [league_match] for more info
    match = NULL,
    #' @field summoner search by summoner end points. See [league_summoner] for more info
    summoner = NULL,
    #' @field champion_mastery search by champion mastery
    champion_mastery = NULL,

    # ---- Constructor ---- #
    #' @description
    #' Create a new league object
    #' @param api Riot API
    #' @param region Access region
    #' @param dry_run Whether to call API
    #' @return A new `league` object
    initialize = function(api, region, dry_run = FALSE) {
      self$api <- api
      self$region <- region
      self$dry_run <- FALSE
      self$league <- league_league$new(api = self$api, region = self$region, dry_run = self$dry_run)
      self$match <- league_match$new(api = self$api, region = self$region, dry_run = self$dry_run)
      self$summoner <- league_summoner$new(api = self$api, region = self$region, dry_run = self$dry_run)
      self$champion_mastery <- league_champion_mastery$new(api = self$api, region = self$region, dry_run = self$dry_run)
    }
  )
)

# ==== League of Legends League End Points ==== #
league_league <- R6::R6Class(
  classname = "league_league",
  public = list(
    # ---- Initialize Variables ---- #
    #' @field api Riot API
    api = NA,
    #' @field region API region, acceptable values: BR1, EUN1, EUW1, JP1, KR, LA1, LA2, NA1, OC1, TR1, RU
    region = NA,
    #' @field dry_run If true all end point call will return glued URL
    dry_run = FALSE,

    # ---- Constructor ---- #
    initialize = function(api, region, dry_run) {
      self$api <- api
      self$region <- region
      self$dry_run <- dry_run
    },

    # ---- Methods ---- #
    # Challenger ====
    #' @description
    #' Get challenger league.
    #' For more info see [here](https://developer.riotgames.com/apis#league-v4/GET_getChallengerLeague)
    #'
    #' @param queue Rank queue, accepted inputs: RANKED_SOLO_5x5, RANKED_FLEX_SR, RANKED_FLEX_TT
    #' @param region Region to query. Default to class's region. Can overwrite.
    challenger = function(queue = "RANKED_SOLO_5x5", region = self$region) {
      queue <- check_queue(queue)

      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/challengerleagues/by-queue/{queue}") %>% glue,
        api = self$api)
      return(url)
    },

    # Grandmaster ====
    #' @description
    #' Get grandmaster league.
    #' For more info see [here](https://https://developer.riotgames.com/apis#league-v4/GET_getGrandmasterLeague)
    #'
    #' @param region Region to query. Default to class's region. Can overwrite.
    grandmaster = function(queue = "RANKED_SOLO_5x5", region = self$region) {
      queue <- check_queue(queue)

      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/grandmasterleagues/by-queue/{queue}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Master ====
    #' @description
    #' Get master league.
    #' For more info see [here](https://developer.riotgames.com/apis#league-v4/GET_getMasterLeague)
    #'
    #' @param region Region to query. Default to class's region. Can overwrite.
    master = function(queue = "RANKED_SOLO_5x5", region = self$region) {
      queue <- check_queue(queue)

      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/masterleagues/by-queue/{queue}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Search by summoner ====
    #' @description
    #' Search client by summonerId
    #'
    #' @param summonerId
    #'
    #' @param region
    by_summoner = function(summonerId = NULL, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/entries/by-summoner/{summonerId}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Search by tier ====
    by_tier = function(tier = NULL, division = NULL, queue = "RANKED_SOLO_5x5", region = self$region) {
      queue <- check_queue(queue)
      tier <- check_tier(tier)
      division <- check_division(division)

      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/entries/{queue}/{tier}/{division}") %>% glue,
        api = self$api
      )

      return(url)
    },

    # Search by leagueId ====
    by_leagueId = function(leagueId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/leagues/{leagueId}") %>% glue,
        api = self$api
      )
      return(url)
    }
  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/lol/league/v4"

  )
)





# ==== League of Legends Match End Points ==== #
league_match <- R6::R6Class(
  classname = "league_match",
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
    # Search by match ID
    by_matchId = function(matchId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/matches/{matchId}") %>% glue,
        api = self$api
      )

      return(url)
    },
    # Search by account ID
    by_account = function(accountId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/matchlists/by-account/{accountId}") %>% glue,
        api = self$api
      )
    },
    # Search by match ID with timeline
    by_match_Id_timeline = function(matchId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/timelines/by-match/{matchId}") %>% glue,
        api = self$api
      )

      return(url)
    }
  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/lol/match/v4"
  )
)


# ==== League of Legends Summoner End Points ==== #
league_summoner <- R6::R6Class(
  classname = "league_summoner",
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
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/by-account/{encryptedAccountId}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Search by summoner name
    by_name = function(summonerName, region = self$region) {
      base_url <- glue::glue("{private$base_url}")
      url <- get_url(
        url = glue::glue("{private$base_url}/by-name/{summonerName}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Sarch by puuid
    by_puuid = function(encryptedPUUID, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/by-puuid/{encryptedPUUID}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Search by summoner id
    by_summonerId = function(encryptedSummonerId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/{encryptedSummonerId}") %>% glue,
        api = self$api
      )
      return(url)
    }
  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/lol/summoner/v4/summoners"
  )
)

# ==== League of Legends Champion Mastery End Points ==== #
league_champion_mastery <- R6::R6Class(
  classname = "league_champion_mastery",
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
    by_account = function(summonerId, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/champion-masteries/by-summoner/{summonerId}") %>% glue,
        api = self$api
      )
      return(url)
    },

    # Search by account by champion
    by_account_by_champion = function(summonerId, champion, region = self$region) {
      url <- riotR::get_url(
        url = glue::glue("{private$base_url}/champion-masteries/by-summoner/{summonerId}/by-champion/{champion}") %>% glue,
        api = self$api
      )
      return(url)
    }

  ),

  # ---- Private Methods ---- #
  private = list(
    base_url = "https://{region}.api.riotgames.com/lol/champion-mastery/v4"
  )
)
