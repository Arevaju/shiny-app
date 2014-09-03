require("shiny")
require("rCharts")
shinyServer(function(input, output) { 
  passData <- reactive({
    data <- data[data$Country %in% input$country_filter1 & 
                   data$Year %in% input$year,]
    rownames(data) = unique(data$NUTS_CODE)
    if (input$indicator== 'Water stress') {col= 7:9}
    if (input$indicator== 'Water scarcity') {col= 8:9}
    data[,col]
  }) 
#######################################################################################
  #### Radar chart output 2
  output$radar1 <- renderChart2({
    a<- rCharts:::Highcharts$new() 
    a$chart(type='line',polar=TRUE, width=600,height = 350)
    a$pane(size='90%')
    a$title(text= "Title")
    a$xAxis(categories= rownames(passData()),tickmarkPlacement='on',lineWidth=0)
    a$yAxis(gridLineInterpolation='polygon',lineWidth=0,min=0)
    a$data(passData(),pointPlacement='on')   
    return(a)    
  })
})