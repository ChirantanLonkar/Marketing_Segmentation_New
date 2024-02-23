####################################################
#      Marketing -Segmentation                     #
####################################################
library('dplyr')
library("shiny")
library('DT')
library('dendextend')
library('ggbiplot')

shinyUI(fluidPage(
  title = "Segmentation Analysis",
  titlePanel(title = div(img(src = "logo.png", align = 'right'), "Segmentation Analysis")),
  
  sidebarPanel(
    fileInput("file", "Upload Segmentation data (csv file with header)"),
    uiOutput("colList"),
    selectInput("select", "Choose Segmentation Algo", c("K-Means", "Hierarchical"), selected = "K-Means"),
    checkboxInput("scale", "Scale data (for display)", value = TRUE),
    numericInput("Clust", "Number of Segments:", value = 3, min = 1),
    
    # New widget for Select Non-Numeric variables:
    selectizeInput("nonNumericVars", 
                   "Select Non-Numeric variables", 
                   choices = NULL, 
                   multiple = TRUE, 
                   options = list('plugins' = list('remove_button'))
    ),
    
    actionButton("changes", "Apply Changes", icon("refresh")),
    br()
  ),
  
  mainPanel( 
    tabsetPanel(
      type = "tabs",
      
      tabPanel("Overview & Example Dataset",
               h4(p("Segmentation")), 
               # ... (rest of your content remains unchanged)
               hr(),
               h4(p("Download Sample files")), br(),
               downloadButton('downloadData1', 'Download Segmentation Sample file'), br(), br(),
               p("Please note that download will not work with RStudio interface. Download will work only in web-browsers. So open this app in a web-browser and then download the example file. For opening this app in a web-browser click on \"Open in Browser\" as shown below -",
                 align = "justify"),
               img(src = "example1.png")
      ),
      
      tabPanel("Data", h4("Uploaded Data"), DT::dataTableOutput('up_data')),
      
      tabPanel("Summary - Segmentation",
               h3(textOutput("caption1")), h4(div(textOutput("caption2"), style = "color:Red")),
               plotOutput("plotpca", height = 400, width = 500), tableOutput('seg_count'), dataTableOutput("summary")),
      
      tabPanel("Plot", h3("Segments Plot"), plotOutput("plot", height = 700, width = 840)),
      
      tabPanel("Data Segment",
               br(),
               downloadButton('downloadData4', 'Download Segmentation file (Works only in browser)'), br(), br(),
               dataTableOutput("table"), tags$head(tags$style("tfoot {display: table-header-group;}"))
      )
    )
  )
))

# Rest of your code (server logic) remains unchanged


# Run the application
shinyApp(ui, server)