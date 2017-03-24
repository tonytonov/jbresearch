# Avian data: technical report
Anton Antonov  
March 24, 2017  



Here's the model!


```r
avian <- read.csv("../clean_data/avianJoined.csv")
reslm <- avian %>%
  group_by(Common_name) %>%
  do(tidy(stepAIC(lm(as.formula(paste0("Vis ~ ", paste(names(avian)[c(4:17)], collapse = " + "))), data=.), trace = F)))
reslm
```

```
## Source: local data frame [264 x 6]
## Groups: Common_name [48]
## 
##               Common_name        term estimate std.error statistic
##                     <chr>       <chr>    <dbl>     <dbl>     <dbl>
## 1  American Golden-Plover (Intercept)    0,165    0,1317      1,25
## 2  American Golden-Plover         L.P    0,231    0,0783      2,96
## 3  American Golden-Plover        L.Ht   -0,965    0,5536     -1,74
## 4  American Golden-Plover         B.P   -0,105    0,0596     -1,76
## 5          American Pipit (Intercept)    0,545    0,2575      2,12
## 6          American Pipit        DB.P   -0,720    0,1915     -3,76
## 7          American Pipit       DB.Ht    0,596    0,2541      2,34
## 8          American Pipit         W.P   -0,185    0,0978     -1,90
## 9          American Pipit         E.P    0,283    0,0931      3,04
## 10         American Pipit        E.Ht   -0,549    0,2836     -1,94
## # ... with 254 more rows, and 1 more variables: p.value <dbl>
```
