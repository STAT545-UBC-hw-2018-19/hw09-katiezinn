#creating all requirements for report 2.html
all: report2.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html last_letter.tsv last_letter.png report2.md report2.html

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
	
#adding last_letter.png, it's reliant on last_letter.tsv
last_letter.png: last_letter.tsv
	Rscript -e 'library(ggplot2); qplot(last_letter, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf #removing Rplots

#making last_letter.tsv with my r document
last_letter.tsv: last_letter.r words.txt
	Rscript $<

#creating an html document through markdown -- capturing dependencies
report2.html: report2.rmd last_letter.tsv last_letter.png
	Rscript -e 'rmarkdown::render("$<")'
	
words.txt: /usr/share/dict/words
	cp $< $@
	
# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
