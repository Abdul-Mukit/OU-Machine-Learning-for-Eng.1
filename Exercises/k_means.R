library(stats)
library(cluster)

data <- read.csv("cereal_calories_cleaned.csv", header = TRUE)
subdata<-data[,4:16] # Excluding the columns 'name', 'mfr', 'type'
subdata_std<-scale(subdata,center=TRUE,scale=TRUE)

# Running K-means clustering for k = 2 to 10
avg_sil = {}
for(k in 2:10){
  results<-kmeans(subdata_std, k, iter.max=1000)
  sil<-silhouette(results$cluster, dist(subdata_std))
  plot(sil)
  avg_sil[k]<-mean(sil[,3])
}
barplot(avg_sil[-1], names.arg = 2:10, xlab = 'k', ylab = 'Sil. Value')
print('Best number of clusters:')
print(which(avg_sil==max(avg_sil[-1])))