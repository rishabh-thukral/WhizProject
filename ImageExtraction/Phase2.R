library("acepack")
library("e1071")
rm(list = ls())

#Get Data
sId <- 1:2000
sId <- paste0("SID",sId)
DataSet <- data.frame(matrix(nrow = 2000,ncol = 32),row.names = sId)
colnames(DataSet) <- paste0("F",(1:32))
number_of_qn <- 28
i<-1;
while(i < 33){
  DataSet[,i] <- round(rnorm(2000,mean = 10,sd = 5))
  DataSet[,1+i] <- DataSet[,1]*DataSet[,1] + DataSet[,1]
  DataSet[,2+i] <- round(exp(DataSet[,1]))
  DataSet[,3+i] <- number_of_qn * sigmoid(DataSet[,1])*sigmoid(DataSet[,3])
  i<-i+4
}
DataSet <- round(DataSet)
# DataSet <- scale(DataSet,center = FALSE,
#                  scale = apply(DataSet,2,max))
# 
# DataSet <- DataSet*number_of_qn

