library(ggplot2)
library(cluster)
library(GGally)
library(arules)
library(arulesViz)
library(dplyr)
library(readxl)

setwd("C:/Users/cche436/OneDrive - The University of Auckland/703 Group Project/R Final")

#Importing Datasets
MergedDatasets <- read_excel("MergedDatasets.xlsx")
sample1<-MergedDatasets

#Removoving duplicates and removing string variables
sample1_filtered <- distinct(sample1)
str(sample1_filtered)
sample1_numeric <- sample1_filtered %>% 
  select(-'CountryName', -'CountryCode',-Year)

#Standardisation
sample1_scaled <- as.data.frame(scale(sample1_numeric))
summary(sample1_scaled)


## k-means clustering with 3 clusters
set.seed(703) 
kmeans_result <- kmeans(sample1_scaled, centers =3 )
print(kmeans_result) 
sample1_numeric$cluster <- factor(kmeans_result$cluster) 
head(sample1_numeric)
summary(sample1_numeric$cluster)

#silhouette_scores
silhouette_scores <- silhouette(kmeans_result$cluster, dist(sample1_scaled))
avg_silhouette_score <- mean(silhouette_scores[, 3])
print(avg_silhouette_score)

#Creating loop for finding best cluster
fits <- list()
scores <- numeric()
for (k in 2:10) {
  model <- kmeans(sample1_scaled, centers = k) 
  fits[[k]] <- model 
  silhouette_scores <- silhouette(model$cluster, dist(sample1_scaled))
  scores[k] <- mean(silhouette_scores[, 3]) 
}

#Plotting Silhouette Scores
scores_df <- data.frame(k = 2:10, silhouette_score = scores[2:10])
ggplot(scores_df, aes(x = k, y = silhouette_score)) +
  geom_line() +
  geom_point() +
  labs(title = "Silhouette Scores for Different Values of k",
       x = "Number of Clusters (k)",
       y = "Average Silhouette Score")

#Extracting Cluster 5
sample1_numeric$cluster <- factor(fits[[5]]$cluster)
summary(sample1_numeric$cluster)

# Adding cluster assignments to the filtered data set
sample1_filtered$cluster <- sample1_numeric$cluster

# Finding the cluster for Singapore
singapore_cluster <- sample1_filtered %>%
  filter(CountryCode == "SGP") 

print(singapore_cluster) 

#Boxplot of cluster with GDP
ggplot(sample1_filtered, 
       aes(x = cluster, y = GDPPerCapita)) +
  geom_boxplot(color = "white", fill = "#7C93C3", size = 0.8, fatten = 1) + # Adjusts the median line visibility
   labs(title = "Box Plot of GDP per Capita by Cluster", 
       x = "Cluster", 
        y = "GDP Per Capita") +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "#1E2A5E", color = NA), # Background color
    plot.background = element_rect(fill = "#1E2A5E", color = NA), # Plot background color
    panel.grid.major = element_line(color = "white"), # Major gridlines visible in white
    panel.grid.minor = element_line(color = "white", linetype = "dotted"), # Minor gridlines as dotted white lines
    text = element_text(color = "white"), # Text color for better contrast
    axis.text = element_text(color = "white"), # Axis text color
    axis.title = element_text(color = "white"), # Axis title color
    plot.title = element_text(color = "white", hjust = 0.5) # Centered title with white color
  )

#Boxplot of cluster with Skilled Labour
ggplot(sample1_filtered, 
       aes(x = cluster, y = SkilledLabour )) +
  geom_boxplot(color = "white", fill = "#7C93C3", size = 0.8, fatten = 1) + 
  labs(title = "Box Plot of Skilled Labout by Cluster", 
       x = "Cluster", 
       y = "Skilled Labour") +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "#1E2A5E", color = NA), # Background color
    plot.background = element_rect(fill = "#1E2A5E", color = NA), # Plot background color
    panel.grid.major = element_line(color = "white"), # Major gridlines visible in white
    panel.grid.minor = element_line(color = "white", linetype = "dotted"), # Minor gridlines as dotted white lines
    text = element_text(color = "white"), # Text color for better contrast
    axis.text = element_text(color = "white"), # Axis text color
    axis.title = element_text(color = "white"), # Axis title color
    plot.title = element_text(color = "white", hjust = 0.5) # Centered title with white color
  )

#Boxplot of cluster with Corporate Taxes
ggplot(sample1_filtered, 
       aes(x = cluster, y = CorporateTaxes )) +
  geom_boxplot(color = "white", fill = "#7C93C3", size = 0.8, fatten = 1) + 
    theme_minimal() +
  labs(title = "Box Plot of Corporate Taxes by Cluster", 
       x = "Cluster", 
       y = "Corporate Taxes") +
  theme(
    panel.background = element_rect(fill = "#1E2A5E", color = NA), # Background color
    plot.background = element_rect(fill = "#1E2A5E", color = NA), # Plot background color
    panel.grid.major = element_line(color = "white"), # Major gridlines visible in white
    panel.grid.minor = element_line(color = "white", linetype = "dotted"), # Minor gridlines as dotted white lines
    text = element_text(color = "white"), # Text color for better contrast
    axis.text = element_text(color = "white"), # Axis text color
    axis.title = element_text(color = "white"), # Axis title color
    plot.title = element_text(color = "white", hjust = 0.5) # Centered title with white color
  )


