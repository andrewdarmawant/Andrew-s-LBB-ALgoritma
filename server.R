server <- function(input, output) {
    
    output$plot1 <- renderPlotly({
        vids_agg  <- vids %>% 
            group_by(category_id) %>% 
            summarise(likeratio = mean(likes/views),
                      dislikeratio = mean(dislikes/views),) %>% 
            mutate(favor = round(likeratio/dislikeratio,2))
        
        vids_agg_special <- vids_agg %>% 
            filter(category_id == "Gaming")
        
        plot_likability <- ggplot(vids_agg, aes(x=reorder(category_id,favor), 
                                                y=favor,
                                                text = glue("Category : {category_id}<br> likability : {favor}")))+
            geom_col(fill="dodgerblue4")+
            geom_col(data = vids_agg_special, fill="red")+
            coord_flip()+
            labs(x = "channel type", 
                 y = "like/dislike", 
                 title="Favorability Index by Video Category",
                 caption = "Source: Youtube 2018")+
            theme_saya
        
        ggplotly(plot_likability, tooltip = "text")
    })
    
    output$plot1_text <- renderText({
        print("Youtube has a way to show how people enjoy or are dissatisfied with a video through the use of Likes and dislikes. The following is a chart which provides how certain channels have more likes over dislikes than others")
    })
    
    output$plot2 <- renderPlotly({
        
        vids_agg_trend_1 <- vids %>% 
            group_by(category_id, publish_when) %>% 
            summarise(trending_time = mean(as.numeric(timetotrend)))%>% 
            filter(publish_when == input$timep)
      
        plot_trending_time_daily <- ggplot(data = vids_agg_trend_1, mapping = aes(x = reorder(category_id, trending_time), 
                                                                                  y = trending_time,
                                                                                  text = glue("Category : {category_id}<br> Time to trend : {trending_time}")))+
            geom_col(fill = "dodgerblue4",  show.legend = FALSE)+
            coord_flip()+
            labs(x = "category", 
                 y= "time to create a trend",
                 title = "time to trend per time of day",
                 caption = "Source: Youtube 2018")+
            scale_fill_brewer(palette = "Set1")+
            facet_wrap(~publish_when)+
            theme_minimal()+ 
            theme_saya +
            theme(legend.position = "none")
        
        ggplotly(plot_trending_time_daily, tooltip = "text")
    })
    
    output$plot2_text <- renderText({
        print("The following graph explains how people tend to create a trend at different lengths during different times of day.")
    })
    
    output$plot3 <- renderPlot({
        
        
        data_special_project <- vids %>% 
            filter(likesratio>=0.2 | dislikesratio>=0.1)
        
        plot_likes_vs_dislike_with_comment <- ggplot(data = vids, mapping = aes(x = likesratio,
                                                                                y = dislikesratio,
                                                                                size = comment_count)) +
            geom_jitter(aes(color=category_id)) +
            scale_color_viridis_d() +
            labs( title = "Like ratio vs Dislike ratio",
                  y = "Dislike ratio",
                  x = "Like ratio", 
                  color = "Category ID",
                  caption = "Source: Youtube 2018") +
            theme(legend.position = "top") +
            guides(size = F)+
            geom_label_repel(data = data_special_project, aes(label = channel_title, color = category_id), 
                             box.padding = 1, direction = "y", show.legend = F) + 
            theme_saya +
            theme(legend.position = "none")
        
        plot_likes_vs_dislike_with_comment
    })
    
    output$plot3_text <- renderText({
        print("The following graph shows how certain videos tend to be liked and some to be disliked.")
    })
    
    output$plot4 <- renderPlotly({
        data_special_project_view <- vids %>% 
            group_by(category_id) %>% 
            filter(views == max(views))
        
        
        plot_most_viewed_videopercategory <- ggplot(data = data_special_project_view, mapping = aes(x = reorder(category_id,views), 
                                                                                                    y= views,
                                                                                                    text = glue("Category : {category_id}<br> views = {views}<br> Video title: {title}")))+
            geom_col(fill = "blue") + 
            coord_flip()+
            labs(x= "views", 
                 y= "category",
                 title = "most viewed video per category",
                 caption = "Source: Youtube 2018")+
            theme_saya +
            theme(legend.position = "none")
        
        ggplotly(plot_most_viewed_videopercategory, tooltip = "text")
    })
    
    output$plot4_text <- renderText({
        print("The following graph provides context on how large certain videos can get for a certain category compared to others.")
    })
    
    output$data_raw <- renderDataTable({
        datatable(vids, options = list(scrollx = T))
    })
    
}


