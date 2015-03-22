library(shiny)
library(UsingR)

#
# salesqtty.csv is known to be an ordered paor or ( Month, sales units)
# Month number is ascending -> the last entry is the latest actual
# quantity
#
getVal<- function(inval) inval/100
calFcf<- function(cg,sg,cf)
{
  cg <- cg/100
  sg <- sg/100
  cf <- cf/10
  sqrt(1+1.1*cg+0.3*sg+cf)
}

getFcast<-function( qt, fcf)
{
  fc <- c()
  qty <- qt
  for ( i in (1:3)) # Only Next quarter values please
  {
    qty<-qty*fcf
    fc <- c(fc,qty*fcf)
  }
  fc
}

#      calculations
salq<-read.csv("salesqty.csv")
lenf <- dim(salq)[1] # how many actual values do we have
ltstq <- salq$qty[lenf] # what's the latest actual qty
ltstp <- salq$mth[lenf] # what's the latest month


shinyServer(
  function(input, output){
    output$cogrowth <- renderText({paste(" Your % ACME Growth rate is ->",input$cogrowth)})
    output$sgrowth <-renderText({paste(" Your % sector Growth rate is ->", input$sgrowth)})
    output$confact <- renderText({paste(" Your confidence factor is ->", input$confact)})
    
    #
    fcstf <-reactive({calFcf(input$cogrowth, input$sgrowth, input$confact )})

    output$fcf <- renderText({fcstf()})

    #fcastvals <-reactive({getFcast(ltstq, fcstf())})

    output$prediction <- renderPrint({getFcast(ltstq, fcstf())})

    #output$prediction <- renderPrint({c(56:58)})
  }
)
## Some other time ##

#output$newHist <- renderPlot({
#  hist(salq$qty, xlab='child height',col='lightblue', main='Histogram')
#  mu<-input$cogrwth
#  lines(c(mu,mu), c(0,200), col="red", lwd=5)
#  mse<-mean((galton$child - mu)^2)
#  text(63, 150, paste("mu = ", mu))
#  text(63, 140, paste("MSE = ", round(mse, 2)))
  

#shinyServer(
#  function(input, output){
#    output$newFcast <- renderPlot({
#      h3('in the server')
      
#      mu<-70
#      lines(c(mu,mu), c(0,200), col="red", lwd=5)
#      text(63, 150, paste("mu = ", mu))
#    })
#  }
#  )
#     plot(1:salq$mth, 1:salq$qty,"b", main="ACME Corp Sales", xlab="month", ylab="Qty")
#     lines(salq$mth, salq$qty)
#    ,xlab='child height',col='lightblue', main='Histogram')
#    text(63, 150, paste("fcast q = ", 10))     

#      maxq <-max(salq$qty)
#      lenf <- dim(salq)[1] # how many actual values do we have
#      ltstq <- salq$qty[lenf] # what's the latest actual qty
#      ltstp <- salq$mth[lenf] # what's the latest month
#      
#      cogrwth <- input$cogrwth
#      sgrwoth <- input$sgrwoth
#      confact <- input$confact

#      fcstf = sqrt(1.1*cogrwth+0.3*sgrwoth)/1
#      fqty <- ltstq*fcstf

#      salq<-rbind(salq, c(ltstp+1, fqty ))
#      lines(c(12,12),c(0,maxq), col="red", lwd=5)
#      text(63, 150, paste("fcast q = ", fqty))