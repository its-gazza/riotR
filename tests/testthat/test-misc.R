context("Misc functions")
test_that("Route TFT", {
  expect_equal(riotR::route_tft("OC1"), "americas")
  expect_equal(riotR::route_tft("NA1"), "americas")
  expect_equal(riotR::route_tft("BR1"), "americas")
  expect_equal(riotR::route_tft("LA1"), "americas")
  expect_equal(riotR::route_tft("LA2"), "americas")

  expect_equal(riotR::route_tft("KR"), "asia")
  expect_equal(riotR::route_tft("JP1"), "asia")

  expect_equal(riotR::route_tft("EUN1"), "europe")
  expect_equal(riotR::route_tft("EUW1"), "europe")
  expect_equal(riotR::route_tft("TR1"), "europe")
  expect_equal(riotR::route_tft("RU"), "europe")
})

test_that("Tier Check", {
  expect_equal(riotR::check_tier("diamond"), "DIAMOND")
  expect_equal(riotR::check_tier("platinum"), "PLATINUM")
  expect_equal(riotR::check_tier("gold"), "GOLD")
  expect_equal(riotR::check_tier("silver"), "SILVER")
  expect_equal(riotR::check_tier("bronze"), "BRONZE")
  expect_equal(riotR::check_tier("iron"), "IRON")

  expect_warning(riotR::check_tier("something else"))
  expect_warning(riotR::check_tier("diamond1"))
})

test_that("Division Check", {
  expect_equal(riotR::check_division(1), "I")
  expect_equal(riotR::check_division(2), "II")
  expect_equal(riotR::check_division(3), "III")
  expect_equal(riotR::check_division(4), "IV")
  expect_equal(riotR::check_division("I"), "I")
  expect_equal(riotR::check_division("II"), "II")
  expect_equal(riotR::check_division("III"), "III")
  expect_equal(riotR::check_division("IV"), "IV")

  expect_warning(riotR::check_tier(5))
  expect_warning(riotR::check_tier("5"))
})

test_that("Queue Check", {
  expect_equal(riotR::check_queue("RANKED_SOLO_5x5"), "RANKED_SOLO_5x5")
  expect_equal(riotR::check_queue("RANKED_FLEX_SR"), "RANKED_FLEX_SR")
  expect_equal(riotR::check_queue("RANKED_FLEX_TT"), "RANKED_FLEX_TT")

  expect_warning(riotR::check_queue("Something"))
})
