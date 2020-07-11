RIOT_API <- Sys.getenv("RIOT_API")

context("League")


if(!riotR::check_api(RIOT_API, "league")) {
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

if (SUMMONER_NAME == "" | SUMMONER_PUUID == "" | SUMMONER_ACCOUNT == "") {
  skip("One of the variable is missing")
}

if(!riotR::check_api(RIOT_API, "league")) {
  skip("Invalid API")
}

test_that("Summoner", {
  league <- riotR::league$new(api = RIOT_API, region = "oc1")

  # By account
  account <- league$summoner$by_account(SUMMONER_ACCOUNT)
  expect_equal(content(account)$name, SUMMONER_NAME)

  # By summoner name
  summoner <- league$summoner$by_name(SUMMONER_NAME)
  expect_equal(content(summoner)$name, SUMMONER_NAME)

  # By puuid
  puuid <- league$summoner$by_puuid(SUMMONER_PUUID)
  expect_equal(content(puuid)$name, SUMMONER_NAME)

  # By summonerid
  id <- league$summoner$by_summonerId(SUMMONER_ID)
  expect_equal(content(id)$name, SUMMONER_NAME)
})


test_that("League", {
  league <- riotR::league$new(api = RIOT_API, region = "oc1")

  # By grandmaster
  grandmaster <- league$league$grandmaster()
  expect_equal(grandmaster$status_code, 200)
  grandmaster <- content(grandmaster)
  expect_equal(grandmaster$tier, "GRANDMASTER")

  # By master
  master <- league$league$master()
  expect_equal(master$status_code, 200)
  master <- content(master)
  expect_equal(master$tier, "MASTER")

  # By challenger
  challenger <- league$league$challenger()
  expect_equal(challenger$status_code, 200)
  challenger <- content(challenger)
  expect_equal(challenger$tier, "CHALLENGER")

  # By name
  summoner <- league$league$by_summoner(SUMMONER_ID)
  expect_equal(summoner$status_code, 200)
  summoner <- content(summoner)

  if (length(summoner) != 0) {
    expect_equal(summoner[[1]]$summonerName, SUMMONER_NAME)
  }

  # By tier
  tier <- league$league$by_tier(tier = "diamond", division = "I")
  tier <- content(tier)
  expect_equal(tier[[1]]$tier, "DIAMOND")
  expect_equal(tier[[1]]$rank, "I")
})

test_that("Match", {
  league <- riotR::league$new(api = RIOT_API, region = "oc1")

  # By account
  account <- league$match$by_account(SUMMONER_ACCOUNT)
  matchId <- content(account)$matches[[1]]$gameId
  expect_equal(account$status_code, 200)

  # By match
  match <- league$match$by_matchId(matchId)
  expect_equal(match$status_code, 200)
  expect_equal(content(match)$gameId, matchId)

  # By match Id Timeline
  match <- league$match$by_match_Id_timeline(matchId)
  expect_equal(match$status_code, 200)
})

test_that("Champion Mastery", {
  league <- riotR::league$new(api = RIOT_API, region = "oc1")

  # By account
  account <- league$champion_mastery$by_account(SUMMONER_ID)
  expect_equal(account$status_code, 200)

  # By account by champion
  account_champion <- league$champion_mastery$by_account_by_champion(SUMMONER_ACCOUNT, 103) # 103 is ahri
  expect_equal(account$status_code, 200)
})
