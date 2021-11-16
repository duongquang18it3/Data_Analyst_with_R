View(mtcars)
ui = fluidPage(titlePanel("Viewing data"),
               sidebarLayout(sidebarPanel(
                 selectInput(
                   inputId = "cyl",
                   label = "Select cyl car",
                   choices = c("4", "6", "8"),
                   selected = "setosa"
                 )
               ),
               mainPanel(tableOutput("data"))))

server = function(input, output) {
  output$data = renderTable({
    mtcars[mtcars$cyl == input$cyl, ]
  })
}
shinyApp(ui, server)