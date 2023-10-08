suppressMessages({
  library(dplyr)
  library(shiny)
  library(shinydashboard)
  library(shinydashboardPlus)
  library(htmltools)
  library(DT)
  library(plotly)
  library(stringr)
})


sapply(
  list.files(path = "scripts/", full.names = TRUE, recursive = TRUE),
  source
)

sapply(
  list.files(path = "modules/", full.names = TRUE, recursive = TRUE),
  source
)

sidebar <- dashboardSidebar(
  
  sidebarMenu(
    
    menuItem(
      text    = "Início",
      tabName = "home",    
      icon    = icon("home")
    ),
    
    menuItem(
      text    = "Gerenciamento",
      tabName = "gerenciamento",    
      icon    = icon('gears', verify_fa = FALSE)
    ),
    
    actionButton(
      inputId = 'btn_plus',
      label = '+',
      icon = icon('font'),
      width = '100%'
    ),
    
    actionButton(
      inputId = 'btn_less',
      label = '-',
      icon = icon('font'),
      width = '100%'
    )
    
  )
)

body <- dashboardBody(
  tabItems(
    
    tabItem(tabName = "home", inicio_ui('home')),
    tabItem(tabName = 'gerenciamento', gerenciamento_ui('gerenciamento'))
    
  )
)

ui <- dashboardPage(
  title = "PI II - UNIVESP",
  dashboardHeader(title = tags$a(tags$img(src = 'assets/logo.svg', 
                                          width = "95%", style = "margin-bottom: 10px;"))), 
  sidebar, 
  body,
  skin = 'black'
)

server <- function(input, output, session) {
  
  update_font <- reactiveValues(data = NULL)
  
  observeEvent(input$btn_plus, {
    FONT_SIZE <<- FONT_SIZE + 2
    
    update_font$data <- FONT_SIZE
  })
  
  observeEvent(input$btn_less, {
    FONT_SIZE <<- FONT_SIZE - 2
    
    update_font$data <- FONT_SIZE
  })
  
  callModule(inicio_server, 'home', font_size = reactive(update_font$data))
  callModule(gerenciamento_server, 'gerenciamento', font_size = reactive(update_font$data))
  
}

shinyApp(ui, server)
