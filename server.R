library(shiny)
library(shinydashboard)

source("helpers.R")

masterData <- getMasterData()
barPlotList <- getBarPlotData(masterData, summaryCols)


shinyServer(function(input, output){
  
  theStat <- reactive({input$theStat})
  statLabel <- reactive({statToLabel[[theStat()]]})
  
  #PAGE TITLE
  output$title <- renderText({statLabel()})
  
  
  #BAR PLOT
  output$barPlot <- renderPlot({
    plotBar(
      df = barPlotList$data,
      yCol = theStat(),
      lab = statLabel(),
      yFrom = barPlotList$mins[theStat()],
      yTo = barPlotList$maxes[theStat()],
      yBy = barPlotList$yTicks[theStat()]
    )
  })
})