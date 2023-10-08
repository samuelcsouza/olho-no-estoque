gerenciamento_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(outputId = ns("manager_ui"))
}

gerenciamento_server <- function(input, output, session, font_size) {
  ns <- session$ns
  
  output$manager_ui <- renderUI({
    
    font_size()
    
    fluidPage(
      
      box(
        title = FONT_SIZE
      )
      
    )
    
  })
  
}