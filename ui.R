#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



library(shiny)

# Define UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Estimation of Carats from Price and Cut"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      h5(helpText("Change variables:")),
      
      sliderInput("price", label = h5("Price"), min = 326, max = 18823, value = 10000),
      
      selectInput("cut", label = h5("Cut"), 
                  choices = list("Unknown" = "*", "Fair" = "Fair", "Good" = "^Good",
                                 "Very Good" = "Very Good", "Premium" = "Premium",
                                 "Ideal" = "Ideal"))
      ),
    
    # Plot
    mainPanel(
      plotOutput("distPlot"),
      h5("Estimated carats are indicated by the value on Y axis intercepted by the red line"),
      h3(textOutput("result"))
      )
  ))
)