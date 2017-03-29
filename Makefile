RDIR = .
RAW_DATA_DIR = $(RDIR)/raw_data
CLEAN_DATA_DIR = $(RDIR)/clean_data
REPORT_DIR = $(RDIR)/report
DEMO_DIR = $(RDIR)/demo

REPORT_SOURCE = $(wildcard $(REPORT_DIR)/*.Rmd)
REPORT_OUT_HTML = $(REPORT_SOURCE:.Rmd=.html)
REPORT_OUT_DOCX = $(REPORT_SOURCE:.Rmd=.docx)

KNIT_HTML = Rscript -e 'rmarkdown::render("$<", "html_document")'
KNIT_DOCX = Rscript -e 'rmarkdown::render("$<", "word_document")'

default: $(REPORT_OUT_HTML) $(REPORT_OUT_DOCX)

$(RAW_DATA_DIR)/avianHabitat.csv: $(RAW_DATA_DIR)/avian.db
	Rscript $(RAW_DATA_DIR)/gather_data.R

$(CLEAN_DATA_DIR)/avianJoined.csv: $(RAW_DATA_DIR)/avianHabitat.csv $(RAW_DATA_DIR)/avianPointTransectSurvey.csv
	Rscript $(CLEAN_DATA_DIR)/aggregate_data.R

%.html: %.Rmd $(CLEAN_DATA_DIR)/avianJoined.csv
	$(KNIT_HTML)

%.docx: %.Rmd $(CLEAN_DATA_DIR)/avianJoined.csv $(REPORT_DIR)/style_ref.docx
	$(KNIT_DOCX)

all: $(REPORT_OUT_HTML) $(REPORT_OUT_DOCX) $(DEMO_DIR)/jbresearch.html

docx: $(REPORT_OUT_DOCX)

html: $(REPORT_OUT_HTML)

demo: $(DEMO_DIR)/jbresearch.html

$(DEMO_DIR)/jbresearch.html: $(DEMO_DIR)/jbresearch.Rmd
	sudo Rscript -e 'rmarkdown::render("$<", revealjs::revealjs_presentation())'

clean:
	rm -frv $(RAW_DATA_DIR)/avianHabitat.csv
	rm -frv $(CLEAN_DATA_DIR)/avianJoined.csv
	rm -frv $(REPORT_OUT_HTML)
	rm -frv $(REPORT_OUT_DOCX)
	rm -frv $(REPORT_DIR)/*.md
	rm -frv $(REPORT_DIR)/*/
	rm -frv $(DEMO_DIR)/*/
