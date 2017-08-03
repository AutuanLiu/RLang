rtyu <- read_csv("D:/liuWork/data/single/s00308-2915-08-04-12-57n.hea.csv", 
col_types = cols(`'ABPDias'` = col_number(), 
`'ABPMean'` = col_number(), `'ABPSys'` = col_number(), 
`'HR'` = col_number()))
rtyu <- rtyu[-1, ]