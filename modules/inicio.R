inicio_ui <- function(id) {
  ns <- NS(id)
  
 uiOutput(outputId = ns('home_ui'))

}

inicio_server <- function(input, output, session, font_size) {
  ns <- session$ns

  output$home_ui <- renderUI({
    
    font_size()
    
    fluidPage(
      
      box(
        title = FONT_SIZE
      )
      
    )
    
  })
}