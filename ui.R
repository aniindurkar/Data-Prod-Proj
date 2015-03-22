library(shiny)
library(UsingR)
shinyUI(
  pageWithSidebar(
    # App title
    headerPanel("ACME Corp Sales Projection!"),
    sidebarPanel(
      numericInput('cogrowth','ACME Corp Growth % [ between 6 and 20 ]',10,min=6,max=20, step=0.5),
      numericInput('sgrowth','Sectoral Growth Rate % [ between 3 and 5 ]',4,min=3,max=5, step=0.05),
      numericInput('confact','Sentiment Factor [ between -0.7 and 0.4 ]',0,min=-.7,max=.4, step=0.005)
    ),
    mainPanel(
      h3('Forecast Results of ACME Corp using'),
      verbatimTextOutput("cogrowth"),
      verbatimTextOutput("sgrowth"),
      verbatimTextOutput("confact"),
      h4('Your Forecast Factor for this run is'),
      #verbatimTextOutput("cg"),
      #verbatimTextOutput("sg"),
      #verbatimTextOutput("cf"),
      verbatimTextOutput("fcf"),
      h4('and Volume Predicton for the Next Quarter'),
      verbatimTextOutput("prediction")
      
    )
    )
  )

# plotOutput('newHist') - some other time then
