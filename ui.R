dashboardPage(
              dashboardHeader(title = "Youtube Trends"),
              dashboardSidebar(
                  sidebarMenu(        
                      
                              menuItem(text = "Likes vs dislikes",
                                       tabName = "lvdl",
                                       icon = icon("th")
                              ),   
                              menuItem(text = "Timely likes", 
                                       tabName = "tl",
                                       icon = icon("smile")
                              ),
                              menuItem(text = "Best channels", 
                                       tabName = "bc",
                                       icon = icon("cubes")
                              ),
                              menuItem(text = "data", 
                              tabName = "dat",
                              icon = icon("dashboard")
                              )
                        )
                  ),
              
              dashboardBody(
                  tabItems(
                      tabItem(tabName = "lvdl",
                              h2("Like vs Dislike"),
                              textOutput(outputId = "plot1_text"),
                              plotlyOutput(outputId = "plot1"),
                              textOutput(outputId = "plot3_text"),
                              plotOutput(outputId = "plot3")
                                ),
                      tabItem(tabName = "tl",
                              h2("weekly likes"),
                              textOutput(outputId = "plot2_text"),
                              selectInput( 
                                  inputId = "timep",
                                  label = "choose time",
                                  choices = unique(vids$publish_when)
                              ),
                              plotlyOutput(outputId = "plot2")
                      ),
                      tabItem(tabName = "bc",
                              h2("best channel"),
                              textOutput(outputId = "plot4_text"),
                              plotlyOutput(outputId = "plot4")
                      ),
                      tabItem(
                          tabName = "dat",
                          h2("datasource"),
                          dataTableOutput(outputId = "data_raw")
                             )
                        )
                    )
)
