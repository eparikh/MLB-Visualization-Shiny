library(shiny)
library(shinydashboard)


lblList <- list(
  Pitching = c("Earned Run Average" = "ERA"),
  Hitting = c("Batting Average" = "BA",
  "Home Runs" = "HR",
  "On Base Percentage" = "OBP",
  "Runs Scored" = "R",
  "Strikeouts" = "SO",
  "Strikeouts to Home Runs Ratio" = "SOtoHR",
  "Walks" = "BB")
)

lbls <- names(lblList)

statToLabel <- list(
  "ERA" = "Earned Run Average",
  "BA" = "Batting Average",
  "HR" = "Home Runs",
  "OBP" = "On Base Percentage",
  "R" = "Runs Scored",
  "SO" = "Strikeouts",
  "SOtoHR" = "Strikeouts to Home Runs Ratio",
  "BB" = "Walks"
)

summaryCols <- unlist(lblList, use.names = F)