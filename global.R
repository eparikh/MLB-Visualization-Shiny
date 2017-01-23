library(shiny)
library(shinydashboard)


lblList <- list(
  "Attendance Per Game" = "attendancePerGame",
  "Batting Average" = "BA",
  "Earned Run Average" = "ERA",
  "Fielding Errors" = "E",
  "Home Runs" = "HR",
  "On Base Percentage" = "OBP",
  "Runs Scored" = "R",
  "Strike Outs" = "SO",
  "Strikeout to Home Run Ratio" = "SOtoHR",
  "Walks" = "BB"
)

lbls <- names(lblList)
summaryCols <- unlist(lblList, use.names = F)