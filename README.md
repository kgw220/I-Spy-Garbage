# I-Spy-Garbage

Say you want to throw something away, but are unsure on whether you can recycle it or not. Wouldn't it be nice if we could upload a picture of that thing and get the answer? That is the goal of this project!

Note that I used the data set linked here: https://www.kaggle.com/datasets/asdasdasasdas/garbage-classification
In essence, this methodology could be repeated with other sets of image, and actually gathering all the images can be quite tedious, which is why I used the kaggle data set to effectively skip this.

I have divided this project up into two parts.

In the first part, I built a (convolutional) neural network model that will allow us to classify the material of potential trash (cardboard, glass, metal, paper, plastic), with a final category of just general miscellaneous trash for anything that was not classified as a material that could be recycled. The whole script is in the format of an R notebook.

The second part of the project deploys the model in an RShiny app, so people can have a convenient way to actually use the model, instead of having to download R and have the raw script to run it. I do not use an R notebook file for this, and instead use a raw R script file, since this is needed to actually run the app. However, I have some comments scattered around the file to detail and explain the code logic.


