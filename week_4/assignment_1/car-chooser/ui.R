library(shiny)
library(markdown)

mt_cars <- (function(...) get(data(..., envir = new.env())))("mtcars")
mt_cars$hpp <- mt_cars$hp / mt_cars$wt

shinyUI(fluidPage(
    titlePanel("Car Chooser"),

    sidebarLayout(
        sidebarPanel(
            sliderInput(
                "hpp",
                "Horsepowers Per 1000 Pounds:",
                min = min(round(mt_cars$hpp * 0.9)),
                max = max(round(mt_cars$hpp * 1.1)),
                value = mean(mt_cars$hpp)
            ),
            sliderInput(
                "mpg",
                "Miles Per Galon:",
                min = min(round(mt_cars$mpg * 0.9)),
                max = max(round(mt_cars$mpg * 1.1)),
                value = mean(mt_cars$mpg)
            )
        ),
        mainPanel(tabsetPanel(
            type = "tabs",
            tabPanel("Application",
                     tableOutput("cars"),
                     plotlyOutput("tuner")),
            tabPanel(
                "Documentation",
                includeMarkdown("doc/car-chooser-documentation.Rmd")
            )
        ))
    )
))