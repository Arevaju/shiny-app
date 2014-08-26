shinyServer(function(input, output) { 
 
  
  passData <- reactive({
    data <- data[data$Country %in% input$country_filter1 & 
                   data$Year %in% input$year,]
    rownames(data) = unique(data$NUTS_CODE)  
    data
  })
  
  passData2 <- reactive({
  indicators <- strsplit(input$indicator, ",")[[1]]
  indicators 
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
 #  a$data(passData1()[,c(7,8,9)],pointPlacement='on')    
   a$data(passData2(),pointPlacement='on') 
    return(a)    
  })
})
