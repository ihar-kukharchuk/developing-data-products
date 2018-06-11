library(shiny)
library(dplyr)
library(plotly)

generateSignature <- function(cars) {
    description <- paste0("Model: ", cars$model, "<br>",
                          "Miles per galon: ", cars$mpg, "<br>",
                          "Number of cylinders: ", cars$cyl, "<br>",
                          "Displacement (cu.in.): ", cars$disp, "<br>",
                          "Gross horsepower: ", cars$hp, "<br>",
                          "Rear axle ratio: ", cars$drat, "<br>",
                          "Weight (1000 lbs): ", cars$wt, "<br>",
                          "1/4 mile time: ", cars$qsec, "<br>",
                          "Transmission: ", if (cars$am == 0)
                              "automatic" else "manual", "<br>",
                          "Number of forward gears: ", cars$gear, "<br>",
                          "Number of carburetors: ", cars$carb, "<br>")
}

shinyServer(function(input, output, session) {
    mt_cars <- (function(...) get(data(..., envir = new.env())))("mtcars")
    mt_cars$hpp <- mt_cars$hp / mt_cars$wt
    
    output$cars <- renderTable({
        mt_cars$dist <- sqrt((mt_cars$hpp - input$hpp) ^ 2 +
                                 (mt_cars$mpg - input$mpg) ^ 2)
        mt_cars$model <- rownames(mt_cars)
        cars_out <- top_n(mt_cars, 3,-dist)
        cars_out <- cars_out[, c("model", "mpg", "hp", "qsec")]
        colnames(cars_out) <- c("model", "mpg", "hp", "1/4 mile time")
        cars_out
    })
    
    output$tuner <- renderPlotly({
        y_border = round(1.1 * max(mt_cars$mpg))
        x_border = round(1.1 * max(mt_cars$hpp))
        
        mt_cars$dist <- sqrt((mt_cars$hpp - input$hpp) ^ 2 +
                                 (mt_cars$mpg - input$mpg) ^ 2)
        mt_cars$model <- rownames(mt_cars)
        
        signature.all <- generateSignature(mt_cars)
        signature.selected <- generateSignature(top_n(mt_cars, 3,-dist))
        
        plot_ly() %>%
            add_trace(data = mt_cars, x = ~hpp, y = ~mpg,
                      hoverinfo = "text", text = signature.all,
                      name = "all cars") %>%
            add_trace(data = top_n(mt_cars, 3,-dist), x = ~hpp, y = ~mpg,
                      hoverinfo = "text", text = signature.selected,
                      name = "suggested cars") %>%
            add_lines(x = c(input$hpp, input$hpp),
                      y = c(min(round(mt_cars$mpg * 0.9)), y_border),
                      name = "horsepowers/1000 pounds") %>%
            add_lines(x = c(min(round(mt_cars$hpp * 0.9)), x_border),
                      y = c(input$mpg, input$mpg),
                      name = "miles/galon") %>%
            layout(xaxis = list(title = "horsepowers per 1000 pounds"),
                   yaxis = list(title = "miles per galon"))
    })
})