tft <- RiotR::tft$new(api = "RGAPI-ed0c2814-67e4-4a0f-b155-c44e17219a62",
               region = "oc1")
a <- tft$summoner$by_name("itsgazza", "oc1")
content(a)
test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
a <- tft$match$by_puuid("Uy9tdSWKnVllH2U6vklp_erJx5z_Nm4gmCq7E8cTGtzKgbYlagEl0ru2TyqS09X5qH7rpqZ4rLRp_A")
require(tidyverse)
