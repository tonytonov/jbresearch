FROM rocker/verse:latest
RUN apt-get -y update && apt-get install -y sqlite3 nano
RUN Rscript -e 'install.packages(c("RSQLite", "scales", "broom", "MASS"))'

## docker build --rm -t tonytonov/jbresearch .

## win:
## docker run -dp 8787:8787 -v /c/Users/Anton.Antonov/Dropbox/JetBrains:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined --name="jbresearch-instance" tonytonov/jbresearch
## docker start jbresearch-instance
## docker exec -i -t jbresearch-instance /bin/bash

## linux:
## docker run -dp 8787:8787 -v /home/tonytonov/Dropbox/JetBrains:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined --name="jbresearch-instance" tonytonov/jbresearch || docker start jbresearch-instance
## sudo docker attach jbresearch-instance
