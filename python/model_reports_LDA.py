from __future__ import print_function
import pyLDAvis
import pyLDAvis.sklearn
import re
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.decomposition import LatentDirichletAllocation
import csv
import sys

#read in specific arguments from commandline
# arg1 = path to data
# arg2 = number of documents to be read
# arg3 = number of topics to be output

number_of_topics = int(sys.argv[3])
number_of_docs = int(sys.argv[2])
docs_raw = [None]*number_of_docs

## Read in documents from directory specified by user. documents should be labeled in format <number>.txt
i = 0
while i < number_of_docs:
    text_file = open(str(sys.argv[1])+str(i+1)+".txt", "r")
    docs_raw[i] = text_file.read() 
    text_file.close()
    i = i + 1


tf_vectorizer = CountVectorizer(strip_accents = 'unicode',# take out accents
                                stop_words = 'english',# words to be ignored
                                lowercase = True, #ignore case
                                token_pattern = r'\b[a-zA-Z]{3,}\b', #Read token pattern of characters in latin alphabet 
                                max_df = .6, # ignore words that appear in more than 2/3 of documents
                                min_df = 20, # ignore words that appear in less than 20 documents
                                ngram_range = (1,2)) # allow both unigrams and bi-grams

#fit and transform the documents based on the parameters
dtm_tf = tf_vectorizer.fit_transform(docs_raw)

# run the model
lda_tf = LatentDirichletAllocation(n_components=number_of_topics, random_state=0)
lda_tf.fit(dtm_tf)

# Format output and save to disk
visualization = pyLDAvis.sklearn.prepare(lda_tf, dtm_tf, tf_vectorizer, mds="pcoa")
pyLDAvis.save_html(visualization,str(sys.argv[1]) + "LDA_Visualization_question.html") 
