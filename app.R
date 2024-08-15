# make sure to set working directory to the directory holding app script and all other relevant folders/files

# importing all the relevant libraries
library(shiny)
library(shinydashboard)
library(rsconnect)
library(keras)
library(tensorflow)
library(tidyverse)

# loading the model we had trained
model <- load_model_tf("www/recycleModel")
load("www/label_list.R")
target_size <- c(224,224,3)
options(scipen=999) #prevent scientific number formatting

# Now we define the UI for our dashboard
ui <- dashboardPage(
  skin="black",
  
  #(1) Header where we set up the title and a link to my github page
  
  dashboardHeader(title=tags$h1("I Spy Garbage",style="font-size: 120%; font-weight: bold; color: blackinstall.packages('rsconnect')"),
                  titleWidth = 350,
                  tags$li(class = "dropdown"),
                  dropdownMenu(type = "notifications", icon = icon("question-circle", "fa-1x"), badgeStatus = NULL,
                               headerText="",
                               tags$li(a(href = "https://github.com/kgw220",
                                         target = "_blank",
                                         tagAppendAttributes(icon("icon-circle"), class = "info"),
                                         "Click this button to link to my github page!"))
                  )),
  
  
  #(2) Sidebar, where we specify to upload the image and all acceptable image formats
  
  dashboardSidebar(
    width=350,
    fileInput("input_image","File" ,accept = c('.jpg','.jpeg')), 
    tags$br(),
    tags$p("Upload the image here.")
  ),
  
  
  #(3) Body
  
  dashboardBody(
    
    h4("Instruction:"),
    tags$br(),tags$p("1. Take a picture of some potential trash, ideally with a background of one color."),
    tags$p("2. Crop image so that the object fills out most of the image."),
    tags$p("3. Upload image (.jpg or .jpeg) with the sidebar on the left. "),
    tags$br(),
    
    fluidRow(
      column(h4("Image:"),imageOutput("output_image"), width=6),
      column(h4("Result:"),tags$br(),textOutput("warntext",), tags$br(),
             tags$p("This is most likely made of:"),tableOutput("text"),width=6)
    ),tags$br()
    
  ))

# Here, we create a server object, which contains all the relevant code for the interactivity of the dashboard
server <- function(input, output) {
  
  # setup the image input
  image <- reactive({image_load(input$input_image$datapath, target_size = target_size[1:2])})
  
  # processing the input image through our model, and setting up how the output probabilities are shown
  prediction <- reactive({
    if(is.null(input$input_image)){return(NULL)}
    x <- image_to_array(image())
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255
    pred <- model %>% predict(x)
    pred <- data.frame("Material" = label_list, "Prediction" = t(pred))
    pred <- pred[order(pred$Prediction, decreasing=T),][1:5,]
    pred$Prediction <- sprintf("%.2f %%", 100*pred$Prediction)
    pred
  })
  
  output$text <- renderTable({
    prediction()
  })
  
  # Output that displays a warning if the highest predicted probability is under 50%
  output$warntext <- renderText({
    req(input$input_image)
    
    if(as.numeric(substr(prediction()[1,2],1,4)) >= 50){return(NULL)}
    warntext <- "Warning: I am not sure what this is made out of!"
    warntext
  })
  
  # The following renders the uploaded image and also deletes it immediately to avoid memory issues
  output$output_image <- renderImage({
    req(input$input_image)
    
    outfile <- input$input_image$datapath
    contentType <- input$input_image$type
    list(src = outfile,
         contentType=contentType,
         width = 400)
  }, deleteFile = TRUE)
  
}

# Run the application
shinyApp(ui, server)