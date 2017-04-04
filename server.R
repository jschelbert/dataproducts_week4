#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(forecast)
library(lubridate)
library(fpp)

beerdata <<- fpp::ausbeer
drugsdata <<- fpp::a10
elecdata <<- fpp::elecequip

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    selectts <- reactive({
        timeseries <- switch(input$example,
                             "beer" = beerdata,
                             "drugs" = drugsdata,
                             "elecequip" = elecdata
                             )
        return(timeseries)
    })

    selectforecastwindow <- reactive({
        ts <- selectts()
        tswindow <- window(ts, end = input$dynamic)
        return(tswindow)
    })

    computeforecast <- reactive({
        ts <- selectforecastwindow()
        horizon <- input$horizon
        fcast <- switch(
            input$methods,
            "naiive" = naive(ts, h = horizon),
            "snaiive" = snaive(ts, h = horizon),
            "mean" = meanf(ts, h = horizon),
            "drift" = rwf(ts, h = horizon, drift = TRUE),
            "es" = ses(ts, h = horizon),
            "ets" = forecast(ets(ts), h = horizon),
            "arima" = forecast(auto.arima(ts), h = horizon),
            "nn" = forecast(nnetar(ts), h = horizon)
        )
    })

    output$accuracy <- renderTable({
        # calculate the accuracy using some common metrics: (R)MSE etc.
        # use accuracy
        accuracy(computeforecast(),selectts())
    })

    output$ForecastPlot <- renderPlot({
        fcast <- computeforecast()
        g <- autoplot(fcast)
        plot(g)
    })

    output$ui <- renderUI({
        switch(input$example,
               "beer" = sliderInput("dynamic", "Start of forecast",
                                  min = 1956, max = 2008, value = 2005),
               "drugs" = sliderInput("dynamic", "Start of forecast",
                                   min = 1992, max = 2008, value = 2005),
               "elecequip" = sliderInput("dynamic", "Start of forecast",
                                       min = 1996, max = 2012, value = 2009)
        )
    })
})
