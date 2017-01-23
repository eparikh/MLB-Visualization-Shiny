library(dplyr)
library(ggplot2)
library(tidyr)
library(scales)
library(ggthemes)
library(grid)
library(gridExtra)

source("helpers.R")

masterData <- getMasterData()
barPlotList <- getBarPlotData(masterData, summaryCols)


shinyServer(function(input, output){
  
  theStat <- reactive({input$theStat})
  statLabel <- reactive({statToLabel[theStat()]})
  
  
  #BAR PLOT
  output$barPlot <- renderPlot({
    plotBar(
      df = barPlotList$data,
      xCol = barPlotList$xCol,
      yCol = theStat(),
      lab = statLabel(),
      yFrom = barPlotList$mins[theStat()],
      yTo = barPlotList$maxes[theStat()],
      yBy = barPlotList$yTicks[theStat()],
      facetRow = barPlotList$facetRow,
      facetCol = barPlotList$facetCol
    )
  })
})