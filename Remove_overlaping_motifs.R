#Compare two binding motif lists and eliminate motifs overlapping (>3bp), selecting the one with the higher p-value

#Load libraries:
library(Hmisc)

#Seach for groups of overlapping motifs
conflict <- rep(list(NULL),nrow(data))
for (i in 1:nrow(data)){
  for (j in 1:nrow(data)){
    index_i <- seq(data$start[i],data$stop[i],1) 
    if (data$name[i] != data$name[j]) {
      if (data$peak[i] ==   data$peak[j]) {
        index_j <- seq(data$start[j],data$stop[j],1)
        overlap <- intersect(index_i, index_j) 
        if(length(overlap)!=0){
          if (length(overlap) > 3) {
            conflict[[i]] <- c(i, conflict[[i]], data$name[j])
          }}}}}}

#Select the motif with higher pvalue for each conflicting group
item <- NULL
filtered <- Filter(Negate(is.null), conflict)
for(i in 1:length(filtered)) {
  index <- filtered[[i]]
  int <- data[index,]
  row <- subset(int, pvalue != min(data$pvalue[index]))
  item <- rbind(item,row)
}
conflicting <- item[!duplicated(item$name), ]
results <- subset(data, !(name %in% conflicting$name))