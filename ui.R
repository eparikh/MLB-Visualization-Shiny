library(shiny)
library(shinydashboard)
library(DT)

shinyUI(dashboardPage(
  dashboardHeader(title = "MLB Visualization"),
  dashboardSidebar(
    #sidebarUserPanel("MLB Playoff Visualization", image = "baseball.jpg", subtitle = "he"),
    selectInput(inputId = "theStat", choices = lblList, label = h4("Select a statistic")),
    radioButtons(
      "includeBottom",
      inline = TRUE,
      label = h4("Include bottom half of non-playoff teams in comparison?"),
      choices = list("Yes" = TRUE, "No" = FALSE),
      selected = TRUE
    ),
    br(),
    sidebarMenu(
      menuItem("Playoff vs. Non-playoff", icon = icon("map"), href="#top"),
      menuItem("Variation in Statistics", icon = icon("database"), href = "#cv")
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "app.css")
    ),
    fluidRow(#PAGETITLE
      box(
        width = 12,
        align = "center",
        #background = "red",
        h1(textOutput("pageTitle"), id="top")
      )
    ),
    fluidRow(#SECTION TITLE
      box(
        width = 12,
        align = "center",
        background = "navy",
        h4("Difference Between Playoff and Non-Playoff Teams")
      )
    ),
    fluidRow(#SECTION
      box(
        width = 8,
        title = h5(textOutput("barPlotTitle")),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("barPlot"),
        valueBoxOutput(outputId = "meandiff", width = NULL)
      ),
      box(
        width = 4,
        title = h5(textOutput("diffTableTitle")),
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
        h4("Variation in Statistics by Year", id="cv")
      )
    ),
    tags$script(type = "text/javascript", src = "app.js")
  )
))