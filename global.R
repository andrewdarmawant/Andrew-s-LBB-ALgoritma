library(lubridate)
library(tidyverse)
library(plotly)
library(glue)
library(shiny)
library(shinydashboard)
library(ggrepel)
library(DT)

vids <- read.csv("youtubetrends.csv")

vids <- vids %>% 
  mutate(trending_date = ymd(trending_date),
         publish_time = ymd_hms(publish_time),
         likeability = likes/dislikes,
         comment_count = comment_count/views)

vids$likesratio <- vids$likes/vids$views
vids$dislikesratio <- vids$dislikes/vids$views

theme_saya <- theme( legend.title = element_text(size = 5, color = "black"),
                     legend.key = element_rect(fill="green"),
                     legend.background = element_rect(color="yellow", fill="#513438"),
                     plot.subtitle = element_text(size=8, color="white"),
                     panel.background = element_rect(fill="#bbbbbb"),
                     panel.border = element_rect(fill=NA),
                     panel.grid.minor.x = element_blank(),
                     panel.grid.major.x = element_blank(),
                     panel.grid.major.y = element_line(color="grey", linetype=3),
                     panel.grid.minor.y = element_blank(),
                     plot.background = element_rect(fill="#513433"),
                     text = element_text(color="white"),
                     plot.caption = element_text(color = "purple"),
                     axis.text = element_text(color="white")
)
options(scipen = 9999999)
