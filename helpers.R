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
  playoff <- data %>% filter(DivWin | WCWin)
  nonplayoff <- data %>% filter(!(DivWin | WCWin))
  
  #get top 8 non playoff teams per year to eliminiate skew of mean by the worst teams
  nonplayoff_top <- as.data.frame(nonplayoff %>% group_by(yearID) %>% top_n(8, winPercent))
  
  #final data to work with
  data <- rbind(playoff, nonplayoff_top) %>% arrange(yearID)
  
  return(data)
}

#### MEANDIFF FUNCTION ####
getMeanDiff <- function(df, statistic){
  mean(
    (
      df %>%
       select(yearID, madePlayoffs, one_of(statistic)) %>%
       spread_(key = "madePlayoffs", value = statistic) %>%
       summarise(diff=Yes-No)
    )$diff
  )
}

##### BARPLOT FUNCTIONS  #####
getBarPlotData <- function(masterData, summaryCols){
  barPlotData <- masterData %>%
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
plotBar <- function(df, yCol, lab, yFrom, yTo, yBy){
  xAxisTitle <- "Made Playoffs"
  roundYAxis <- 1
  background <- "#FFFFFF"
  
  if(yCol %in% c("OBP", "BA")) {
    roundYAxis <- 3
  } else if(yCol == "attendancePerGame"){
    roundYAxis <- 0
  }
  
  ggplot(df, aes_string(x="yearID", y=yCol)) +
    geom_bar(stat="identity", position = "dodge", aes_string(fill = "madePlayoffs")) +
    labs(x="Year", y=paste("Mean", lab)) +
    ggtitle(label = paste("Mean", lab), subtitle = "Non-playoff and playoff teams by year") +
    theme_fivethirtyeight() +
    theme(
      panel.spacing.x = unit(.2, "in"),
      panel.background = element_rect(fill = background),
      plot.background = element_blank(),
      plot.title = element_text(hjust = 0.5, size = 19),
      plot.subtitle = element_text(hjust = 0.5, size = 15, face = "italic"),
      axis.title = element_text(size = 14),
      axis.text.y = element_text(size = 12),
      axis.text.x = element_text(size = 12),
      legend.position = "right",
      legend.direction = "vertical",
      legend.background = element_rect(fill = background),
      legend.box.spacing = unit(0.05, "in"),
      legend.key.size = unit(.2, "in")
    ) +
    scale_fill_brewer(name = "Made Playoffs", palette = "Set1") +
    coord_cartesian(ylim=c(yFrom, yTo)) +
    scale_y_continuous(breaks = round(seq(yFrom, yTo, by = yBy), roundYAxis), labels = comma)
}

rnd <- function(x){trunc(x+sign(x)*0.5)}