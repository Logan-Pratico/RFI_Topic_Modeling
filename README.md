# Topic Modeling RFI Responses

## Description
This is the codebase used to parse and model topics for RFI responses submitted to NLM on ClinicalTrials.gov modernization. The data preprocessing is performed using R and regular expressions. The model and visualizations are generated using Python.

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

 
