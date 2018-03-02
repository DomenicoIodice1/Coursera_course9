#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#library 
library(shiny) 
library(ggplot2)
library(dplyr)
library(rsconnect)

#subsetting the dataset
diamonds_subset <- diamonds[,c(1,5,7)]

#Default
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    
    diamonds_subset <- filter(diamonds, grepl(input$cut, cut))
    
    #Linear regression model
    Linear_fitting <- lm(carat~price, diamonds_subset)
    
    #estimation of carats 
    estimation <- predict(Linear_fitting, newdata = data.frame(price = input$price,
                                                               cut = input$cut))
                          
    #GGPLOT
    ggplot <- ggplot(data=diamonds_subset, aes(x=price, y=carat))+
      geom_point(aes(color = cut), alpha = 0.5)+
      geom_smooth(method = "lm")+
      geom_vline(xintercept = input$price, color = "orange")+
      geom_hline(yintercept = estimation, color = "red", size = 2)+
      scale_y_continuous(breaks = scales::pretty_breaks(n = 20))+
      scale_x_continuous(breaks = scales::pretty_breaks(n = 15))
    ggplot
  })
  
  output$result <- renderText({
    diamonds_subset <- filter(diamonds, grepl(input$cut, cut))
    Linear_fitting <- lm(carat~price, diamonds_subset)
    estimation <- predict(Linear_fitting, newdata = data.frame(price = input$price, cut = input$cut))
    result <- paste(round(estimation, digits = 2))
    result
  })
  
})