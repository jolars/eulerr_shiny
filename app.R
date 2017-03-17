#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(eulerr)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Area-propportional Euler diagrams"),

   # Sidebar with a slider input for number of bins
   sidebarLayout(
      sidebarPanel(
         numericInput("asdf",
                      "A",
                      value = 5),
         numericInput("qwer",
                      "B",
                      value = 3),
         numericInput("zxcv",
                      "C",
                      value = 1)
      ),

      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("euler_diagram")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

   output$euler_diagram <- renderPlot({
     fit <- euler(c("A" = input$asdf, "B" = input$qwer, "A&B" = input$zxcv))
     plot(fit)
   })
}

# Run the application
shinyApp(ui = ui, server = server)

