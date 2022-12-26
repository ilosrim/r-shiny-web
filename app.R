library(shiny)
library(shinydashboard)
library(DT)

# Define UI for app that draws a histogram ----
ui <- dashboardPage( 
  dashboardHeader(title = "My dashboard"),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Iris", tabName = "iris", icon = icon("tree")),
      menuItem("Cars", tabName = "cars", icon = icon("car"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem("iris",
        box(plotOutput("correlation_plot"), width = 8),
        box(
          selectInput("features", "Features:",
                      c("Sepal.Width", "Petal.Length",
                        "Petal.Width")), width = 4
        )
      ),
      tabItem("cars",
        fluidPage(
          h1("Cars"),
          dataTableOutput("carstable")
        )
      )
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  output$correlation_plot <- renderPlot({
    plot(iris$Sepal.Length, iris[[input$features]],
         xlab = "Sepal length", ylab = "Feature")
  })
  
  output$carstable <- renderDataTable(mtcars)
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
