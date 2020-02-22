# ==== Base URL ==== # 
base_url <- "https://{region}.api.riotgames.com"

# ==== TFT end points ==== # 
# ---- League ---- # 
tft_league_master <- "/tft/league/v1/master"
tft_league_grandmaster <- "/tft/league/v1/grandmaster"
tft_league_challenger <- "/tft/league/v1/challenger"
tft_league_by_summoner <- "/tft/league/v1/entries/by-summoner/{encryptedSummonerId}"
tft_league_by_tier <- "/tft/league/v1/entries/{tier}/{division}"
tft_league_by_id <- "/tft/league/v1/leagues/{leagueId}"
# ---- Match ---- # 
tft_match_by_puuid <- "/tft/match/v1/matches/by-puuid/{puuid}/ids"
tft_match_by_matchid <- "/tft/match/v1/matches/{matchId}"
# ---- Summoner ---- # 
tft_summoner_by_account <- "/tft/summoner/v1/summoners/by-account/{encryptedAccountId}"
tft_summoner_by_name <- "/tft/summoner/v1/summoners/by-name/{summonerName}"
tft_summoner_by_puuid <- "/tft/summoner/v1/summoners/by-puuid/{encryptedPUUID}"
tft_summoner_by_summonerid <- "/tft/summoner/v1/summoners/{encryptedSummonerId}"