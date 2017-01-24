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
  
  #MEANDIFF
  output$meandiff <- renderValueBox({
    meanDiff <- round(getMeanDiff(barPlotList$data, theStat()),3)
    # if(meanDiff >= 0){
    #   icn <- "thumbs-up"
    #   clr <- "green"
    # }else{
    #   icn <- "thumbs-down"
    #   clr <- "red"
    # }
    
    valueBox(
      value = meanDiff,
      subtitle = paste("Mean difference in", statLabel(),"of playoff and non-playoff teams from 2005 to 2015."),
      icon = icon("thumbs-up"),
      color = "green"
    )
  })
  
  
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