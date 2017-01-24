library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "MLB Analysis"),
  dashboardSidebar(
    #sidebarUserPanel("Emil Parikh"),
    sidebarMenu(
      #menuItem("Map", tabName = "map", icon = icon("map")),
      #menuItem("Data", tabName = "data", icon = icon("database"))
    ),
    selectInput(inputId = "theStat", choices = lblList, label = "Select a variable")
  ),
  dashboardBody(
    # column(
    #   width = 12,
    #   align = "center"
    #   #h1(textOutput("title"))
    # ),
    column(
      width = 12,
      valueBoxOutput(outputId = "meandiff", width = NULL)
    ),

    fluidRow(
      box(
        width = 8,
        status = "primary",
        solidHeader = FALSE,
        collapsible = FALSE,
        plotOutput("barPlot")
      ),
      column(
        width = 4,
        dataTableOutput("wsTable")
      )
    )
  )
))