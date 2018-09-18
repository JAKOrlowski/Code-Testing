
getwd()
#require(gitlabr)
require(dplyr)
require(tidyr)
require(ggplot2)
require(data.table)
require(ggrepel)
require(gridExtra)
require(grid)
require(ggpubr)
require(stringi)
options(scipen = 999)
#require(wesanderson)

#Load Reference tables
setwd("~/Desktop/ILO Industry Validation/")
ind_mapping_done <- read.delim(file = 'li_isic_industry_mappingxy.txt', sep = '\t', header = TRUE)
setwd("~/Desktop/Week1WB/reference_tables")
#country_ref <- read.delim(file = 'li_country_me.tsv', sep = '\t', header = TRUE)
#country_ref_optimal <- country_ref[,c("minor_continent","country_sk")]
#li_parent_skill_map <- read.delim(file = 'li_parent_skill_map.tsv', sep = '\t', header = TRUE)
country_ref_Income_WB <- read.csv("country_ref_Income_WB.csv")
#skill_transferability <- read.csv("Parent_Skill_Transferability.csv")

city_ref <- read.delim(file = 'li_city.tsv', sep = '\t', header = TRUE)
      city_ref_A <- city_ref[,c("region_sk","city_region","member_ct")]
      city_ref_A$region_a_sk <- city_ref_A$region_sk
      city_ref_A$region_a <- city_ref_A$city_region
      city_ref_A$mem_ct_a <- city_ref_A$member_ct
      city_ref_A$region_sk <- NULL
      city_ref_A$city_region <- NULL
      city_ref_A$member_ct <- NULL
      
      city_ref_B <- city_ref[,c("region_sk","city_region")]
      city_ref_B$region_b_sk <- city_ref_B$region_sk
      city_ref_B$region_b <- city_ref_B$city_region
      city_ref_B$region_sk <- NULL
      city_ref_B$city_region <- NULL
      
   
                
#Load Data sets
setwd("~/Desktop/Week1WB/datasets")

#Talent Migration
li_country_migration_2015_2017_avg.csv <- read.delim(file = 'li_country_migration_2015-2017_avg.tsv', sep = '\t', header = TRUE)
li_city_migration_2015_2017_avg.tsv <- read.delim(file = 'li_city_migration_2015-2017_avg-2.tsv', sep = '\t', header = TRUE)

#Company Hires
li_city_company_hires_AGG_2015_2017.tsv <- read.delim(file = 'li_city_company_hires_AGG_2015-2017.tsv', sep = '\t', header = TRUE)
li_country_company_hires_AGG_2015_2017.tsv <- read.delim(file = 'li_country_company_hires_AGG_2015-2017.tsv', sep = '\t', header = TRUE)

#Skill Migration
li_country_skill_migration_2015_2017_avg.tsv <- read.delim(file = 'li_country_skill_migration_2015-2017_avg.tsv', sep = '\t', header = TRUE)

#Skill/Industry Data
li_city_industry_det_skill_2013_2017.tsv <- read.delim(file = 'li_city_industry_det_skill_2013-2017-2.tsv', sep = '\t', header = TRUE)
li_country_industry_det_skill_2013_2017.tsv <- read.delim(file = 'li_country_industry_det_skill_2013-2017.tsv', sep = '\t', header = TRUE)

#Industry Levels
city_industry_level <- read.delim(file = 'li_city_industry_level_2014-2017.tsv', sep = '\t', header = TRUE)
li_country_industry_level_2014_2017<- read.delim(file = 'li_country_industry_level_2014-2017.tsv', sep = '\t', header = TRUE)






#li_oe_city_mapping <- read.delim(file = 'li_oe_city_mapping.tsv', sep = '\t', header = TRUE)
#ind_mapping <- read.delim(file = 'li_isic_industry_mapping.tsv', sep = '\t', header = TRUE)
#unique(ind_mapping$industry_name)
#ind_mapping <- ind_mapping %>% distinct(Industry_grp_sk)

#Renaming issues with industry group categories 
#colnames(ind_mapping)[7] <- "industry_grp_sk"
#ind_mapping$Industry_group_name <- as.character(ind_mapping$Industry_group_name)
#ind_mapping$Industry_group_name[ind_mapping$Industry_group_name == " Healthcare"] <- "Healthcare"
#ind_mapping$Industry_group_name[ind_mapping$Industry_group_name == "Wellness and Fitness"] <- "Wellness & Fitness"
#ind_mapping$Industry_group_name[ind_mapping$Industry_group_name == "Hardware & Netwoking"] <- "Hardware & Networking"
#ind_mapping$Industry_group_name <- as.factor(ind_mapping$Industry_group_name)


#li_parent_skill_map_revised <- read.delim(file = 'li_parent_skill_map.tsv', sep = '\t', header = TRUE)
#li_country_parent_skill_migration_2013_2017 <- read.delim(file = 'li_country_parent_skill_migration_2013-2017.tsv', sep = '\t', header = TRUE)
#li_country_migration_2013_2017<- read.delim(file = 'li_country_migration_2013-2017.tsv', sep = '\t', header = TRUE)
#li_country_industry_level_2014_2017<- read.delim(file = 'li_country_industry_level_2014-2017.tsv', sep = '\t', header = TRUE)
#li_country_company_hires_2013_2017<- read.delim(file = 'li_country_industry_hires_2013-2017.tsv', sep = '\t', header = TRUE)
#data_country_ind_skill <- read.delim(file = 'li_country_industry_parent_skill_supply_demand_2017.tsv', sep = '\t', header = TRUE)
#li_country_industry_det_skill_2016 <- read.delim(file = 'li_country_industry_det_skill_2016.tsv', sep = '\t', header = TRUE)


#li_country_det_skill_migration_AGG_2014_2017<- read.delim(file = 'li_country_det_skill_migration_AGG_2014-2017.tsv', sep = '\t', header = TRUE)

#li_city_industry_det_skill_2013_2017<- read.delim(file = 'li_city_industry_det_skill_2013-2017.tsv', sep = '\t', header = TRUE)

#dc_ind_skill_sd_17 <- read.delim(file = 'li_country_industry_parent_skill_supply_demand_2017.tsv', sep = '\t', header = TRUE)
#dc_city_ind_skill_sd_17 <- read.delim(file = 'li_city_parent_skill_supply_demand_2017.tsv', sep = '\t', header = TRUE)

#unique(city_company_hires$region_sk)

#city_company_hires <- read.delim(file = 'li_city_industry_company_hires_2013-2017.tsv', sep = '\t', header = TRUE)
#city_migration <- read.delim(file = 'li_city_migration_2013-2017.tsv', sep = '\t', header = TRUE)
#city_industry_level <- read.delim(file = 'li_city_industry_level_2014-2017.tsv', sep = '\t', header = TRUE)
#city_skill_migration <- read.delim(file = 'li_city_skill_migration_2013-2017.tsv', sep = '\t', header = TRUE) 
#city_migration_5yr_agg_2013_2017 <- read.delim(file = 'city_migration_5yr_agg_2013-2017.tsv', sep = '\t', header = TRUE)
#city_migration_5yr_agg_2013_2017$region_a <- as.character(city_migration_5yr_agg_2013_2017$region_a)
#city_migration_5yr_agg_2013_2017$region_a<- stri_trans_general(city_migration_5yr_agg_2013_2017$region_a,"Latin-ASCII")
#city_migration_5yr_agg_2013_2017$region_b <- as.character(city_migration_5yr_agg_2013_2017$region_b)
#city_migration_5yr_agg_2013_2017$region_b<- stri_trans_general(city_migration_5yr_agg_2013_2017$region_b,"Latin-ASCII")

#unique(li_country_industry_level_2014_2017$industry_sk)



#ind_grp_mappingxx <- ind_mapping[,c(5:8)]

#ind_grp_mappingxx <- unique(ind_grp_mappingxx)
#ind_grp_mappingxx <- na.omit(ind_grp_mappingxx)
#matching industry and country name and region
#li_country_industry_det_skill_2016<- left_join(li_country_industry_det_skill_2016, as.data.frame(ind_grp_mappingxx))


#li_country_industry_level_2014_2017<- left_join(li_country_industry_level_2014_2017, as.data.frame(ind_grp_mappingx))
#li_country_industry_level_2014_2017<- left_join(li_country_industry_level_2014_2017, as.data.frame(full_country_ref))
#li_country_industry_level_2014_2017 <- li_country_industry_level_2014_2017[,-c(4:6)]

# #Map industry groups and names to hire data
#ind_grp_mappingy <- ind_mapping %>% distinct(industry_grp_sk,Industry_group_name, industry_sk, industry_name)
#li_country_company_hires_AGG_2015_2017.tsv<- left_join(li_country_company_hires_AGG_2015_2017.tsv, as.data.frame(ind_grp_mappingy))

# #Removing country_sk 169 due to no associated country in reference table & adding minor continent information
#data_country_ind_skill<-data_country_ind_skill[!(data_country_ind_skill$country_sk==169),]
#data_country_ind_skill <- left_join(data_country_ind_skill, as.data.frame(country_ref_optimal))

#unique(data_country_ind_skill$country)

#setdiff(country_ref$country, li_country_industry_level_2014_2017$country)

#Quick Check of country differences between datasets and country reference
#setdiff(data_country_ind_skill$country_sk, li_country_industry_level_2014_2017$country_sk)
#setdiff(country_ref$country_sk, li_country_industry_level_2014_2017$country_sk)
#setdiff(country_ref$country_sk, dc_ind_skill_sd_17$country_sk)


#Define Regions
#East_Asia_Pacific <- subset(country_ref, country_sk %in% c(14,115,48,71,95,101,112,120,154,143,142,167,174,194,223,212,173,235))
#East_Asia_Pacific$region <- "East Asia and Pacific"
#Europe_Central_Asia <- subset(country_ref, country_sk %in% c(6,7,13,17,35,21,18,23,98,55,56,59,64,70,75,80,57,89,100,108,102,109,123,133,131,132,140,137,162,163,176,181,186,187,255,198,196,68,193,43,220,225,78,229))
#Europe_Central_Asia$region <- "Europe and Central Asia"
#Latin_America_Caribbean <- subset(country_ref, country_sk %in% c(11,31,29,30,46,49,50,52,61,63,205,91,99,97,110,153,161,170,183,171,179,221,228,232))
#Latin_America_Caribbean$region <- "Latin America and the Caribbean"
#Middle_East_North_Africa <- subset(country_ref, country_sk %in% c(62,24,65,107,106,103,111,121,125,134,149,135,168,184,189,206,217,2,239))
#Middle_East_North_Africa$region <- "Middle East and North Africa"
#North_America <- subset(country_ref, country_sk %in% c(37,227))
#North_America$region <- "North America"
#South_Asia <- subset(country_ref, country_sk %in% c(3,20,104,164,175,128))
#South_Asia$region<- "South Asia"
#Sub_Saharan_Africa <- subset(country_ref, country_sk %in% c(9,26,34,22,47,40,44,69,82,113,138,152,141,150,155,156,160,188,201,242,244,224,192,211,243,226))
#Sub_Saharan_Africa$region <- "Sub Saharan Africa"
#country_ref <- rbind(East_Asia_Pacific,Europe_Central_Asia,Latin_America_Caribbean,Middle_East_North_Africa,North_America,South_Asia,Sub_Saharan_Africa)

#country_ref$minor_continent <- country_ref$region
#country_ref$region <- NULL

