loc <- "http:/archive.ics.uci.edu/m1/machine-learning-databases/"
ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc, ds, sep = "")

breast <- read.table(url, sep = ",", header = FALSE, na.string = "?")
names(breast) <- c("ID", "clumpThickness", "sizeUniformity", "shapeUniformity",
 "maginalAdhesion", "singleEpithelialCellSize", "bareNuclei", "blandChromatin",
  "normalNucleoli", "mitosis", "class")