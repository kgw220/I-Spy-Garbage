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

If the app does not work (perhaps after I am finished this project due to outdated versions of dependencies, I have screenshots of the app below, where I have the results of classification of a glass jar (classified as glass), and the classification of a random image of a hedgehog, to help demonstrate a popup of a lack of confidence when the majority class is not with 50% confidence. Though, given I only trained my model not on a bunch of random animals and such, you can certainly get some weird predictions if you don't upload the intended type of picture😏!

<img width="1278" alt="Screenshot_22" src="https://github.com/user-attachments/assets/693bc11c-c727-47b7-96d2-1ebfd853164c" />

<img width="1279" alt="Screenshot_23" src="https://github.com/user-attachments/assets/5b74d4fd-6db7-49db-85cb-5a2ca56e5556" />

##  Repo Overview & Instructions For Deployment

The whole script for the first part is in the format of an R notebook, and in fact, this project is completed in R, instead of the more popular option of using Python (however, I did use the python packages of keras/tensorflow in my R file). A notebook was used to make it easy to follow along with each step.

Please refer to either file regarding details for how the model is built, and all the required libraries/dependencies. Related files are in the `model` directory, and the raw notebook file is named `recycleModelBuilding.Rmd`.

If you want to run the raw R notebook file itself, then you need to have installed R and, ideally RStudio, the main IDE for R. For the packages I call at the beginning, you will need to use the command `install.packages("PACKAGENAME")` first. 

For properly getting keras and tensorflow to run, following the instructions linked here: https://tensorflow.rstudio.com/install/. You also would need to follow the instructions linked here to get MLFlow to work, which relies on the python installation: https://cran.r-project.org/web/packages/mlflow/readme/README.html

Note that the images used for training the CNN were refactored to fit my preference. I added the folders used for training and testing images based on how I changed the structure from kaggle.

For the second part, all files are in the `app` directory. I use a couple R scripts alongside some copied assets from the model building phase, since I wanted to put them all in a single directory for ease of access when running the app.

The scripts for the app are in the `ui.R` file and `server.R` file (split up since this is how shiny apps are to be setup). Again, you may need to install the packages first if you wanted to run the app yourself. 

Reference the `requirements.txt` file to see the versions of all the major dependencies used in this project. Something may not work in updated versions (e.g. a function becoming legacy), and overall some things are very finniky - These are the versions that ended up working for me in the end.

## Future Work/Updates

As of 6/1/2025, this project has been updated to be a bit better. I incorperated MLFlow into the model building process to make it more rigorous than my homemade version (but still needs improvement), and improved the overall code style and syntax to be more consistent. The RShiny app has been revamped with a better UI and I finally have fixed the broken functionality after many revisions!

At this point, I'm mostly limited by the power of my computer for future improvements (training the CNN takes a while). In particular, even after fine tuning, the model still suffers from being able to correctly classify miscelleous trash. Though, I may come back and add my own images of miscelleous trash to improve the accuracy of this category, among other things. I documented some TODOs toward the end of my notebook regarding ideal enhancements, mainly regarding the MLOPs side of the project. Though, I will admit, I probably will not return to this project for a while.

## License

Distributed under the MIT License. See LICENSE.txt for more information.
