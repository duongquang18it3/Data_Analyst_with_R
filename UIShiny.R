install.packages("shiny")
library(shiny)


#Basic layout
# ui = fluidPage(titlePanel("My favorite novels:"),
#                sidebarLayout(sidebarPanel(),
#                              mainPanel()))
# server = function(input, output) {
# }
# shinyApp(ui, server)


###Link 

# ui = fluidPage(sidebarLayout(sidebarPanel(
#   a("Click here!", href = "https://vku.udn.vn/")),
#   mainPanel()))
# server = function(input, output) {}
# shinyApp(ui, server)

########################## HTML 

# ui = fluidPage(titlePanel("Quang Handsome:"),
#                sidebarLayout(sidebarPanel(
#                  ("My favorite novels are:"),
#                  br(),
#                  h1(strong("The Kiterunner"), "a novel by", em("Khaled Hoseinni")),
#                  h2(strong("Jane Eyre"), "a novel by", code("Charolette Bronte")),
#                  strong(
#                    "The diary of a young girl",
#                    "by",
#                    span("Anne Frank", style = "color: yellow")
#                  ),
#                  div(strong("A thousand splendid suns"), "by Khaled Hoseinni", style = "color: green")
#                ),
#                mainPanel()))
# server = function(input, output) { }
# shinyApp(ui, server)
# # 
# #### Adding SliderInput

# ui = fluidPage(sidebarLayout(
# sidebarPanel(
# helpText("This questionnaire is subject to privacy."),
# textInput(inputId = "name", label = "Enter your name."),
# sliderInput(
# inputId = "age",
# label = "What is your age?",
# min = 1,
# max = 100,
# value = 25
# )
# ),
# mainPanel()
# ))
# server = function(input, output) { }
# shinyApp(ui, server)




# ui =  fluidPage(sidebarLayout(
#   sidebarPanel(
#     radioButtons(
#       inputId = "month",
#       label = "In which month are you born?",
#       choices = list(
#         "Jan - March" = 1,
#         "April - June" = 2,
#         "July - September" = 3,
#         "October - November" = 4
#       ),
#       selected = 1
#     ),
# 
#     numericInput(
#       inputId = "children_count",
#       label = "How many children do you have?",
#       value = 2,
#       min = 0,
#       max = 15
#     ),
# 
#     selectInput(
#       inputId  = "smoker",
#       label = "Are you a smoker?",
#       choices = c("Yes", "No", "I smoke rarely","Khong, toi chi hut 5 goi mot ngay"),
#       selected = "Yes"
#     ),
# 
#     checkboxInput(
#       inputId = "checkbox",
#       label = "Are you a human?",
#       value = FALSE
#     ),
# 
#     checkboxGroupInput(
#       inputId = "checkbox2",
#       label = "2 + 2 = ?",
#       choices = list(4, "Four", "IV", "None of the above")
#     )
# 
#   ),
#   mainPanel()
# ))
# server = function(input, output) { }
# shinyApp(ui, server)

#################################################################
#FluidRow

# ui =  fluidPage(
#   helpText(
#     "This questionnaire is subject to privacy. All the information obtained will be confidential."
#   ),
#   
#   
#   fluidRow(
#     column(4,textInput(inputId = "name", label = "Enter your name.")),
#     
#     
#     column(
#       4, sliderInput(
#         inputId = "age",
#         label = "What is your age?",
#         min = 1,
#         max = 100,
#         value = 25
#       )
#     ),
#     
#     column(
#       4, radioButtons(
#         inputId = "month",
#         label = "In which month are you born?",
#         choices = list(
#           "Jan - March" = 1,
#           "April - June" = 2,
#           "July - September" = 3,
#           "October - November" = 4
#         ),
#         
#         selected = 1
#       )
#     )
#   ),
#   
#   
#   fluidRow(column(
#     6, numericInput(
#       inputId = "children_count",
#       label = "How many children do you have?",
#       value = 2,
#       min = 0,
#       max = 15
#     )
#   ) )
# )
# server = function(input, output) { }
# shinyApp(ui, server)

################################################################
#Dealing with dates
# ui = fluidPage(dateInput(
# "bday",
# label = h2("Enter your Date of Birth"),
# value = "1985-01-01"
# ),
# verbatimTextOutput("text"))
# server = function(input, output) {
# output$text <- renderPrint({
# paste(input$bday, "was a blessed day!")
# })
# }
# shinyApp(ui, server)

#############################################################
#View data

# ui = fluidPage(titlePanel("Viewing data"),
# sidebarLayout(sidebarPanel(
# selectInput(
# inputId = "specie",
# label = "Select the flower specie",
# choices = c("setosa", "versicolor", "virginica"),
# selected = "setosa"
# )
# ),
# mainPanel(tableOutput("data"))))
# server = function(input, output) {
# output$data = renderTable({
# iris[iris$Species == input$specie, ]
# })
# }
# shinyApp(ui, server)

#############################################################
#Reactivity in Shiny

# ui <- fluidPage(
#   mainPanel(
#     numericInput("num_a", "Observations:", 10, 1, 500),
#     numericInput("num_b", "Observations:", 10, 1, 500),
#     textOutput("text_calc"))
# )
# server <- function(input, output){
#   formula <- reactive({
#     A <- input$num_a
#     B <- input$num_b
#     A*B
#   })
#   output$text_calc <- renderText({
#     paste("The result is =", formula())
#   })
# }
# shinyApp(ui = ui, server = server)

#############################################################
# ui <- fluidPage(
# sliderInput("slider", "Move to right or left", value = 3, 1, 5),
# numericInput("number", "Number", value = 3, 1, 5)
# )
# server <- function(input, output, session) {
# observe({
# updateNumericInput(session, "number", value = input$slider)
# })
# }
# shinyApp(ui = ui, server = server)

#############################################################
# Creating Plots

# ui =  fluidPage(titlePanel("Creating the plots!"),
#                 sidebarLayout(sidebarPanel(
#                   selectInput(
#                     inputId  = "characterstic",
#                     label = "Select the characterstic for which you want the histogram",
#                     choices = c("Sepal Length", "Sepal Width" ,
#                                 "Petal Length", "Petal Width"),
#                     selected = "Sepal Length"
#                   )
#                 ),
#               
#                 mainPanel(plotOutput("myplot"))))
# server = function(input, output) {
#   char = reactive({
#     switch(
#       input$characterstic,
#       "Sepal Length" = "Sepal.Length",
#       "Sepal Width" = "Sepal.Width",
#       "Petal Length" = "Petal.Length",
#       "Petal Width" = "Petal.Width"
#     )
#   })
#   output$myplot  = renderPlot({
#     hist(
#       iris[, char()],
#       xlab = input$characterstic,
#       main = paste("Histogram of", input$characterstic)
#     )
#   })
# }
# shinyApp(ui, server)

#############################################################
# Well Panel and Vertical Layout
# ui = fluidPage(titlePanel("Vertical layout"),
#                verticalLayout(wellPanel(
#                  sliderInput("n", "QQ Plot of normal distribution", 100, 1000,
#                              value = 500)
#                ),
#                plotOutput("plot1")))
# server = function(input, output) {
#   output$plot1 = renderPlot({
#     qqnorm(rnorm(input$n))
#   })
# }
# shinyApp(ui, server)

#############################################################
#Creating tabs
# ui =  fluidPage(titlePanel("Creating the tabs!"),
#                 sidebarLayout(sidebarPanel(
#                   radioButtons(
#                     inputId  = "characterstic",
#                     label = "Select the characterstic for which you want the summary",
#                     choices = c(
#                       "Mileage" = "mpg",
#                       "Displacement" = "disp",
#                       "Horsepower" = "hp",
#                       "Rear axle ratio" = "drat",
#                       "Weight" = "wt"
#                     ),
#                     selected = "mpg"
#                   )
#                 ),
#                 mainPanel(tabsetPanel(
#                   tabPanel("Summary", verbatimTextOutput("mysummary")),
#                   tabPanel("Boxplot", plotOutput("myplot"))
#                 ))))
# server = function(input, output) {
#   output$mysummary = renderPrint({
#     summary(mtcars[, input$characterstic])
#   })
#   
#   output$myplot  = renderPlot({
#     boxplot(mtcars[, input$characterstic], main = "Boxplot")
#   })
# }
# shinyApp(ui, server)

#############################################################
# Some more plots
# ui = fluidPage(
#   titlePanel("Death rates by Gender and area"),  
#   
#   sidebarLayout(
#     sidebarPanel(
#       selectInput("area", "Choose the area",
#                   choices = c("Rural", "Urban")),
#       br(),
#       selectInput("gender", "Choose the gender", choices = c("Male", "Female"))
#     ),
#     
#     mainPanel(plotOutput("deathrate"))
#     
#   )
# )
# server = function(input, output) {
#   output$deathrate <- renderPlot({
#     a = barplot(VADeaths[, paste(input$area, input$gender)],
#                 main = "Death Rates in Virginia",
#                 xlab = "Age Groups")
#     text(a,
#          y = VADeaths[, paste(input$area, input$gender)] - 2,
#          labels = VADeaths[, paste(input$area, input$gender)],
#          col = "black")
#   })
# }
# shinyApp(ui, server)

#############################################################
# Conditional Panels
# ui = fluidPage(
#   titlePanel("Conditional Panels"),
#   sidebarPanel(
#     numericInput("num","How many hours do you sleep?",min = 1,max = 24,value = 6)),
#   mainPanel(
#     conditionalPanel("input.num < 7","You need more sleep"),
#     conditionalPanel("input.num >= 9","You sleep a lot")
#   )
# )
# server = function(input,output){
#   
# }
# shinyApp(ui,server)

#############################################################
# Conditional Panels 2
# 
# income = read.csv("income.csv", stringsAsFactors = FALSE)
# ui = fluidPage(titlePanel(em("Conditional panels")),
#                sidebarLayout(
#                  sidebarPanel(
#                    selectInput(
#                      "Choice1",
#                      "Select the variable",
#                      choices = colnames(income)[3:16],
#                      selected = "Y2008"
#                    ),
#                    uiOutput("Out1")
#                  ),
#                  mainPanel(
#                    conditionalPanel("input.Choice2 === 'Summary'", verbatimTextOutput("Out2")),
#                    conditionalPanel("input.Choice2 === 'View data'", tableOutput("Out3")),
#                    conditionalPanel("input.Choice2 === 'Histogram'", plotOutput("Out4"))
#                  )
#                ))
# server = function(input, output) {
#   a = reactive({
#     income[, colnames(income) == input$Choice1]
#   })
#   output$Out1 = renderUI({
#     radioButtons(
#       "Choice2",
#       "What do you want to do?",
#       choices = c("Summary", "View data", "Histogram"),
#       selected = "Summary"
#     )
#   })
#   output$Out2 = renderPrint({
#     summary(a())
#   })
#   output$Out3 = renderTable({
#     return(a())
#   })
#   output$Out4 = renderPlot({
#     return(hist(a(), main  = "Histogram", xlab = input$Choice1))
#   })
# }
# shinyApp(ui = ui, server = server)

#############################################################
# Downloading Data
# ui =  fluidPage(titlePanel("Downloading the data"),
#                 sidebarLayout(sidebarPanel(
#                   radioButtons(
#                     "data",
#                     "Choose a dataset to be downloaded",
#                     choices = list("airquality", "iris", "sleep"),
#                     selected = "airquality"
#                   ),
#                   downloadButton("down", label = "Download the data.")
#                 ),
#                 mainPanel()))
# server = function(input, output) {
#   
#   # Reactive value for selected dataset ----
#   datasetInput = reactive({
#     switch(input$data,
#            "airquality" = airquality,
#            "iris" = iris,
#            "sleep" = sleep)
#   })
#   
#   # Downloadable csv of selected dataset ----
#   output$down = downloadHandler(
#     filename = function() {
#       paste(input$data, ".csv", sep = "")
#     },
#     content = function(file) {
#       write.csv(datasetInput(), file, row.names = FALSE)
#     }
#   )
#   
# }
# shinyApp(ui, server)
#############################################################
# Uploading a file

# ui = fluidPage(titlePanel("Uploading file in Shiny"),
#                sidebarLayout(
#                  sidebarPanel(
#                    fileInput(
#                      "myfile",
#                      "Choose CSV File",
#                      multiple = F,
#                      accept = ".csv"
#                    ),
#                    
#                    checkboxInput("header", "Header", TRUE),
#                    
#                    radioButtons(
#                      "choice",
#                      "Display",
#                      choices = c(Head = "head",
#                                  All = "all"),
#                      selected = "head"
#                    )
#                  ),
#                  
#                  mainPanel(tableOutput("contents"))
#                  
#                ))
# server = function(input, output) {
#   output$contents = renderTable({
#     req(input$myfile)
#     
#     data = read.csv(input$myfile$datapath,
#                     header = input$header)
#     
#     if (input$choice == "head") {
#       return(head(data))
#     }
#     else {
#       return(data)
#     }
#     
#   })
# }
# shinyApp(ui, server)

#############################################################
# Shiny App for Normality
ui =  fluidPage(titlePanel("My first App"),
                sidebarLayout(
                  sidebarPanel(
                    selectInput(
                      "varchoice",
                      "Choose the variable for which you want to check the normality",
                      choices = c("mpg", "disp", "drat", "qsec", "hp", "wt")
                    ),
                    radioButtons(
                      "normchoice",
                      "How do you want to check the normality?",
                      choices = c("Plots", "Tests"),
                      selected = "Plots"
                    ),
                    conditionalPanel(
                      "input.normchoice == 'Plots'",
                      selectInput(
                        "plotchoice",
                        "Choose which plot you want?",
                        choices = c("Histogram", "QQ-Plot")
                      )
                    )
                    
                    
                  ),
                  mainPanel(
                    conditionalPanel("input.normchoice == 'Plots'", plotOutput("myplot")),
                    conditionalPanel("input.normchoice == 'Tests'", verbatimTextOutput("mytest"))
                  )
                ))
server = function(input, output) {
  var = reactive({
    mtcars[, input$varchoice]
    
  })
  output$myplot =  renderPlot({
    if (input$plotchoice == "Histogram")
      return(hist(var(), main = "Histogram", xlab = input$varchoice))
    else
      return(qqnorm(var(), main = paste("QQ plot of", input$varchoice)))
  })
  output$mytest = renderPrint({
    shapiro.test(var())
  })
}
shinyApp(ui, server)
