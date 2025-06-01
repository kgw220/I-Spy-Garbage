library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)
library(fontawesome) 

# Create a server object, which contains all the relevant code for the interactivity of the
# dashboard
server <- function(input, output) {
  # Setup the image input
  image <- reactive({
    image_load(input$input_image$datapath, target_size = target_size[1:2])
  })

  # Processing the input image through our model, and setting up how the output probabilities are
  # shown
  prediction <- reactive({
    if (is.null(input$input_image)) {
      return(NULL)
    }
    x <- image_to_array(image())
    x <- array_reshape(x, c(1, dim(x)))
    x <- x / 255
    pred <- model %>% predict(x)
    pred <- data.frame("Material" = label_list, "Prediction" = t(pred))
    pred <- pred[order(pred$Prediction, decreasing = TRUE), ][1:5, ]
    pred$Prediction <- sprintf("%.2f %%", 100 * pred$Prediction)
    pred
  })

  output$text <- renderTable({
    prediction()
  })

  # Output that displays a warning if the highest predicted probability is under 50%
  output$warntext <- renderText({
    req(input$input_image)
    if (as.numeric(gsub(" %", "", prediction()[1, 2])) >= 50) {
      return(NULL)
    }
    "⚠️ Warning: I am not confident about the material classification!"
  })

  # The following renders the uploaded image and also deletes it immediately to avoid memory issues
  output$output_image <- renderImage(
    {
      req(input$input_image)
      outfile <- input$input_image$datapath
      contentType <- input$input_image$type
      list(
        src = outfile,
        contentType = contentType,
        width = 400
      )
    },
    deleteFile = TRUE
  )
}
