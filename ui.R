library(shiny)
library(shinydashboard)
library(DT)

shinyUI(dashboardPage(
  dashboardHeader(title = "MLB Visualization"),
  dashboardSidebar(
    selectInput(inputId = "theStat", choices = lblList, label = h5("Select a variable:")),
    radioButtons(
      "includeBottom",
      inline = TRUE,
      label = h5("Include bottom half of non-playoff teams in comparison?"),
      choices = list("Yes" = TRUE, "No" = FALSE),
      selected = TRUE
    ),
    br(),
    sidebarMenu(
      h5("Navigate:", id = "nav-label"),
      menuItem("Mean differences", icon = icon("bar-chart"), newtab = FALSE, href="#diff"),
      menuItem("Hitting correlations", icon = icon("table"), newtab = FALSE, href = "#corr-hitting"),
      menuItem("Pitching correlations", icon = icon("table"), newtab = FALSE, href = "#corr-pitching")
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "app.css")
    ),
    fluidRow(#SECTION TITLE
      box(
        width = 12,
        align = "left",
        #solidHeader = TRUE,
        #background = "navy",
        h3("Mean differences of playoff and non-playoff teams"),
        id = "diff",
        class = "subheader"
      )
    ),
    fluidRow(
      valueBoxOutput(outputId = "meandiff", width = 12)
    ),
    br(),
    fluidRow(#SECTION
      box(
        width = 8,
        title = h5(textOutput("barPlotTitle")),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("barPlot")
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
      box(
        width = 12,
        align = "left",
        #background = "navy",
        h3("Correlations between variables: Hitting"),
        id = "corr-hitting",
        class = "subheader"
      )
    ),
    fluidRow(#SECTION
      box(
        width = 6,
        title = h5("Playoff team hitting"),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("corrHittingPlayoff")
      ),
      box(
        width = 6,
        title = h5("Non-playoff team hitting"),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("corrHittingNonPlayoff")
      )
    ),
    fluidRow(#SECTION TITLE
      br(),
      box(
        width = 12,
        align = "left",
        #background = "navy",
        h3("Correlations between variables: Pitching"),
        id = "corr-pitching",
        class = "subheader"
      )
    ),
    fluidRow(#SECTION
      box(
        width = 6,
        title = h5("Playoff team pitching"),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("corrPitchingPlayoff")
      ),
      box(
        width = 6,
        title = h5("Non-playoff team pitching"),
        status = "primary",
        solidHeader = TRUE,
        collapsible = FALSE,
        plotOutput("corrPitchingNonPlayoff")
      )
    ),
    tags$script(type = "text/javascript", src = "app.js")
  )
))