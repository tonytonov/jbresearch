library(RSQLite)
options(stringsAsFactors = FALSE)

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname = "raw_data/avian.db")
res <- dbGetQuery(con, "select * from avian order by Site, Subpoint")
dbDisconnect(con)

#res$Site <- gsub("\\d", "", res$Site)
write.csv(res, "raw_data/avianHabitat.csv", row.names = FALSE, quote = FALSE)
