#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(eulerr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Area-proportional Euler diagrams with eulerr"),

  # Sidebar with a slider input for number of bins
  fluidRow(
    column(
      3,
      wellPanel(
        h3("Set relationships"),
        p("String together combinations by joining them
          with an ampersand (&)."),
        radioButtons(
          "input_type",
          "Type of relationships",
          c("Disjoint combinations" = "disjoint", "Unions" = "union")
        ),
        splitLayout(
          cellWidths = c("70%", "30%"),
          textInput("combo_1", NULL, "A"),
          numericInput("size_1", NULL, 5, min = 0)
        ),
        splitLayout(
          cellWidths = c("70%", "30%"),
          textInput("combo_2", NULL, "B"),
          numericInput("size_2", NULL, 3, min = 0)
        ),
        splitLayout(
          cellWidths = c("70%", "30%"),
          textInput("combo_3", NULL, "A&B"),
          numericInput("size_3", NULL, 2, min = 0)
        ),

        tags$div(id = "placeholder"),

        splitLayout(
          actionButton("insert_set", "Insert", width = "100%"),
          actionButton("remove_set", "Remove", width = "100%")
        )
      ),

      tableOutput("stats")
    ),

    column(
      6,
      plotOutput("euler_diagram", height = "500px")
    ),

    column(
      3,
      sliderInput("opacity", "Opacity", min = 0, max = 1, value = 0.4),
      splitLayout(
        checkboxInput("counts", "Show counts"),
        checkboxInput("key", "Legend")
      ),
      radioButtons(
        "fontface",
        "Font face",
        list("Plain", "Bold", "Italic", "Bold italic")
      ),
      radioButtons(
        "borders",
        "Borders",
        list("Solid", "Varying", "None")
      ),

      hr(),
      splitLayout(
        downloadButton("download_plot", "Save plot", width = "100%"),
        radioButtons(
          "savetype",
          NULL,
          list("pdf", "png"),
          inline = TRUE
        )
      )
    )
  )
))




