#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data(mtcars)
mt <- as.data.frame(mtcars)
mtFit <- lm(mpg ~ am + cyl + hp + wt, data = mt)

shinyServer(function(input, output) {
  mtPred <- reactive({
    amInput <- input$am
    cylInput <- input$cyl
    hpInput <- input$hp
    wtInput <- input$wt
    predict(mtFit, newdata = data.frame(
      am = as.integer(amInput),
      cyl = as.integer(cylInput),
      hp = hpInput,
      wt = wtInput
    ))
  })
  output$mpgPred <- renderText({
    mtPred()
  })
})
