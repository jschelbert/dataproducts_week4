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
library(plotly)


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
          h3("Overview"),
            p("This shiny app enables the user to interactively try out some of R's forecasting models.",
              "Choose from three different academic data sets and eight different forecasting techniques.",
              "In addition, you can adjust the horizon to be forecasted and the year the forecast should start.",
              "The forecasting techniques heavily rely on the", code("forecast"), "and", code("fpp"), "package.",
              "A very nice starting point on this topic is given in the", a(href="https://www.otexts.org/fpp", "online book"), "by Rob J Hyndman and George Athanasopoulos."),
            hr(),
            plotlyOutput("ForecastPlot"),
            hr(),
            h3("Explanation"),
            p("In the above figure the time series (black line) and the the computed forecast (blue) is shown.", 
              "Solid blue line indicates the actual forecasted value while blue areas indicate the 80% and 95% confidence intervals.",
              em("Note that confidence intervals are not computed for the neural net forecasting technique.")),
            p("Unfortunately, the current", code("plotly"), "package seems to render both 80% and 95% confidence interval in the same color.",
              "Hovering with the mouse will indicate whether the area belongs to one or the other."),
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
