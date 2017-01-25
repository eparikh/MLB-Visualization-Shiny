library(dplyr)
library(ggplot2)
library(tidyr)
library(scales)
library(ggthemes)
library(grid)
library(gridExtra)

#use function to prepare master data to use garbage cleanup
#rather than relying on access to rm() command
getMasterData <- function(){
  data <- readRDS(file = "data/Teams2005AndUp.rds")
  
  #separate by playoff vs nonplayoff
  playoff <- data %>%
    filter(DivWin | WCWin) %>%
    mutate(group = 1)
  
  #divide each nonplayoff team by top/bottom percentage by year
  #2 = top nonplayoff 1=bottom, but change to 3 so doesn't conflict with playoff teams
  nonplayoff <- data %>%
    filter(!(DivWin | WCWin)) %>%
    group_by(yearID) %>%
    mutate(group = ntile(winPercent, 2))
  
  nonplayoff[nonplayoff$group==1, ]$group = 3
  
  nonplayoff <- as.data.frame(nonplayoff)
  
  #final data to work with
  data <- rbind(playoff, nonplayoff) %>% arrange(yearID)
  
  return(data)
}

#### MEANDIFF FUNCTION ####
getDiff <- function(barPlotData, statistic, roundPlaces){
  data <- barPlotData %>%
    select(Year=yearID, madePlayoffs, one_of(statistic)) %>%
    spread_(key = "madePlayoffs", value = statistic) %>%
    summarise(Difference=Yes-No)
  
  m <- mean(data$Difference)
  
  data$Difference <- round(data$Difference, roundPlaces)
  
  # data <- as.data.frame(data)
  # rownames(data) <- data$Year
  # print(colnames(data))
  # data$Year <- NULL
    
  return(list(
    data = data,
    mean = m
  ))
}


##### BARPLOT FUNCTIONS  #####
getBarPlotData <- function(masterData, summaryCols, grps){
  barPlotData <- masterData %>%
    filter(group %in% grps) %>%
    group_by(yearID, madePlayoffs) %>%
    summarise_each(funs(mean), one_of(summaryCols))
  
  #min/max to calculate yaxis interval
  mins <- sapply(summaryCols, function(x){min(barPlotData[x])})
  maxes <- sapply(summaryCols, function(x){max(barPlotData[x])})
  yTicks <- (maxes-mins)/9
  
  return(list(
    data = barPlotData,
    mins = mins,
    maxes = maxes,
    yTicks = yTicks
  ))
}

#plot the chosen statistic by nonplayoff/playoff team by year
plotBar <- function(df, yCol, lab, yFrom, yTo, yBy, roundYAxis){
  xAxisTitle <- "Made Playoffs"
  background <- "#FFFFFF"
  
  ggplot(df, aes_string(x="yearID", y=yCol)) +
    geom_bar(stat="identity", position = "dodge", aes_string(fill = "madePlayoffs")) +
    labs(x="Year", y=paste("Mean", lab)) +
    #ggtitle(label = paste("Mean", lab) , subtitle = "Non-playoff and playoff teams by year") +
    theme_fivethirtyeight() +
    theme(
      panel.spacing.x = unit(.2, "in"),
      panel.background = element_rect(fill = background),
      plot.background = element_blank(),
      #plot.title = element_text(hjust = 0.5, size = 19),
      #plot.subtitle = element_text(hjust = 0.5, size = 15, face = "italic"),
      axis.title = element_text(size = 14),
      axis.text.y = element_text(size = 12),
      axis.text.x = element_text(size = 12),
      legend.position = "right",
      legend.direction = "vertical",
      legend.background = element_rect(fill = background),
      legend.box.spacing = unit(0.05, "in"),
      legend.key.size = unit(.2, "in")
    ) +
    scale_fill_manual(name = "Made Playoffs", values = c("#cc0000", "#000088")) +
    coord_cartesian(ylim=c(yFrom, yTo)) +
    scale_y_continuous(breaks = round(seq(yFrom, yTo, by = yBy), roundYAxis), labels = comma)
}

rnd <- function(x){trunc(x+sign(x)*0.5)}