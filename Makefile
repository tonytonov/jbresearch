RDIR = .
RAW_DATA_DIR = $(RDIR)/raw_data
CLEAN_DATA_DIR = $(RDIR)/clean_data
REPORT_DIR = $(RDIR)/report

REPORT_SOURCE = $(wildcard $(REPORT_DIR)/*.Rmd)
REPORT_OUT_HTML = $(REPORT_SOURCE:.Rmd=.html)

KNIT = Rscript -e 'rmarkdown::render("$<", "html_document")'

$(RAW_DATA_DIR)/avianHabitat.csv: $(RAW_DATA_DIR)/avian.db
	Rscript $(RAW_DATA_DIR)/gather_data.R

$(CLEAN_DATA_DIR)/avianJoined.csv: $(RAW_DATA_DIR)/avianHabitat.csv $(RAW_DATA_DIR)/avianPointTransectSurvey.csv
	Rscript $(CLEAN_DATA_DIR)/aggregate_data.R

$(REPORT_OUT_HTML): $(REPORT_SOURCE) $(CLEAN_DATA_DIR)/avianJoined.csv
	$(KNIT)

default: $(REPORT_OUT_HTML)

all: $(REPORT_OUT_HTML)

clean:
	rm -frv $(RAW_DATA_DIR)/avianHabitat.csv
	rm -frv $(CLEAN_DATA_DIR)/avianJoined.csv
	rm -frv $(REPORT_DIR)/*.html
	rm -frv $(REPORT_DIR)/*.md
	rm -frv $(REPORT_DIR)/*/
