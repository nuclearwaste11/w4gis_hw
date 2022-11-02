#load packages
library(sf)
library(tidyverse)
library(countrycode)
library(tmap)
library(dplyr)
library(usethis)

use_github()

#load csv
gii <- read_csv("HDR21-22_Composite_indices_complete_time_series.csv")[,c("iso3","country","gii_2010","gii_2019")]

#create new column
gii$difference <- gii$gii_2019 - gii$gii_2010

#load shp
shape <- st_read("World_Countries__Generalized_.shp")

#use countrycode package to convert the name of column
shape$ISO <- countrycode(shape$ISO, origin = "iso2c", destination = "iso3c")

#join the data
gii_2010_2019 <- shape %>%
  merge(.,
        gii,
        by.x = "ISO",
        by.y = "iso3")

#quick map
gii_2010_2019 %>%
  qtm(.,fill = "difference")