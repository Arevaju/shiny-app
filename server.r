load('data.RData')
shinyServer(function(input, output) { 
  passData <- reactive({
    data <- data[data$Country %in% input$country_filter1 & 
                   data$Year %in% input$year,]
    rownames(data) = unique(data$NUTS_CODE)  
    data
  })
  
  passData1 <- reactive({
    data <- data[data$Country %in% input$country_filter1,]
    datasplit <- split(data[7:9], data$Year, drop=TRUE)
    datasplit <- do.call(cbind, datasplit)
    rownames(datasplit) = unique(datasplit$NUTS_CODE)  
 #   datasplit <- strsplit(input$indicator, ",")[[1]]
    datasplit
  })
  
  ### Radar chart output 1  
  output$radar <- renderChart2({
    a<- rCharts:::Highcharts$new() 
    a$chart(type='line',polar=TRUE, width=600,height = 350)
    a$pane(size='90%')
    a$title(text= "Title")
    a$xAxis(categories= rownames(passData()),tickmarkPlacement='on',lineWidth=0)
    a$yAxis(gridLineInterpolation='polygon',lineWidth=0,min=0)
    a$data(passData()[input$indicator],pointPlacement='on')    
    return(a)    
  })
  
  #### Radar chart output 2
  output$radar1 <- renderChart2({
    a<- rCharts:::Highcharts$new() 
    a$chart(type='line',polar=TRUE, width=600,height = 350)
    a$pane(size='90%')
    a$title(text= "Title")
    a$xAxis(categories= rownames(passData()),tickmarkPlacement='on',lineWidth=0)
    a$yAxis(gridLineInterpolation='polygon',lineWidth=0,min=0)
    a$data(passData1()[,c(1,4,7)],pointPlacement='on')    
    return(a)    
  })
})
