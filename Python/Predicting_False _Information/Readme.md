# 🗞 Prediction of False Information

[![](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=darkgreen)](https://www.python.org)  [![](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=TensorFlow&logoColor=white)](https://www.tensorflow.org) [![](https://img.shields.io/badge/scikit_learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org/stable/) [![](https://img.shields.io/badge/Numpy-777BB4?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org) [![](https://img.shields.io/badge/Pandas-2C2D72?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org)  [![](https://img.shields.io/badge/Plotly-239120?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com) [![](https://img.shields.io/badge/Keras-D00000?style=for-the-badge&logo=Keras&logoColor=white)](https://keras.io) 
## Introduction

__Fake news__, or disinformation, is a growing problem in today's society. It can spread quickly through __social media__ and other online platforms, leading to confusion, mistrust, and even harm. In an effort to combat this issue, the use of __machine learning techniques__ for fake news detection has gained popularity. However, detecting fake news is a complex task that involves understanding the context, content, and intent of the information being shared.



## Challenges

There is a lot of text received by people in the form of __media__ and __news__. Understanding the text and giving it a vectorial representation before they could be used for machine learning reduces the spread of fake news. However, there are challenges that arise when trying to build an __end-to-end machine learning system__ which is capable of accurately predicting fake news. Below are some challenges that are faced for designing a fake news classifier:

1. Lack of high-quality labeled data
2. Evolving nature of fake news
3. Bias in the data
4. Limited generalizability
5. Ethical considerations

## Exploratory Data Analysis (EDA)

__Exploratory Data Analysis (EDA)__ is a critical process that allows us to delve into data to uncover meaningful patterns and gain valuable insights. These insights can be instrumental in informing business decisions or enabling data modification to more accurately mirror real-world situations. EDA was employed specifically to discern the quantity of 'fake news' entries within the data. By first enumerating the topics of all articles, it laid the groundwork for classifying texts as either real or fake. Furthermore, the EDA process was crucial in identifying any missing values within the data set.

We have successfully loaded a dataframe containing verified news stories. A preview of the first five entries in this data offers a glimpse into the type of information it houses. One notable feature is the 'subject' category, which provides insight into the topics of the news stories. Additionally, the dataframe includes a 'date' field, indicating when each news piece was originally published.

<img src = "https://github.com/suhasmaddali/Fake-News-Prediction/blob/main/Images/True%20news%20df.jpg"/>

In a similar vein, we're keen on examining the dataset comprised of fake news. It appears to have similar columns to the true news dataset. For the purpose of conducting a comprehensive machine learning analysis, we plan to merge these two datasets together.



A significant portion of our data is primarily made up of political news, with world news forming a smaller share. This distribution gives us a comprehensive understanding of the nature of our dataset, setting a solid foundation for our forthcoming machine learning analysis.



Our dataset predominantly features news categories like politics and left-news. In contrast, categories such as 'US_News', 'Government News', and 'Middle-east' are underrepresented, appearing less frequently compared to the other topics.



The majority of the entries in our dataset pertain to fake news, as compared to non-fake news. However, despite this disparity, the dataset appears to be fairly balanced. Consequently, there isn't a need to employ oversampling techniques to augment the number of samples from the underrepresented class.



__True news wordcloud:__ Wordclouds offer a visual depiction of word frequencies within different text prompts. The larger the size of a word in the wordcloud, the greater its likelihood of occurrence. Our analysis reveals that a significant proportion of words in our dataset are centered around Trump, Hillary, and Obama. This observation aligns with our previous findings, indicating that a majority of our samples originate from political news sources.



__Fake news wordcloud:__ The diagram presented below illustrates the frequency of words commonly associated with fake news. Notably, words like "say," "plan," and "Russian" are prevalent, often contributing to the falseness of such news articles. By examining this diagram, we can gain valuable insights into distinguishing between fake and genuine news based on the presence or absence of specific word patterns.



## Constraints

The model should be able to handle a diverse range of news articles, including those with different writing styles, language, and formats. It should also be able to adapt to changes in the way fake news is presented over time.

## Evaluation

The __performance__ of the model will be evaluated using standard classification metrics, such as precision, recall, and f1-score. The model will also be tested for its ability to generalize to unseen news articles.

* [__Accuracy__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.accuracy_score.html)
* [__Precision__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.precision_score.html)
* [__Recall__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.recall_score.html)
* [__F1 Score__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.f1_score.html)
* [__Classification Report__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.classification_report.html)
* [__Confusion Matrix__](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.confusion_matrix.html)

## Outcomes

* Using machine learning for fake news classification can result in the creation of a model that can automatically identify fake news and flag it for further review or moderation. 
* This can help to reduce the spread of __false__ or __misleading information__ and protect the integrity of online content.
* In general, well-trained machine learning models can be effective at identifying fake news with a high degree of accuracy. 

