context("Misc functions")
test_that("Route TFT", {
  expect_equal(RiotR::route_tft("OC1"), "americas")
  expect_equal(RiotR::route_tft("NA1"), "americas")
  expect_equal(RiotR::route_tft("BR1"), "americas")
  expect_equal(RiotR::route_tft("LA1"), "americas")
  expect_equal(RiotR::route_tft("LA2"), "americas")

  expect_equal(RiotR::route_tft("KR"), "ASIA")
  expect_equal(RiotR::route_tft("JP1"), "ASIA")

  expect_equal(RiotR::route_tft("EUN1"), "EUROPE")
  expect_equal(RiotR::route_tft("EUW1"), "EUROPE")
  expect_equal(RiotR::route_tft("TR1"), "EUROPE")
  expect_equal(RiotR::route_tft("RU"), "EUROPE")
})

test_that("Tier Check", {
  expect_equal(RiotR::check_tier("diamond"), "DIAMOND")
  expect_equal(RiotR::check_tier("platinum"), "PLATINUM")
  expect_equal(RiotR::check_tier("gold"), "GOLD")
  expect_equal(RiotR::check_tier("silver"), "SILVER")
  expect_equal(RiotR::check_tier("bronze"), "BRONZE")
  expect_equal(RiotR::check_tier("copper"), "COPPER")

  expect_warning(RiotR::check_tier("something else"))
  expect_warning(RiotR::check_tier("diamond1"))
})

test_that("Division Check", {
  expect_equal(RiotR::check_division(1), "I")
  expect_equal(RiotR::check_division(2), "II")
  expect_equal(RiotR::check_division(3), "III")
  expect_equal(RiotR::check_division(4), "IV")
  expect_equal(RiotR::check_division("I"), "I")
  expect_equal(RiotR::check_division("II"), "II")
  expect_equal(RiotR::check_division("III"), "III")
  expect_equal(RiotR::check_division("IV"), "IV")

  expect_warning(RiotR::check_tier(5))
  expect_warning(RiotR::check_tier("5"))
})
