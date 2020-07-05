RIOT_API <- Sys.getenv("RIOT_API")
SUMMONER_NAME <- Sys.getenv("SUMMONER_NAME")
SUMMONER_PUUID <- Sys.getenv("SUMMONER_PUUID")
SUMMONER_ACCOUNT <- Sys.getenv("SUMMONER_ACCOUNT")
SUMMONER_ID <- Sys.getenv("SUMMONER_ID")

context("TFT")

if (SUMMONER_NAME == "" | SUMMONER_PUUID == "" | SUMMONER_ACCOUNT == "") {
  skip("One of the variable is missing")
}

if(!riotR::check_api(RIOT_API)) {
  skip("Invalid API")
}

test_that("Summoner", {
  tft <- riotR::tft$new(api = RIOT_API, region = "oc1")

  # By account
  account <- tft$summoner$by_account(SUMMONER_ACCOUNT)
  expect_equal(content(account)$name, SUMMONER_NAME)

  # By summoner name
  summoner <- tft$summoner$by_name(SUMMONER_NAME)
  expect_equal(content(summoner)$name, SUMMONER_NAME)

  # By puuid
  puuid <- tft$summoner$by_puuid(SUMMONER_PUUID)
  expect_equal(content(puuid)$name, SUMMONER_NAME)

  # By summonerid
  id <- tft$summoner$by_summonerId(SUMMONER_ID)
  expect_equal(content(id)$name, SUMMONER_NAME)
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
  expect_equal(content(match)$metadata$match_id, match_list[1])
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
