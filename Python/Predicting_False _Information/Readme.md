# 🗞 Prediction of False Information

[![](https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=darkgreen)](https://www.python.org)  [![](https://img.shields.io/badge/TensorFlow-FF6F00?style=for-the-badge&logo=TensorFlow&logoColor=white)](https://www.tensorflow.org) [![](https://img.shields.io/badge/scikit_learn-F7931E?style=for-the-badge&logo=scikit-learn&logoColor=white)](https://scikit-learn.org/stable/) [![](https://img.shields.io/badge/Numpy-777BB4?style=for-the-badge&logo=numpy&logoColor=white)](https://numpy.org) [![](https://img.shields.io/badge/Pandas-2C2D72?style=for-the-badge&logo=pandas&logoColor=white)](https://pandas.pydata.org)  [![](https://img.shields.io/badge/Plotly-239120?style=for-the-badge&logo=plotly&logoColor=white)](https://plotly.com) [![](https://img.shields.io/badge/Keras-D00000?style=for-the-badge&logo=Keras&logoColor=white)](https://keras.io) 
📚 Introduction
Fake news—or disinformation—is an escalating issue in our society today. It spreads rapidly through social media and other online channels, leading to confusion, distrust, and potential harm. To address this challenge, machine learning techniques for detecting fake news are becoming increasingly popular. However, identifying fake news is intricate and requires an understanding of the context, content, and intent of the information being shared.

⚠️ Challenges
Understanding and representing text data effectively for machine learning is crucial to reducing the spread of fake news. However, developing an end-to-end machine learning system to accurately predict fake news involves several challenges:

📉 Lack of High-Quality Labeled Data: Limited availability of well-labeled datasets.
🔄 Evolving Nature of Fake News: Fake news constantly changes and adapts.
⚖️ Bias in the Data: Data may contain inherent biases.
🌍 Limited Generalizability: Models may not perform well across different contexts.
🤔 Ethical Considerations: Ensuring ethical use of data and algorithms.
🔍 Exploratory Data Analysis (EDA)
Exploratory Data Analysis (EDA) is essential for uncovering patterns and gaining insights from data. This process helps in making informed decisions and modifying data to better reflect real-world scenarios. Here’s how EDA was used in our project:

📊 Fake News Detection: We analyzed the data to determine the amount of 'fake news' and classified texts accordingly.
📅 Data Overview: The dataset includes a 'subject' category and 'date' field, revealing the topics and publication times of news articles.
We examined both true and fake news datasets, merging them for comprehensive machine learning analysis.

🗳️ Political News Dominance: A significant portion of the data consists of political news, with world news being less prevalent.
📉 Category Distribution: The dataset features categories like politics and left-news more frequently, while others like 'US_News', 'Government News', and 'Middle-east' are less common.
⚖️ Balanced Dataset: Despite a higher number of fake news entries, the dataset appears balanced, negating the need for oversampling techniques.
Wordcloud Analysis:

📰 True News Wordcloud: Highlights the most frequent words in true news articles. Prominent terms include Trump, Hillary, and Obama, reflecting the political focus of the dataset.
🚩 Fake News Wordcloud: Shows common words in fake news, such as "say," "plan," and "Russian," which often indicate falseness. This helps in distinguishing between fake and real news based on word patterns.
🔧 Constraints
The model must be capable of handling diverse news articles, accommodating various writing styles, languages, and formats. It should also adapt to evolving methods of presenting fake news over time.

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

