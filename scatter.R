suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(tidyverse))
get_words <- readLines("words.txt")
first_letter <- substring(get_words, 1, 1)
scatter_dat <- table(first_letter)
write.table(scatter_dat, "scatter.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)
