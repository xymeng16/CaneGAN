source('model.R')

cancer_name <- c('GWAS/breast_cancer.txt','GWAS/ovarian_cancer.txt','GWAS/lung_cancer.txt','GWAS/prostate_cancer.txt')
cancer_short <- c('BC','OC','LC','PC')

for(i in 1:4){
  
  data <- read.table(cancer_name[i],header=T,stringsAsFactors = F)
  data <- data[,c('gene_symbol','pvalue')]
  pvalues <- data[,2]
  
  fused.v <- matrix(0,nrow = dim(data)[1],ncol=4)
  
  # Gene Network constructed from BioGrid Data
  genes <- read.table('gene.txt',stringsAsFactors = F)[[1]] #
  vects <- matrix(0,nrow = length(genes), ncol = 128)
  vec <- read.table('fusion/BioGrid.128.embed',skip=1)
  vects[vec[,1]+1,] <- as.matrix(vec[,2:dim(vec)[2]])
  genes <- genes[vec[,1]+1]
  vects <- as.matrix(vects[vec[,1]+1,])
  matched.idx <- which(!is.na(match(data[,1],genes)))
  v <- matrix(0,nrow=dim(data)[1],ncol=dim(vects)[2])
  v[matched.idx,] <- scale(as.matrix(vects[match(data[matched.idx,1], genes),]),center = T,scale = T)
  
  s <- sLDA(EMinfer(pvalues)$post, v)
  fused.v[,1] <- s
  
  # Gene Network constructed from ENCODE Data
  genes <- read.table('gene.txt',stringsAsFactors = F)[[1]]
  vects <- matrix(0,nrow = length(genes), ncol = 128)
  vec <- read.table('fusion/ENCODE.128.embed',skip=1)
  vects[vec[,1]+1,] <- as.matrix(vec[,2:dim(vec)[2]])
  genes <- genes[vec[,1]+1]
  vects <- as.matrix(vects[vec[,1]+1,])
  matched.idx <- which(!is.na(match(data[,1],genes)))
  v <- matrix(0,nrow=dim(data)[1],ncol=dim(vects)[2])
  v[matched.idx,] <- scale(as.matrix(vects[match(data[matched.idx,1], genes),]),center = T,scale = T)
  
  s <- sLDA(EMinfer(pvalues)$post, v)
  fused.v[,2] <- s
  
  # Gene Network constructed from GTEX Data
  genes <- read.table('gene.txt',stringsAsFactors = F)[[1]]
  vects <- matrix(0,nrow = length(genes), ncol = 128)
  vec <- read.table('fusion/GTEX.128.embed',skip=1)
  vects[vec[,1]+1,] <- as.matrix(vec[,2:dim(vec)[2]])
  genes <- genes[vec[,1]+1]
  vects <- as.matrix(vects[vec[,1]+1,])
  matched.idx <- which(!is.na(match(data[,1],genes)))
  v <- matrix(0,nrow=dim(data)[1],ncol=dim(vects)[2])
  v[matched.idx,] <- scale(as.matrix(vects[match(data[matched.idx,1], genes),]),center = T,scale = T)
  
  s <- sLDA(EMinfer(pvalues)$post, v)
  fused.v[,3] <- s
  
  # Gene Network constructed from HumanNet Data
  genes <- read.table('gene.txt',stringsAsFactors = F)[[1]]
  vects <- matrix(0,nrow = length(genes), ncol = 128)
  vec <- read.table('fusion/HumanNet.128.embed',skip=1)
  vects[vec[,1]+1,] <- as.matrix(vec[,2:dim(vec)[2]])
  genes <- genes[vec[,1]+1]
  vects <- as.matrix(vects[vec[,1]+1,])
  matched.idx <- which(!is.na(match(data[,1],genes)))
  v <- matrix(0,nrow=dim(data)[1],ncol=dim(vects)[2])
  v[matched.idx,] <- scale(as.matrix(vects[match(data[matched.idx,1], genes),]),center = T,scale = T)
  
  s <- sLDA(EMinfer(pvalues)$post, v)
  fused.v[,4] <- s
  
  # Save the results
  result <- model.LR(pvalues, as.matrix(fused.v), verbose = T)
  data[,'Score'] <- result$post
  Result <- data[order(data[,'Score'],decreasing = T),]
  save(Result, file = sprintf('result/%s.fused.bin',cancer_short[i]))
}


