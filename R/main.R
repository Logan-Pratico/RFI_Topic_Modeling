library(dplyr)
library(here)
library(janitor)
library(pdftools)
library(stringr)

x <- pdf_text(here("data-raw", "RFIConsolidatedComments.pdf")) %>% 
  paste0(collapse=" ")

x <- str_split(x, "Submission No.:") %>% unlist() 


i <- 1
oneA <- oneB <- oneC <- oneD <- twoA <- twoB <- twoC <- twoD <- twoE <- threeA <- threeB <- rep(NA, length(x))
vecs <- list(oneA, oneB, oneC, oneD, twoA, twoB, twoC, twoD, twoE, threeA, threeB)
segment <- c("1a\\. List specific examples of unsupported, .+ uses\\.",
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

while(i <= length(x)){
  
  segNum <- 1
  while(segNum <= length(segment)){
    if(grepl(segment[segNum], x[i])){
      #print("TESTING")
      vecs[[segNum]][i] <- gsub(paste0(".+",segment[segNum], "\n\n(.+?)[1-9][a-z].+"), "\\1", x[i])
      vecs[[segNum]][i] <- gsub(paste0(".+",segment[segNum], "\n\n(.+?)"), "\\1", vecs[[segNum]][i])
      
      vecs[[segNum]][i] <- gsub("(.*)2\\. Information Submission.+PRS\\)\\.(.*)","\\1 \\2", vecs[[segNum]][i])
      vecs[[segNum]][i] <- gsub("(.*)3\\. Data Standards.+on criteria\\)\\.(.*)","\\1 \\2", vecs[[segNum]][i])
      
    }
    
    segNum <- segNum + 1
    
    
    
  }
  
  i <- i + 1
}

i <- 1
while(i <= length(vecs)){
 # df <- data.frame(vecs[[i]])
 # colnames(df) <- "answer"
 # df <- df %>% filter(!is.na(answer))
  x <- 1
  p <- 1
  while(x <= length(vecs[[i]])){
    
    
    if(!is.na(vecs[[i]][x])){
      
      write.table(vecs[[i]][x], file = here("output", paste0("question_answers_", i), paste0(p, ".txt")), sep = "\t",
                  row.names = FALSE)
      p <- p + 1
    }

    x <- x + 1
  }
 
  #write.csv(df, here("output", paste0(i,"_Answers_Parsed_by_Question.csv")), row.names = F)
  i <- i + 1
  
}

