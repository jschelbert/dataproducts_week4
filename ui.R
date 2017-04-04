#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("united"),
    # Application title
    titlePanel("An overview of some forecasting methods"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                "example",
                "Example data:",
                c(
                    "Beer production" = "beer",
                    "Anti-diabetic drug sales" = "drugs",
                    "Electrical equipment" = "elecequip"
                )
            ),
            radioButtons(
                "methods",
                "Forecasting methods:",
                c(
                    "Naiive" = "naiive",
                    "Mean" = "mean",
                    "Drift method" = "drift",
                    "Seasonal naiive" = "snaiive",
                    "Exponential smoothing" = "es",
                    "ARIMA" = "arima",
                    "ETS" = "ets",
                    "Neural net" = "nn"
                )
            ),
            sliderInput(
                "horizon",
                "Forecast horizon:",
                min = 1,
                max = 100,
                value = 10
            ),
            uiOutput("ui")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("ForecastPlot")
        )
    )
))
