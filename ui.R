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
    plotOutput("barPlot")
    # tabItems(
    #   tabItem(tabName = "map",
    #           fluidRow(
    #             infoBoxOutput("maxBox"),
    #             infoBoxOutput("minBox"),
    #             infoBoxOutput("avgBox"),
    #             # gvisGeoChart
    #             box(htmlOutput("map"), height = 450),
    #             # gvisHistoGram
    #             box(htmlOutput("hist"), height = 450)
    #           )
    #   ),
    #   tabItem(tabName = "data",
    #           fluidRow(
    #             box(DT::dataTableOutput("table"), width = 12)
    #           )        
    #   )
    # )
  )
))