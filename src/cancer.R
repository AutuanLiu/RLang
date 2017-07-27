loc <- "http:/archive.ics.uci.edu/ml/machine-learning-databases/"
ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc, ds, sep = "")

breast <- read.table(url, sep = ",", header = FALSE, na.string = "?")
names(breast) <- c("ID", "clumpThickness", "sizeUniformity", "shapeUniformity",
 "maginalAdhesion", "singleEpithelialCellSize", "bareNuclei", "blandChromatin",
  "normalNucleoli", "mitosis", "class")
df <- breast[-1]
df$class <- factor(df$class, levels = c(2, 4), labels = c("benign", "malignant"))
set.seed(1234)
train <- sample(nrow(df), 0.7 * nrow(df))
df.train <- df[train, ]
df.valodate <- df[-train, ]
table(df.train$class)
table(df.validate$class)