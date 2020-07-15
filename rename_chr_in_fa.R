  #!/usr/bin/env Rscript 
  args = commandArgs(trailingOnly=TRUE)
  
  # test if there is at least 2 arguments: if not, return an error
  if (length(args)<2) {
      stop(paste("At least 2 arguments must be supplied:", "1. input.file", "2. replacements.file: \tname\treplacement", "* output.file is optional, since default is out.fna", sep="\n"), call.=FALSE)
  } else if (length(args)==2) {
    # default output file
    args[3] = "out.fna"
  } 
  
  ##program
  #current_dir <- paste0(gsub("\\", "/", fileSnapshot()$path, fixed=TRUE),"/")
  #current_dir <- getSrcDirectory(function(x) {x})
  
  library(here)
  
  input=here(args[1])
  replacements = read.table(here(args[2]), header=FALSE)
  output=here(args[3])
  chr_subs <- NULL
  for(i in 1:nrow(replacements)) {
    sub <- paste("-e 's/", replacements$V1[i], "/", replacements$V2[i],"/'", sep="")
    chr_subs <- paste(chr_subs, sub, sep=" ")
  }
  
  X <- paste("sed", chr_subs, input, ">", output, sep=" ")
  system(X)
  print("done")


#setwd("~/BIOINFO_FORMACION/miscellanea")
#input <- read.table("GRCm38.txt", header=TRUE)


#Refseq <- grep("NC_", input$RefSeq.Accn, value=TRUE)
#name <- input[grep("NC_", input$RefSeq.Accn),]$Assigned.Molecule
#replacements <- data.frame(ID=Refseq, replacement=name)
#write.table(replacements, "replacements.txt", col.names=FALSE, row.names=FALSE, quote=FALSE, sep="\t")


