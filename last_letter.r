get_words <- readLines("words.txt")
new_words <- stringr::str_to_lower(get_words) #convert all letters to lowercase
last_letter <- stringr::str_sub(new_words, -1) #pull out the last letter from every word
last_letter_dat <- table(last_letter)
write.table(last_letter_dat, "last_letter.tsv",
						sep = "\t", row.names = FALSE, quote = FALSE)
