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
    fluidRow(
      column(
        width = 3,
        valueBox(10 * 2, "New Orders", icon = icon("credit-card"), width = NULL)
      ),
      column(
        width = 3,
        valueBox(10 * 2, "New Orders", icon = icon("credit-card"), width = NULL)
      ),
      column(
        width = 3,
        valueBox(10 * 2, "New Orders", icon = icon("credit-card"), width = NULL)
      )
    ),
    fluidRow(
      box(
        width = 9,
        title = "Non-playoff and Playoff Teams by Year",
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("barPlot")
      )
    )
  )
))