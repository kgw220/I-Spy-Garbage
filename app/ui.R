###
# This file provides the ui relevant code for my CNN app.
###

library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)
library(fontawesome)

# Prevent scientific notation in the output
options(scipen = 999)

# Define the UI for our dashboard
ui <- dashboardPage(
  skin = "black",

  # Header where we set up the title and a link to my github page
  dashboardHeader(
    title = tags$div(
      style = "font-size: 20px; font-weight: bold; color: black;",
      "I Spy Garbage"
    ),
    titleWidth = 300,
    tags$li(
      class = "dropdown",
      tags$a(
        href = "https://github.com/kgw220",
        target = "_blank",
        style = "color: black; padding: 15px;",
        icon("github"),
        "GitHub"
      )
    )
  ),

  # Sidebar, where one uploads the image and all acceptable image formats
  dashboardSidebar(
    width = 300,
    tags$h4("Upload Image"),
    fileInput("input_image", "Choose a .jpg or .jpeg file", accept = c(".jpg", ".jpeg")),
    tags$hr(),
    tags$p("Upload a clear, cropped image of the object you want to classify.")
  ),

  # Body
  dashboardBody(
    # Custom styling for background and components
    tags$head(
      tags$style(HTML("
        .content-wrapper { background-color: #f4f6f9; }
        .box { box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
      "))
    ),

    # Instruction box
    fluidRow(
      box(
        title = "Instructions",
        status = "primary",
        solidHeader = TRUE,
        width = 12,
        tags$p("1. Take a picture of some potential trash, ideally with a background of one color."),
        tags$p("2. Crop image so that the object fills out most of the image."),
        tags$p("3. Upload image (.jpg or .jpeg) using the sidebar on the left.")
      )
    ),

    # Output image and prediction results side-by-side
    fluidRow(
      column(
        width = 6,
        box(
          title = "Uploaded Image",
          status = "info",
          solidHeader = TRUE,
          width = NULL,
          imageOutput("output_image")
        )
      ),
      column(
        width = 6,
        box(
          title = "Prediction Results",
          status = "success",
          solidHeader = TRUE,
          width = NULL,
          textOutput("warntext"),
          tags$br(),
          tags$p("This is most likely made of:"),
          tableOutput("text")
        )
      )
    )
  )
)
