FROM rocker/verse:latest
RUN apt-get -y update && apt-get install -y sqlite3 nano
RUN Rscript -e 'install.packages(c("RSQLite", "scales", "broom", "MASS"))'

## RUN git clone https://github.com/tonytonov/jbresearch.git
## docker build --rm -t tonytonov/jbproposal .
## docker run -dp 8787:8787 -v /c/Users/Anton.Antonov/Dropbox:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined tonytonov/jbproposal
## docker run -dp 8787:8787 -v /home/tonytonov/Dropbox:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined tonytonov/jbproposal
