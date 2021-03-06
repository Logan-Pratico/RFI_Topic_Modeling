# Topic Modeling RFI Responses

## Description
This code was created as a personal project in January 2022 for two purposes: (1) to improve my text mining, data cleaning, and analysis skills in both R and Python; and (2) to explore the capabilities of topic modeling in providing insight to Request for Information (RFI) responses. 

RFIs are typically posted by government agencies and seek information from the public regarding a particular subject matter. Responses are typically unstructured and can result in multiple hundreds of responses in certain cases. This code analyzes one corpus of RFI responses using topic modeling. The data preprocessing is performed using R and regular expressions. The model and visualizations are generated using Python.

Read the full write up with detailed discussion of the methodology, findings, conclusions, and limitations [here](https://drive.google.com/file/d/1TDK-OOx5TuLTfQ2hvUgXmm9Dtg8ADb0v/view?usp=sharing)

**Conclusions from this work:** Topic Modeling is not a viable way to assess RFI responses. Issues with data sparsity and quality prevent any valuable insight from being gleaned. Further research into whether other applications of Machine Learning and Natural Language Processing may provide better insight is needed.

## Understanding the Code

### Raw Data
The raw data used in this document is a semi-structured PDF document that contains public RFI responses submitted to the National Library of Medicine in response to ClinicalTrials.gov modernization. There are 261 total responses in the document, each of which contain section headers that provide insight as to which question posed in the RFI that the respondent is answering. The PDF file can be found in the data-raw folder.

### Data Cleaning
Data cleaning and manipulation is done in R. I use regular expressions to parse each RFI response by the heading associated with a particular question. I then organize each of the responses into distinct corpora based on the question that they are answering. From there, I save the resulting data as a text document for later use. 

### Data Analysis
I employ the python Machine Learning library 'scikit-learn' to analyze the data. The various parameters used to train the model are listed below:
 
Parameter Name | Description | Input Chosen
---|---|---
strip_accents | Removes accents and performs character normalization. Allows user to specify which character types to assess | unicode
stop_words | When set to ???english??? removes all filler words from a document that are not necessary to deduce the meaning. (IE: ???and???, ???it???, ???or??? etc.) | english
lowercase| Convert all characters to lowercase|True
token_pattern|Regular expression denoting which words should be included in the analysis|r'\b[a-zA-Z]{3,}\b'
max_df|gnore terms that have a document frequency above the given threshold (can either be a raw number or a proportion) |.6
min_df|Ignore terms that have a document frequency below a given threshold (can either be a raw number or a proportion)|20
ngram_range|The range of different word n-grams to be extracted. Setting the upper value to 2 will allow two-word keywords to be used in output|(1,2)

### Data Visualization
The output from the topic models is a series of visualizations generated using the python library pyLDAvis. You can view one of the visualizations generated by this project [here](https://htmlpreview.github.io/?https://github.com/Logan-Pratico/RFI_Topic_Modeling/blob/master/output/corpus_1/LDA_Visualization_question_20Topics.html). A full list of the visualizations generated from this report can be found in Appendix C of the writeup. Furthermore, and explanation on how to interpret these visualizations can be found in Appendix D.

## Getting Started
 
### Dependencies

* R libraries: dplyr, here, janitor, pdftools, stringr
* Python libraries: pyLDAvis, sklearn

### Installing

When pulling the repo, be sure to exclude the output from the pull. Otherwise a significant number of HTML files will be saved to your computer.

### Executing the Program

R code is best run in RStudio

Python code should be executed with the following arguments
* arg1: Path to directory containing documents
* arg2: Number of documents to be read into the model
* arg3: Number of topics to be output from the model

```
python3 model_reports_LDA.py /Path/to/Documents/ 230 15
```

## Authors
Logan Pratico

 
