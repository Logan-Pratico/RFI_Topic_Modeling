library(dplyr)
library(here)
library(janitor)
library(pdftools)
library(stringr)

## This document parses the data by question category



# Simple function to remove subquestions
removeSubQuestions <- function(doc){
   inc <- 1
   while(inc <= length(subSegment)){
      doc <- gsub(paste0("(.+)",subSegment[inc], "(.+)"), "\\1 \\2", doc)
      inc <- inc + 1
   }
   
   return(doc)
   
}




# read PDF of all responses
x <- pdf_text(here("data-raw", "RFIConsolidatedComments.pdf")) %>% 
  paste0(collapse=" ")

# Parse each response into its own element in a list
x <- str_split(x, "Submission No.:") %>% unlist() 
x <- x[-1]



# create an array for each question
i <- 1
one <- two <- three <- rep(NA, length(x))
vecs <- list(one, two, three)

# Regex of questions to be used for searches
segment <- c("1\\. Website Functionality\\. NLM s[^\\)]+\\)\\.",
             "2\\. Information Submission\\. NLM [^\\)]+\\)\\.",
             "3\\. Data Standards\\. NLM seeks .+[^\\)]+\\)\\."
            )


# Regex of subquestions to be used for searches
subSegment <- c("1a\\. List specific examples of unsupported, .+ uses\\.",
             "1b\\. Describe resources for p.+ useful\\.",
             "1c\\. Provide specific example.+ improvements\\.",
             "1d\\. Describe if your primary use of Clin.+you\\.",
             "2a\\. Identify steps.+ improvements\\.",
             "2b\\. Describe opportunities to better.+ tools\\.",
             "2c\\. Describe any novel or emerging .+ website\\.",
             "2d\\. Suggest what submission-r.+you\\.",
             "2e\\. Suggest ways to provide .+submission\\.",
             "3a\\. Provide input on ways to balance.+plan\\.",
             "3b\\. List names of and references.+ ClinicalTrials\\.gov\\.")

#separate count variables to increment when a hit is found for each question
count1 <- count2 <- count3 <- 1

while(i <= length(x)){

## The following code parses each document and looks for a particular question.
## When it finds a question, it further parses the document until only the response for that particular question remains.

 
 if(grepl(segment[1], x[i])){
    doc <- str_split(x[i], segment[1])
    if(grepl(segment[2], doc[[1]][2])){
       doc <- str_split(doc[[1]][2], segment[2])
       doc <- doc[[1]][1]
    }else if(grepl(segment[3], doc[[1]][2])){
       doc <- str_split(doc[[1]][2], segment[3])
       doc <- doc[[1]][1]
    }else{
       doc <- doc[[1]][2]
    }
    doc <- removeSubQuestions(doc)
    ## Write doc to text file
    write.table(doc, file = here("output", "main_question_answers", "main_question_answers_1", paste0(count1, ".txt")), sep = "\t",
                row.names = FALSE)
    count1 <- count1 + 1
 }

   if(grepl(segment[2], x[i])){
      doc <- str_split(x[i], segment[2])
     if(grepl(segment[3], doc[[1]][2])){
         doc <- str_split(doc[[1]][2], segment[3])
         doc <- doc[[1]][1]
      }else{
         doc <- doc[[1]][2]
      }
      
      doc <- removeSubQuestions(doc)
      ## Write doc to text file
      write.table(doc, file = here("output", "main_question_answers", "main_question_answers_2", paste0(count2, ".txt")), sep = "\t",
                  row.names = FALSE)
      count2 <- count2 + 1
   }
   
   if(grepl(segment[3], x[i])){
      doc <- str_split(x[i], segment[3])
      doc <- doc[[1]][2]
      ## Write doc to text file
      doc <- removeSubQuestions(doc)
      
      write.table(doc, file = here("output", "main_question_answers", "main_question_answers_3", paste0(count3, ".txt")), sep = "\t",
                  row.names = FALSE)
      count3 <- count3 + 1
   }
   
   
  
   
   
   
   
   
  i <- i + 1
}
