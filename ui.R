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
            p("This shiny app enables the user to interactively try out some of R's forecasting models.",
              "Choose from three different academic data sets and eight different forecasting techniques.",
              "In addition, you can adjust the horizon to be forecasted and the year the forecast should start."),
            hr(),
            plotOutput("ForecastPlot"),
            hr(),
            p("All example data is provided by the", code("fpp"), "package. More precisely, the sources of the data are"),
            tags$li(strong("Beer production:"),"Australian Bureau of Statistics. Cat. 8301.0.55.001."),
            tags$li(strong("Anti-diabetic drug sales:"), "Medicare Australia"),
            tags$li(strong("Electrical equipment:"), "Eurostat. data.is/y6dO8i"),
            hr(),
            p("Sources for the app can be found on the", a(href="https://github.com/jschelbert/dataproducts_week4", "github page"), ".")
        )
    )
))
