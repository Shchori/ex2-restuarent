#installations
install.packages(c("jsonlite","ggplot2","ggmap"))
#load
library("ggmap") 
library("jsonlite")
library("ggplot2")

coord_x <- "32.077613"
coord_y <- "34.779109"

#data from json
url <- paste0("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=",coord_x,",",coord_y,"&radius=1500&type=restaurant&key=AIzaSyCpfikmNDhNWCE1nzKLMvJly1X4ccO8ogw&rankby=prominence")
jsonData <- fromJSON(url)
names(jsonData)

long <- jsonData$results$geometry$location$lng
lat <- jsonData$results$geometry$location$lat
what <-jsonData$results$name
rank<-(jsonData$results$rating)
data = data.frame (long, lat, what,rank)
boxplot(data$rank)
summary(data$rank)
map = ggmap::get_map(location = c(lon = mean(long), lat = mean(lat)), zoom = 15,
                     maptype = "roadmap", scale = 2)
# plotting the map with some points on it 
ggmap(map) +
  geom_point(data=data, aes(x = long, y = lat , colour = ifelse(rank>3,T,F), alpha = 0.8), size = 4, shape = 18,fill="white") +  guides(fill=FALSE, alpha=FALSE, size=TRUE)