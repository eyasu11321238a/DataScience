# 🚙 Car Prices Prediction 

[![[![](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=darkgreen)](https://www.python.org)  [![](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=TensorFlow&logoColor=white)](https://www.tensorflow.org) [![](https://img.shields.io/badge/scikit_learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org/stable/) [![](https://img.shields.io/badge/SciPy-654FF0?style=for-the-badge&logo=SciPy&logoColor=white)](https://www.scipy.org) [![](https://img.shields.io/badge/Numpy-777BB4?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org) [![](https://img.shields.io/badge/Pandas-2C2D72?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org)  [![](https://img.shields.io/badge/Plotly-239120?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com) [![](https://img.shields.io/badge/Keras-D00000?style=for-the-badge&logo=Keras&logoColor=white)](https://keras.io)

## Introduction

There are a lot of __car manufacturers__ in the US. With the development of manufacturing units and tests, there are a lot of cars being manufactured with a lot of features. Therefore, innovators are coming up with the latest developments in the field and they are ensuring that the drivers get the best experience going on a ride in these cars.

<img src = "https://media.wired.com/photos/59547e60ce3e5e760d52d429/191:100/w_1280,c_limit/02_Bugatti-VGT_photo_ext_WEB.jpg" width = 350 height = 200/><img src = "https://github.com/suhasmaddali/Images/blob/main/Car%20Prices%20Prediction%20GitHub%20Image.jpg" width = 350 height = 200/>

## Business Constraints / Key Performance Metrics (KPIs)

However, one of the challenging aspects of running the sales for cars is to accurately give the __best price__ for cars which ensures that a lot of people buy them and there is a great demand because of this price. Factors that influence the price of cars are __mileage__, __car size__, __manufacturer__, and many others as well. But for humans to comprehensively decide the price is difficult especially when there are a lot of these features that influence the price. One of the solutions to this challenge is to use __machine learning__ and __data science__ to understand insights and make valuable predictions that generate profits for the companies. 

## Machine Learning and Deep Learning

* __Machine Learning__ and __deep learning__ have gained rapid traction in the recent decade. 
* It would be really helpful if we can predict the prices of a car based on a few sets of features such as __horsepower__, __make__ and __other features__. 
* Imagine if a company wants to set the price of a car based on some of the features such as make, horsepower, and mileage. 
* It could do so with the help of machine learning models that would help it to determine the price of a car. 
* This would ensure that the company sets the right amount so that they get the most profits while setting such a price. 
* Therefore, the machine learning models that we would be working with would ensure that the right price is set for new cars which would save a lot of money for car manufacturers respectively.
* We would be working with the car prices prediction data and looking for the predictions of different kinds of cars. 
* We would be first visualizing the data and understanding some of the information that is very important for predictions. 
* We would be using different regression techniques to get the average price of the car under consideration.

<h2> Data Source</h2>

* We would be working with quite a large data which contains about __10000__ data points where again we would be dividing that into the training set and the test set.
* Having a look at some of the cars that we are always excited to use in our daily lives, it is better to understand how these cars are being sold and their average prices. 
* Feel free to take a look at the dataset that was used in the process of predicting the prices of cars. Below is the link.

__Source:__ https://www.kaggle.com/CooperUnion/cardataset

## Metrics

Predicting car prices is a __continuous machine learning problem__. Therefore, the following metrics that are useful for regression problems are taken into account. Below are the __metrics__ that was used in the process of predicting car prices.

* [__Mean Squared Error (MSE)__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_squared_error.html)
* [__Mean Absolute Error (MAE)__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_absolute_error.html)

## Exploratory Data Analysis (EDA)

In this section of the project, the data is explored to see the patterns and trends and observe interesting insights. Below are some interesting observations generated.

* A large number of cars were from the manufacturer __'Chevrolet'__ followed by __'Ford'__. 
* The total number of cars manufactured during the year __2015__ was the highest in all the years found on the data.
* There were many missing values for __'Market Category'__ feature and a few missing values for the features __'Engine HP'__ and __'Engine Cylinders'__.
* The average prices of the cars were the highest in the year __2014__ and lowest in the year __1990__ from the data. 
* The prices of __'Bugatti'__ manufacturer are extremely high compared to the other car manufacturers.  
* __'Bugatti'__ manufacturer also had an extremely high value for horsepower (HP) based on the graphs in the notebook.
* There is a __negative correlation__ between the feature __'City Mileage'__ and other features such as __'Engine Cylinders'__ and __'Engine HP'__. This is true because the higher the mileage of the car, there is higher the probability that the total number of cylinders and engine horsepower would be low. 

