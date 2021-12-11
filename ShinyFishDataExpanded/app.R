library(shiny)
library(tidyverse)
library(shinythemes)
library(shinyWidgets)
library(ggthemes)

Fry_thermal_maximum <- read_csv("Fry_thermal_maximum.csv", 
                                col_types = cols(`Fish ID` = col_character(),
                                                 `dropout time` = col_time(format = "%H:%M:%S"), 
                                                 `Acclimation temp C` = col_character(), 
                                                 `fork length (mm)` = col_double(),
                                                 `Mass (g)`= col_double(),
                                                 `Dropout temp` = col_double(), 
                                                 `Test type` = col_character()))

ui <- navbarPage(theme = shinytheme("sandstone"),
                 fluid = TRUE,
                 footer = "Shiny fish data, expanded",
                 windowTitle = "Shiny fish data",
                 
                 ("Fishy Data, Expanded"), 
                 tabPanel("Welcome",h3(div(p("This is an app that allows the exploration of mass, length, and swim performance of Chinook salmon under different thermal regimes. The video below demonstrates the swim trial."),
                                           br(),
                                           p("This new site has an expanded dataset which now includes the results of two experiment types. With this, there is an additional filtering option to include both acclimation temperature and test type. Stationary refers to a tradiditonal critical thermal maximum protocol and Swim refers to results from a swim flume trial."),
                                           br(), 
                                           p("Navigate the above tabs to interact with histograms boxplots, the overall dataset, and watch fish swim below!"),
                                           style="color:green; font-family: 'times'")),
                          tags$iframe(width="1120", height="630", src="https://www.youtube.com/embed/VHz4yGZHGiA", frameborder="0", allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture", allowfullscreen=NA) ),
                 
                 tabPanel("Histograms",
                          sidebarLayout(
                              sidebarPanel( h3(" In order to begin, select a test type and acclimation temperature."),
                                            sliderInput("id_slider", "Select mass",
                                                        min = 0.2, max = 1, value = c(0.5, 0.6), post = " g"),
                                            prettyCheckboxGroup(
                                                "id_checkbox1", "Select acclimation temperature", 
                                                choices= unique(Fry_thermal_maximum$`Acclimation temp C`),
                                                inline = TRUE,
                                                fill = TRUE,
                                                status = "success"),
                                            prettyCheckboxGroup(
                                                "id_checkbox2", "Select test type", 
                                                choices= unique(Fry_thermal_maximum$`Test type`),
                                                inline = TRUE,
                                                fill = TRUE,
                                                status = "success")),
                              
                              mainPanel(tabsetPanel
                                        (uiOutput("myrandom"),
                                            tabPanel("Fork length", 
                                                     br(),
                                                     h4(p("With this histogram, you can sort through the data by looking at the distribution of fork lengths as a function of mass and acclimation temperature")), 
                                                     br(),
                                                     plotOutput(outputId="id_forklength")),
                                            tabPanel ("Drop out temperature",
                                                      br(),
                                                      h4( p("With this histogram, you can sort through the data by looking at the distribution of dropout temperatures as a function of mass and acclimation temperature")),
                                                      br(),
                                                      plotOutput(outputId="id_dropouttemp")),
                                            tabPanel("Interactive table", 
                                                     br(),
                                                     h4(p("Here you can use the slider to sort through the data by mass and acclimation temperature. ")), 
                                                     br(),
                                                     tableOutput("id_table")))))),
                 
                 navbarMenu("Data",
                            tabPanel("Data table",
                                     br(),
                                     h4( p("This data table represents the results for both swim and static thermal tolerance trials. The column 'test type' denotes 'swim' for swim trial data and 'stat' for static thermal tolerance data. Fish ID has also been updated to reflect this. Any ID with '_s' denotes a fish from a static thermal tolerance trial. ")),
                                     dataTableOutput("Fry_thermal_maximum")),
                            tabPanel("Download data",
                                     downloadBttn('downloadData',
                                                  label = "Download",
                                                  style = "stretch",
                                                  color = "success",
                                                  size = "md",
                                                  block = FALSE,
                                                  no_outline = TRUE),
                                     br(),
                                     br(),
                                     img(src = "Fish_swim.png", width=1120 , height=630),
                                     img(src = "swim_flume.png", wicth=1120, height=630),
                            ))
                 
                 
)


server <- function(input, output, session) {
    # output$myrandom <- renderUI(
    # plotOutput("id_forklength"),
    #plotOutput("id_dropouttemp")
    #)
    forklength_filtered <- reactive({
        Fry_thermal_maximum %>%
            filter(`Mass (g)` < input$id_slider[2],
                   `Mass (g)` > input$id_slider[1],
                   `Acclimation temp C` == input$id_checkbox1,
                   `Test type` == input$id_checkbox2)})
    
    
    wholeData <- reactive({
        Fry_thermal_maximum})
    
    output$id_forklength <- renderPlot(
        forklength_filtered()%>%
            ggplot(aes(`fork length (mm)`))+
            geom_histogram()+
            theme_solarized())
    
    output$id_dropouttemp <- renderPlot(
        forklength_filtered()%>%
            ggplot(aes(`Dropout temp`))+
            geom_histogram()+
            theme_solarized())
    
    output$id_table <- renderTable(forklength_filtered())
    
    output$Fry_thermal_maximum <- renderDataTable(wholeData())
    
    output$downloadData<- downloadHandler(
        filename = function(){paste ("Fry_thermal_maximum", "csv", sep = ".")},
        
        content = function(file){
            write.csv(wholeData(), file)
            
        }
        
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
