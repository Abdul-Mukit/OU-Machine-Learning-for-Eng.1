library(kohonen)
library(cluster)
library(stats)

data <- read.csv("cereal_calories_cleaned.csv", header = TRUE)
subdata<-data[,4:16] # Excluding the columns 'name', 'mfr', 'type'
subdata_std<-scale(subdata,center=TRUE,scale=TRUE)

# SOM Classification
som_model<-som(subdata_std,somgrid(4,4,"hexagonal"),rlen=100000)

# Plot SOM Results
plot(som_model,type="changes")
plot(som_model,type="counts")
plot(som_model,type="codes")

shadesOfGrey<-colorRampPalette(c("grey75","grey0"))
plot(som_model,type="dist.neighbours", palette.name = shadesOfGrey)
plot(som_model,type="mapping")
plot(som_model,type="quality")
names(som_model)

# Plot Silhouette
sil<-silhouette(som_model$unit.classif,dist(subdata_std))
windows()
plot(sil)

# Hiarchial Clustering using the Trained Neurons
d<-dist(som_model[["codes"]][[1]])
results<-hclust(d)
par(mfrow = c(1, 2))
plot(som_model,type="dist.neighbours", palette.name = shadesOfGrey)
plot(results)


# Cutting dendogram by setting k
results_k_cut = cutree(results, k = 2:5)

# Cutting dendograms by setting height
results_h_cut = cutree(results, h = tail(results$height, 5))








