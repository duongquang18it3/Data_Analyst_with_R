library(dplyr)
library(tidyverse)
library(ggplot2)
library(shiny)
library(plotly)
library(countrycode)
library(gganimate)
install.packages("sf")
library(sf)
install.packages("rnaturalearth")
library(rnaturalearth)
install.packages("rnaturalearthdata")
library(rnaturalearthdata)

df <- read.csv('master.csv')
colnames(df)

names(df) <- c("Country","Year","Sex","Age","Suicides","Population","Suicides_per_100k",
               "Country_Year","HDI/Year","Year_GDP","GDP_Per_Capita","Generation")

glimpse(df)

df$Sex <- factor(df$Sex)
df$Age <- factor(df$Age)
df$Generation <- factor(df$Generation)
df$Country <- factor(df$Country)

df$Year_GDP <- as.numeric(gsub(",","",df$Year_GDP))

head(df)

tail(df)

summary(df)

ggplotly(df %>% group_by(Year) %>% summarise(TotalSuicides = sum(Suicides)) %>%
           ggplot(aes(x=Year,y=TotalSuicides))+geom_point(alpha=0.8,color="steelblue")+geom_line(color="blue")+theme(plot.title=element_text(hjust=0.5))+scale_x_continuous(breaks = seq(1985, 2015, 5))+labs(x="",y= "Total Suicides",title = "Worldwide Suicides View over Time"))

df <- df[!df$Year==2016,]

ggplotly(df %>% group_by(Year) %>% summarise(Suicides_Per_100k = sum(Suicides)/sum(Population)*100000) %>% filter(Year<=2015) %>%
           ggplot(aes(x=Year,y=Suicides_Per_100k))+geom_point()+geom_line()+scale_x_continuous(breaks = seq(1985, 2015, 5), minor_breaks = T)+labs(x="",y="Suicides per 100k",title = "Worldwide Suicides per 100k View over Time")+theme(plot.title=element_text(hjust=0.5)))

ui <-fluidPage(titlePanel(""),
               sidebarLayout(sidebarPanel(selectInput(inputId="year",label ="Year",choices=1985:2015)),
                             mainPanel(
                               fluidRow(column(width=6,plotOutput(outputId ="top5more" )),
                                        column(width=6,plotOutput(outputId = "top5less"))
                               )
                             ))
)

server <- function(input,output){
  output$top5more <- renderPlot({df %>% group_by(Year,Country) %>% summarise(Suicides_Per_100k = sum(Suicides)/sum(Population)*100000) %>% filter(Year== input$year) %>% slice_max(order_by=Suicides_Per_100k,n=5) %>% ggplot(aes(x=Country,y=Suicides_Per_100k,fill=Country))+geom_col()+scale_x_discrete(guide = guide_axis(n.dodge = 2))+labs(x="",y="Suicides Per 100k",title = "Countries with the highest suicide rates")+theme(plot.title=element_text(hjust=0.5),legend.position = "none")})
  output$top5less <- renderPlot({df %>% group_by(Year,Country) %>% summarise(Suicides_Per_100k = sum(Suicides)/sum(Population)*100000) %>% filter(Year==input$year) %>% slice_min(order_by=Suicides_Per_100k,n=5) %>% ggplot(aes(x=Country,y=Suicides_Per_100k,fill=Country))+geom_col()+labs(x="",y="Suicides Per 100k",title = "Countries with the lowest suicide rates")+scale_x_discrete(guide = guide_axis(n.dodge = 2))+theme(plot.title=element_text(hjust =0.5 ),legend.position = "none",)})
}

shinyApp(ui,server)

ggplotly(ggplotly(df %>% group_by(Year,Sex) %>% summarise(Suicides_Per_100k=sum(Suicides)/sum(Population)*100000) %>%
                    ggplot(aes(x=Year,y=Suicides_Per_100k,colour= Sex))+geom_point()+geom_line()+facet_grid( Sex ~.,scales="free_y")+labs(x="",y="Suicides per 100k", title = "Suicides over Time")+scale_x_continuous(breaks = seq(1985, 2015, 5))+theme(legend.position = "none",plot.title = element_text(hjust = 0.5))))

ggplotly(df %>% group_by(Year,Generation) %>% summarise(Suicides_Per_100k=sum(Suicides)/sum(Population)*100000) %>% filter(Year <=2015)%>% ggplot(aes(x=Year,y=Suicides_Per_100k,colour=Generation))+facet_grid(Generation ~.,scale = "free_y")+geom_line()+geom_point()+theme(legend.position = "none",plot.title = element_text(hjust = 0.5))+scale_x_continuous(breaks = seq(1985, 2015, 5), minor_breaks = T)+labs(x="",y="Suicides Per 100k",title="Evolution of the Suicides (per 100k) Numbers - Generations"))

df %>% group_by(Year,Age) %>% summarise(Suicides_Per_100k=sum(Suicides)/sum(Population)*100000) %>% filter(Year <=2015)%>% ggplot(aes(x=Year,y=Suicides_Per_100k,colour=Age))+facet_grid(Age ~.,scale = "free_y")+geom_line()+geom_point()+theme(legend.position = "none",plot.title = element_text(hjust = 0.5))+scale_x_continuous(breaks = seq(1985, 2015, 5), minor_breaks = T)+labs(x="",y="Suicides Per 100k",title="Evolution of the Suicides (per 100k) Numbers - Age")

df <- df %>% mutate(Continent=countrycode(Country,origin = "country.name",destination = "continent"))

df %>% group_by(Year,Continent) %>% summarise(Suicides_Per_100k=sum(Suicides)/sum(Population)*100000)%>% 
  filter(Year <=2015)%>% ggplot(aes(x=Year,y=Suicides_Per_100k,colour=Continent))+facet_grid(Continent ~.,scale = "free_y")+geom_line()+geom_point()+theme(legend.position = "none",plot.title = element_text(hjust = 0.5))+scale_x_continuous(breaks = seq(1985, 2015, 5), minor_breaks = T)+labs(x="",y="Suicides Per 100k",title="Evolution of the Suicides (per 100k) Number - Continent")

ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Suicides Number per 100k"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("year", "Year:", 
                  choices=unique(df$Year))),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("worldbarcontinent")  
    )
    
  )
)

server <- function(input,output){
  output$worldbarcontinent <- renderPlot(df %>% filter(Year== input$year) %>% group_by(Year,Continent) %>% summarise(Suicides_Per_100k=sum(Suicides)/sum(Population)*100000) %>% ggplot(aes(x=Continent,y=Suicides_Per_100k,fill=Continent))+geom_col()+theme(legend.position = "none",plot.title=element_text(hjust = 0.5))+labs(x="",y="Suicides per 100k",title = "Worlwide Suicides  by Continent")+scale_y_continuous(breaks = seq(0, 30), minor_breaks = F))
}
shinyApp(ui,server)

ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Suicides Number"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Region:", 
                  choices=unique(df$Country))),
    
    # Create a spot for the barplot
    mainPanel(
      plotlyOutput("countryplot")  
    )
    
  )
)






server <- function(input,output){
  output$countryplot <- renderPlotly(ggplotly(df %>% filter(Country==input$region) %>% ggplot(aes(x=Year,y=Suicides,colour=Generation))+geom_point()+geom_line()+facet_grid(.~Sex)+labs(x = "",y="Suicides",title="Suicides")+theme(plot.title = element_text(hjust = 0.5))))
  
}

shinyApp(ui,server)

ui <- fluidPage(titlePanel("Suicide Numbers Per 100k"),
                sidebarLayout(sidebarPanel(selectInput("region","Region",choices = unique(df$Country))),
                              mainPanel(plotlyOutput("country100kplot"))))


server <- function(input,output){
  output$country100kplot <- renderPlotly(ggplotly(df%>% filter(Country == input$region) %>% ggplot(aes(x=Year,y=Suicides_per_100k,colour=Generation))+geom_line()+labs(x="",y="Suicides",title = "")+theme(plot.title = element_text(hjust = 0.5))))
}

shinyApp(ui,server)

