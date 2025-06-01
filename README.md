# I-Spy-Garbage

## Project Introduction
Say you want to throw something away, but are unsure on whether you can recycle it or not. Wouldn't it be nice if we could upload a picture of that thing and get the answer? That is the goal of this project!

## Dataset Information
I used the data set linked here: https://www.kaggle.com/datasets/asdasdasasdas/garbage-classification, which contains images of 5 types of recyclable material and a final category of miscellaneous trash. I also have gone ahead and manually split up the images into a 80/20 training/testing dataset (without randomization, but the order of images does not matter, so this should not add bias).

As a side note, this project could be repeated with other sets of images, and actually gathering all the images can be quite tedious, which is why I used the kaggle data set to effectively skip this. For a real world example, you could use for identifying efected products on a conveyer belt.

## Project Overview
I have divided this project up into two parts.

In the first part, I built a convolutional neural network model that will allow us to classify the material of potential trash (cardboard, glass, metal, paper, plastic), with a final category of just general miscellaneous trash for anything that was not classified as a material that could be recycled. 

The second part of the project deploys the model in an RShiny app, so people can have a convenient way to actually use the model, instead of having to download R and have the raw script to run it. 

### App Demo
The app itself is quite simple. Once the user uploads an image, the script sends it through the CNN we built and outputs a table with associated probabilities of each type of material, with the highest probability being the main choice by the model. In the case where the highest probability is less than 50%, the app will output a message at the top displaying that it does not know the material for sure. 

The app link is attached here: https://kgw220.shinyapps.io/garbageclassificationapp/. Hopefully it works, but there may be issues down the line that cause the link to not work. I hopefully will fix such issues in future iterations of this project.

If the app does not work (perhaps after I am finished this project due to outdated versions, I have screenshots of the app below, where I have the results of classification of some plastic grocery bags (labeled as trash since these cannot be recycled), and the classification of a random image of penguins (to demonstrate when the model cannot have over 50% probability for any given material).

<img width="778" alt="App1" src="https://github.com/user-attachments/assets/0d677070-159c-4a2d-849f-b853586a4385">

<img width="841" alt="App2" src="https://github.com/user-attachments/assets/b79e98b0-79a7-409b-8fd1-24d1255d4c24">


##  Repo Overview & Instructions For Deployment

The whole script for the first part is in the format of an R notebook, and in fact, this project is completed in R, instead of the more popular option of using Python (however, I did use the python packages of keras/tensorflow in my R file). A notebook was used to make it easy to follow along with each step.

Please refer to either file regarding details for how the model is built, and all the required libraries/dependencies. The raw notebook file is named `recycleModelBuilding.Rmd`, and the knitted PDF is named `I Spy Garbage_Model Building.pdf`

If you want to run the raw R notebook file itself, then you need to have installed R and, ideally RStudio, the main IDE for R. For the packages I call at the beginning, you will need to use the command `install.packages("PACKAGENAME")` first. For properly getting keras and tensorflow to run, following the instructions linked here: https://tensorflow.rstudio.com/install/. You also would need to follow the instructions linked here to get MLFlow to work, which relies on the python installation: https://cran.r-project.org/web/packages/mlflow/readme/README.html

Note that the images used for training the CNN were refactored to fit my preference. I added the folders used for training and testing images based on how I changed the structure from kaggle, but the file paths in the model building file need to be updated with the folders.

For the second part, I do not use an R notebook file for this, and instead use a raw R script file, since this is needed to actually run the app.

The script for the app is in the `app.R` file, again, with all the required libraries/dependencies at the start. Again, you may need to install the packages first if you for some reason needed to run the app yourself. 

Any other files in the repo are just the results from running many processes. In particular, I added my own explanation of how an CNN works for my own personal understanding in the `model` directory, but this of course is not necessary to run the project at all.

## Future Work

At this point, I'm mostly limited by the power of my computer for future improvements (training the CNN takes a while). Though, I may come back and add my own images of miscelleous trash to improve the accuracy of this category. I documented some TODOs toward the end of my notebook regarding ideal enhancements, mainly regarding the MLOPs side of the project.

## License

Distributed under the MIT License. See LICENSE.txt for more information.
