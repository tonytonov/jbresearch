library(dplyr)
library(tidyr)
options(stringsAsFactors = FALSE)

avian_hab <- read.csv("raw_data/avianHabitat.csv")
avian_poi <- read.csv("raw_data/avianPointTransectSurvey.csv")

names(avian_hab)[-(1:4)][c(T,F)] <- paste0(c("DB", "W", "E", "A", "H", "L", "B"), ".P")
names(avian_hab)[-(1:4)][c(F,T)] <- paste0(c("DB", "W", "E", "A", "H", "L"), ".Ht")

avian_hab2 <- avian_hab %>%
  select(-Observer, -Subpoint) %>%
  group_by(Site) %>%
  summarise_each(funs(mean))

avian_poi2 <- avian_poi %>%
  group_by(Site, Common_name) %>%
  summarise(Vis = max(V1, V2, V3, na.rm = T))

avian <- left_join(avian_hab2, avian_poi2) %>%
  mutate(Site_name = gsub("[[:digit:]]+", "", Site),
         Site_num = extract_numeric(Site)) %>%
  select(1, 18, 19, 2:17)

avian$Common_name <- with(avian, reorder(Common_name, Vis, sum))
avian$Site_name <- with(avian, reorder(Site_name, Vis, sum))

write.csv(avian, "clean_data/avianJoined.csv", row.names = FALSE, quote = FALSE)
