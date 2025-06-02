###
# This file provides all the relevant code for the server part of my CNN app (involving hosting it
# onto shiny, and also actually predicting the type of material from an image with my model from my
# model directory).
###

library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)
library(fontawesome)

model <- tf$saved_model$load("final_CNN_model")
predict_fn <- model$signatures[["serving_default"]]
load("label_list.R")
target_size <- c(224, 224, 3)

# Create a server object, which contains all the relevant code for the interactivity of the
# dashboard
# NOTE: I use an approach to directly use TensorFlow instead of using the built in image_load()
# function from keras in an effort to avoid several issues which I had to deal with when debugging.

server <- function(input, output) {
  # Setup the image input
  image <- reactive({
    req(input$input_image)

    img_raw <- tf$io$read_file(input$input_image$datapath)
    img <- tf$image$decode_jpeg(img_raw, channels = 3L)
    img <- tf$image$resize(img, size = as.integer(target_size[1:2]))

    img
  })

  # Processing the input image through our model, and setting up how the output probabilities are
  # shown
  # NOTE: Again, the tensor created above is used for the prediction
  prediction <- reactive({
    if (is.null(input$input_image)) {
      return(NULL)
    }

    x <- image() %>% tf$cast(dtype = tf$float32) / 255
    x <- tf$expand_dims(x, axis = 0L)

    output <- predict_fn(x)
    output_array <- as.array(output[[1]])

    pred <- data.frame("Material" = label_list, "Prediction" = t(output_array))
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
