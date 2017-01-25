library(shiny)
library(shinydashboard)
library(DT)

shinyUI(dashboardPage(
  dashboardHeader(title = "MLB Visualization"),
  dashboardSidebar(
    #sidebarUserPanel("MLB Playoff Visualization", image = "baseball.jpg", subtitle = "he"),
    sidebarMenu(
      #menuItem("Map", tabName = "map", icon = icon("map")),
      #menuItem("Data", tabName = "data", icon = icon("database"))
    ),
    selectInput(inputId = "theStat", choices = lblList, label = h4("Select a statistic")),
    radioButtons(
      "includeBottom",
      inline = TRUE,
      label = h4("Include bottom half of non-playoff teams in comparison?"),
      choices = list("Yes" = TRUE, "No" = FALSE),
      selected = TRUE
    )
  ),
  dashboardBody(
    fluidRow(#PAGETITLE
      box(
        width = 12,
        align = "center",
        background = "black",
        h1(textOutput("pageTitle"))
      )
    ),
    fluidRow(#SECTION TITLE
      box(
        width = 12,
        align = "center",
        background = "navy",
        h4("Difference Between Playoff and Non-playoff Teams")
      )
    ),
    fluidRow(#SECTION
      box(
        width = 8,
        title = h4(textOutput("barPlotTitle")),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("barPlot"),
        valueBoxOutput(outputId = "meandiff", width = NULL)
      ),
      box(
        width = 4,
        title = h4(textOutput("diffTableTitle")),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        dataTableOutput("diffTable")
      )
    ),
    fluidRow(#SECTION TITLE
      br(),
      br(),
      box(
        width = 12,
        align = "center",
        background = "navy",
        h4("Variation in Statistics by Year")
      )
    )
  )
))