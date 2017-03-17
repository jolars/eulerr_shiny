#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(eulerr)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title


  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       titlePanel("Area-proportional Euler diagrams"),
       downloadButton("download_plot", "Save plot"),
       p(verbatimTextOutput(outputId = "test")),
       p("String together combinations by joining them
         with a ampersand (&)."),
       splitLayout(cellWidths = c("70%", "30%"),
         textInput("combo_1", NULL, "A"),
         numericInput("size_1", NULL, 5, min = 0)
       ),
       splitLayout(cellWidths = c("70%", "30%"),
         textInput("combo_2", NULL, "B"),
         numericInput("size_2", NULL, 2, min = 0)
       ),
       splitLayout(cellWidths = c("70%", "30%"),
         textInput("combo_3", NULL, "A&B"),
         numericInput("size_3", NULL, 4, min = 0)
       ),

       tags$div(id = 'placeholder'),
       actionButton('insertBtn', 'Insert'),
       actionButton('removeBtn', 'Remove')
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("euler_diagram")
    )
  )
))




