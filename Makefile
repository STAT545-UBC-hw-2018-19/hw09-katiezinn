#creating all requirements for report and report 2
all: report.html report2.html

clean:
	rm -f words.txt histogram.tsv histogram.png report.md report.html scatter.tsv scatter.png report2.md report2.html

report.html: report.rmd histogram.tsv histogram.png
	Rscript -e 'rmarkdown::render("$<")'

histogram.png: histogram.tsv
	Rscript -e 'library(ggplot2); qplot(Length, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf

histogram.tsv: histogram.r words.txt
	Rscript $<
	
#adding scatter.png, it's reliant on scatter.tsv
scatter.png: scatter.tsv
	Rscript -e 'library(ggplot2); qplot(first_letter, Freq, data=read.delim("$<")); ggsave("$@")'
	rm Rplots.pdf #removing Rplots

#making scatter.tsv
scatter.tsv: scatter.r words.txt
	Rscript $<

#creating an html document through markdown -- capturing dependencies
report2.html: report2.rmd scatter.tsv scatter.png
	Rscript -e 'rmarkdown::render("$<")'
	
words.txt: /usr/share/dict/words
	cp $< $@
	
# words.txt:
#	Rscript -e 'download.file("http://svnweb.freebsd.org/base/head/share/dict/web2?view=co", destfile = "words.txt", quiet = TRUE)'
