library(shiny)
library(shinydashboard)
library(DT)

shinyUI(dashboardPage(
  dashboardHeader(title = "MLB Visualization"),
  dashboardSidebar(
    #sidebarUserPanel("MLB Playoff Visualization", image = "baseball.jpg", subtitle = "he"),
    selectInput(inputId = "theStat", choices = lblList, label = h4("Select a statistic")),
    sidebarMenu(
      menuItem("Playoff vs. Non-playoff", icon = icon("bar-chart"), href="#top"),
      menuItem("Home vs. Away", icon = icon("home"), href = "#homeaway")
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "app.css")
    ),
    # fluidRow(#PAGETITLE
    #   box(
    #     width = 12,
    #     align = "left",
    #     #background = "red",
    #     h1(textOutput("pageTitle"), id = "page-title"),
    #     id="title-box"
    #   )
    # ),
    fluidRow(#SECTION TITLE
      box(
        width = 12,
        align = "left",
        #background = "navy",
        h3("Playoff vs. Non-Playoff Teams"),
        id = "diff",
        class = "subheader"
      )
    ),
    radioButtons(
      "includeBottom",
      inline = TRUE,
      label = h4("Include bottom half of non-playoff teams in comparison?"),
      choices = list("Yes" = TRUE, "No" = FALSE),
      selected = TRUE
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
        align = "left",
        #background = "navy",
        h3("Home vs. Away Games"),
        id = "homeaway",
        class = "subheader"
      )
    ),
    tags$script(type = "text/javascript", src = "app.js")
  )
))