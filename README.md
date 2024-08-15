# I-Spy-Garbage

Say you want to throw something away, but are unsure on whether you can recycle it or not. Wouldn't it be nice if we could upload a picture of that thing and get the answer? That is the goal of this project!

Note that I used the data set linked here: https://www.kaggle.com/datasets/asdasdasasdas/garbage-classification .
In essence, this methodology could be repeated with other sets of image, and actually gathering all the images can be quite tedious, which is why I used the kaggle data set to effectively skip this.

I have divided this project up into two parts.

In the first part, I built a (convolutional) neural network model that will allow us to classify the material of potential trash (cardboard, glass, metal, paper, plastic), with a final category of just general miscellaneous trash for anything that was not classified as a material that could be recycled. The whole script is in the format of an R notebook, and in fact, this project is completed in R, instead of the more popular option of using Python (however, I did use the python packages of keras/tensorflow in my R file). 

I also included a knitted PDF of the notebook for easy access, if you cannot open the raw R notebook file. Please refer to either file regarding details for how the model is built, and all the required libraries/dependencies. The raw notebook file is named `recycleModelBuilding.Rmd`, and the knitted PDF is named `I Spy Garbage_Model Building.pdf`

If you want to run the raw R notebook file itself, then you need to have installed R and, ideally RStudio, the main IDE for R. For the packages I call at the beginning, you will need to use the command `install.packages("PACKAGENAME")` first. For properly getting keras and tensorflow to run, following the instructions linked here: https://tensorflow.rstudio.com/install/ . You will also need to do some basic setup with the image files from kaggle, which I detail at the start of the file.

With all that said, I will note , that this is my first project focusing around a neural network, so there are certainly lots of things I did not use or know, such as finding better and faster ways for refining the model. To some degree, this project in this first version could be seen as quite simple to some. I hope to come back to this project at a later date to implement new things as I learn them, and bring this project to the next level.

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The second part of the project deploys the model in an RShiny app, so people can have a convenient way to actually use the model, instead of having to download R and have the raw script to run it. I do not use an R notebook file for this, and instead use a raw R script file, since this is needed to actually run the app. However, I have some comments scattered around the file to detail and explain the code logic. The script for the app is in the `app.R` file, again, with all the required libraries/dependencies at the start.

The app itself is quite simple. Once the user uploads an image, the script sends it through the CNN we built and outputs a table with associated probabilities of each type of material, with the highest probability being the main choice by the model. 

However, given the limitations of my computer, I was not able to really fine tune the model super well, and there are bound to be cases where the highest probability is not that high. In the case where the highest probability is less than 50%, the app will output a message at the top displaying that it does not know the material for sure. 

The app link is attached here: https://kgw220.shinyapps.io/garbageclassificationapp/ . Hopefully it works, but there may be issues down the line that cause the link to not work. Again, I hopefully will fix such issues in future iterations of this project.

If the app does not work, I have screenshots of the app below, where I have the results of classification of some plastic grocery bags (labeled as trash since these cannot be recycled), and the classification of a random image of penguins (to demonstrate when the model cannot have over 50% probability for any given material).

<img width="778" alt="App1" src="https://github.com/user-attachments/assets/0d677070-159c-4a2d-849f-b853586a4385">

<img width="841" alt="App2" src="https://github.com/user-attachments/assets/b79e98b0-79a7-409b-8fd1-24d1255d4c24">
