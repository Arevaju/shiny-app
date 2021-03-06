library("shiny")
library("rCharts")
shinyUI(pageWithSidebar(  
  headerPanel( "Shiny App"), 
  sidebarPanel(
    selectInput(inputId = "indicator",
                label = (HTML("<b>Select a list of indicators:</b>")),
                multiple = TRUE,
                selected = 'Water stress',
               choices = list("Water stress" = "Water stress", "Water scarcity" = "Water scarcity" )),
                                             
    checkboxGroupInput(inputId = 'country_filter1',
                       label = (HTML("<b>Select the region of interest:</b>")), 
                       sort(unique(data$Country)),
                       selected = sort(unique(data$Country))),
    radioButtons(inputId ="year",
                 label = (HTML("<b>Select the year of interest:</b>")),
                 choices = list ("2010"= "2010",
                                 "2020" = "2020",
                                 "2050" = "2050"
                 )
    ),
    submitButton(text="Run", icon("refresh"))  
  ),
  # Show the results from the query  
  mainPanel(  
    tabsetPanel( 
      tabPanel("Multiyear", showOutput ("radar1", "highcharts"))
    )
  )))