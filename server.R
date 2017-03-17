#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(eulerr)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  ## keep track of elements inserted and not yet removed
  inserted <- c()

  observeEvent(input$insertBtn, {
    btn <- input$insertBtn
    id <- paste0("txt", btn)
    insertUI(
      selector = "#placeholder",
      ## wrap element in a div with id for ease of removal
      ui = tags$div(
        splitLayout(cellWidths = c("70%", "30%"),
          textInput(paste0("combo_", id), NULL, NULL),
          numericInput(paste0("size_", id), NULL, NULL, min = 0),
          id = id
        )
      )
    )
    inserted <<- c(id, inserted)
  })

  observeEvent(input$removeBtn, {
    removeUI(
      ## pass in appropriate div id
      selector = paste0("#", inserted[length(inserted)])
    )
    updateTextInput(
      session,
      paste0("combo_", inserted[length(inserted)]),
      NULL,
      NA
    )
    updateNumericInput(
      session,
      paste0("size_", inserted[length(inserted)]),
      NULL,
      NA
    )

    inserted <<- inserted[-length(inserted)]
  })

  # Set up set relationships
  combos <- reactive({
    sets <- sapply(grep("combo_", x = names(input), value = TRUE),
                   function(x) input[[x]])
    size <- sapply(grep("size_", x = names(input), value = TRUE),
                   function(x) input[[x]])

    combos <- as.vector(size, mode = "double")

    names(combos) <- sets
    na.omit(combos)
  })

  euler_fit <- reactive({
    euler(combos(),
          input = input$input_type)
  })

  output$stats <- renderTable({
    f <- euler_fit()
    with(f, data.frame(Input = original.values,
                       Fit = fitted.values,
                       Error = region_error))
  }, rownames = TRUE, width = "100%")

  euler_plot <- reactive({

    plot(
      euler_fit(),
      key = input$key,
      fontface = switch(input$fontface,
                        Plain = 1,
                        Bold = 2,
                        Italic = 3,
                        "Bold italic" = 4),
      counts = input$counts,
      fill_opacity = input$opacity,
      lty = switch(input$borders,
                   Solid = 1,
                   Varying = c(1:6),
                   None = 0)
    )
  })

  output$euler_diagram <- renderPlot({
    euler_plot()
  })

  # Download the plot
  output$download_plot <- downloadHandler(
    filename = {
      paste("euler-", Sys.Date(), ".", input$savetype, sep = "")
    },
    content = function(file) {
      switch(input$savetype,
             pdf = pdf(file),
             png = png(file, type = "cairo", width = 648, height = 648))
      print(euler_plot())
      dev.off()
    })

})
