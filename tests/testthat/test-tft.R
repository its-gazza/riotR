RIOT_API <- Sys.getenv("RIOT_API")

context("TFT")


if(!riotR::check_api(RIOT_API, "tft")) {
  skip("Invalid API")
}

# Get user credentials
summoner <- riotR::get_user_id("itsgazza", "oc1", RIOT_API)
SUMMONER_NAME <- summoner$name
SUMMONER_PUUID <- summoner$puuid
SUMMONER_ACCOUNT <- summoner$accountId
SUMMONER_ID <- summoner$id

if (SUMMONER_NAME == "" | SUMMONER_PUUID == "" | SUMMONER_ACCOUNT == "") {
  skip("One of the variable is missing")
}



test_that("Summoner", {
  tft <- riotR::tft$new(api = RIOT_API, region = "oc1")

  # By account
  account <- tft$summoner$by_account(SUMMONER_ACCOUNT)
  expect_equal(httr::content(account)$name, SUMMONER_NAME)

  # By summoner name
  summoner <- tft$summoner$by_name(SUMMONER_NAME)
  expect_equal(httr::content(summoner)$name, SUMMONER_NAME)

  # By puuid
  puuid <- tft$summoner$by_puuid(SUMMONER_PUUID)
  expect_equal(httr::content(puuid)$name, SUMMONER_NAME)

  # By summonerid
  id <- tft$summoner$by_summonerId(SUMMONER_ID)
  expect_equal(httr::content(id)$name, SUMMONER_NAME)
})


test_that("Match", {
  tft <- riotR::tft$new(api = RIOT_API, region = "oc1")

  # By puuid
  puuid <- tft$match$by_puuid(SUMMONER_PUUID)
  match_list <- purrr::flatten_chr(content(puuid))
  expect_match(match_list[1], "OC.*")

  # By match
  match <- tft$match$by_matchId(match_list[1])
  expect_equal(match$status_code, 200)
  expect_equal(httr::content(match)$metadata$match_id, match_list[1])
})


test_that("League", {
  tft <- riotR::tft$new(api = RIOT_API, region = "oc1")

  # By grandmaster
  grandmaster <- tft$league$grandmaster()
  expect_equal(grandmaster$status_code, 200)
  grandmaster <- content(grandmaster)
  expect_equal(grandmaster$tier, "GRANDMASTER")

  # By master
  master <- tft$league$master()
  expect_equal(master$status_code, 200)
  master <- content(master)
  expect_equal(master$tier, "MASTER")

  # By challenger
  challenger <- tft$league$challenger()
  expect_equal(challenger$status_code, 200)
  challenger <- content(challenger)
  expect_equal(challenger$tier, "CHALLENGER")

  # By name
  summoner <- tft$league$by_summoner(SUMMONER_ID)
  expect_equal(summoner$status_code, 200)
  summoner <- content(summoner)
  expect_equal(summoner[[1]]$summonerName, SUMMONER_NAME)

  # By tier
  tier <- tft$league$by_tier(tier = "diamond", division = "I")
  tier <- content(tier)
  expect_equal(tier[[1]]$tier, "DIAMOND")
  expect_equal(tier[[1]]$rank, "I")
})
