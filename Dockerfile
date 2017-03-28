FROM rocker/verse:latest
RUN apt-get -y update && apt-get install -y sqlite3 nano
RUN Rscript -e 'install.packages(c("RSQLite", "scales", "broom", "MASS", "plotly"))'
RUN git config --global user.name "Anton Antonov"
RUN git config --global user.email "tonytonov@gmail.com"
