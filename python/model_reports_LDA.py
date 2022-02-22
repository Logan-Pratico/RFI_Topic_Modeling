from __future__ import print_function
import pyLDAvis
import pyLDAvis.sklearn
import re
from sklearn.feature_extraction.text import CountVectorizer, TfidfVectorizer
from sklearn.decomposition import LatentDirichletAllocation
import csv
import sys

#useVals = csv.reader(open("/Users/logan/Documents/CRS_Topic_Modeling/output/S_T_Index.csv", 'r'), delimiter=",")
number_of_topics = int(sys.argv[3])
number_of_docs = int(sys.argv[2])
docs_raw = [None]*number_of_docs

i = 0
#while i < len(docs_raw):
#    text_file = open("/Users/logan/Documents/CRS_Topic_Modeling/output/strings/"+str(i+1)+"_rawText.txt", "r")
#    docs_raw[i] = text_file.read()
#    text_file.close()
#    print(docs_raw[i])
#    i = i + 1

while i < number_of_docs:
    text_file = open(str(sys.argv[1])+str(i+1)+".txt", "r")
    docs_raw[i] = text_file.read() 
   # docs_raw[i] =  re.sub("[^\s]+\.com", "", docs_raw[i])
   # docs_raw[i] =  re.sub("[^\s]+\.gov", "", docs_raw[i])
    text_file.close()
    #print(docs_raw[i][:4])
    i = i + 1

## Get data into string Array

tf_vectorizer = CountVectorizer(strip_accents = 'unicode',
                                stop_words = 'english',
                                lowercase = True,
                                token_pattern = r'\b[a-zA-Z]{3,}\b', #FIGURE OUT WHAT THIS MEANS 
                                max_df = .6, 
                                min_df = 20, 
                                ngram_range = (1,2))

dtm_tf = tf_vectorizer.fit_transform(docs_raw)

#tfidf_vectorizer = TfidfVectorizer(**tf_vectorizer.get_params())
#dtm_tfidf = tfidf_vectorizer.fit_transform(docs_raw)

lda_tf = LatentDirichletAllocation(n_components=number_of_topics, random_state=0)
lda_tf.fit(dtm_tf)

#lda_tfidf = LatentDirichletAllocation(n_components=number_of_topics, random_state=0)
#lda_tfidf.fit(dtm_tfidf)

visualization = pyLDAvis.sklearn.prepare(lda_tf, dtm_tf, tf_vectorizer, mds="pcoa")
#visualization_tfidf = pyLDAvis.sklearn.prepare(lda_tfidf, dtm_tfidf, tfidf_vectorizer, mds="pcoa")


pyLDAvis.save_html(visualization,str(sys.argv[1]) + "LDA_Visualization_question.html") 
#pyLDAvis.save_html(visualization_tfidf,"LDA_tfIDF_Visualization_reduced_numbers.html") 
