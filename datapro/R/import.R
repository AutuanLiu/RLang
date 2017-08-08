
rtyu <- read_csv("D:/liuWork/data/single/s00308-2915-08-04-12-57n.hea.csv",
col_types = list(col_character(),
                 col_number(),
                 col_number(),
                 col_number(),
                 col_number()
))
 rtyu <- rtyu[-1, ]
colnames(rtyu) <- c("Time", "HR", "ABPSys", "ABPDias", "ABPMean")
# library(readr)
# s00369_2939_10_27_13_03n_hea <- read_csv("D:/liuWork/data/tpcs/s00369-2939-10-27-13-03n.hea.csv", 
#                                          col_types = cols(`'ABPDias'` = col_number(), 
#                                                           `'ABPMean'` = col_number(), `'ABPSys'` = col_number(), 
#                                                           `'HR'` = col_number()))
# View(s00369_2939_10_27_13_03n_hea)