riotR
================

<!-- badges: start -->

[![R build
status](https://github.com/its-gazza/RiotR/workflows/R-CMD-check/badge.svg)](https://github.com/its-gazza/RiotR/actions)
<!-- badges: end -->

`riotR` is a API wrapper for the [Riot Games
API](https://developer.riotgames.com/apis). Current it supports the
League of Legends and Teamfight Tactics end points.

All functions are made to mimic riot’s API end point. For example, If I
want to get a list of challengers in the OCE region, which has an end
point of `/lol/league/v4/challengerleagues/by-queue/{queue}`, you can
access this end point with the following:

``` r
challenger <- riotR::league$new(api = "YOUR API", region = "oc1")$league$challenger(queue = "RANKED_SOLO_5x5")
```

Note all additional parameter required (e.g. queue from example above)
will need to be supplied

## Install

You can install `riotR` with the following:

``` r
remotes::install_github("its-gazza/riotR")
```

You need an API from Riot to use this package. You can get it from
[here](https://developer.riotgames.com/)

## Example

``` r
require(riotR)

# Get a list of grandmaster players
tft <- riotR::tft$new(api = RIOT_API, region = "oc1", dry_run = FALSE)
grandmaster <- tft$league$grandmaster()
grandmaster <- httr::content(grandmaster)
grandmaster_tibble <- do.call(rbind, grandmaster$entries)
head(grandmaster_tibble)
```

Alternatively, you can specify `dry_run` to `TRUE` so all return type is
the url instead of calling riot’s API service

``` r
RIOT_API <- "YOUR_RIOT_API"
tft <- riotR::tft$new(api = RIOT_API, region = "oc1", dry_run = TRUE)
print(tft$league$grandmaster())
```

    ## [1] "https://oc1.api.riotgames.com/tft/league/v1/grandmaster?api_key=YOUR_RIOT_API"

``` r
# Or you can call dry_run in that particular method
tft <- riotR::tft$new(api = RIOT_API, region = "oc1", dry_run = FALSE)
print(tft$league$grandmaster(dry_run = TRUE))
```

    ## [1] "https://oc1.api.riotgames.com/tft/league/v1/grandmaster?api_key=YOUR_RIOT_API"

<!-- Markdown links -->
