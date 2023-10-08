gerenciamento_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(outputId = ns("manager_ui"))
}

gerenciamento_server <- function(input, output, session, font_size) {
  ns <- session$ns
  
  total_itens <- reactive({
    
    nrow(
      list_products()
    )
    
  })
  
  total_value <- reactive({
    
    list_products() %>% 
      pull(value) %>% 
      sum() %>% 
      round(2) %>% 
      paste0("R$ ", .)
    
  })
  
  
  
  products <- reactive({
    
    input$btn_update
    
    list_products()
    
  })
  
  output$table_product_list <- renderDataTable({
    
    .colnames <- c(
      "ID",
      "Material",
      "Tratamento",
      "Esférico",
      "Cilíndrico",
      "Marca",
      "Valor"
    )
    
    datatable(
      products(),
      colnames = .colnames,
      rownames = TRUE,
      options = list(searching = TRUE,
                     paging = FALSE,
                     info = FALSE,
                     stripeClasses = FALSE,
                     scrollX = TRUE,
                     ordering = TRUE,
                     scrollY = "350px")
    )
    
  })
  
  
  
  
  output$manager_ui <- renderUI({
    
    font_size()
    
    fluidPage(
      
      #### - - - - - - - - - - - - - - - - INFO CARDS - - - - - - - - - - - - - - - - ####
      
      div(
        column(
          width = 3
        ),
        
        column(
          width = 3,
          infoBox(
            title = accessible_text("Total Itens"),
            value = accessible_text(total_itens()),
            icon = icon('glasses'),
            color = 'blue',
            width = '100%'
          )
        ),
        
        column(
          width = 3,
          infoBox(
            title = accessible_text("Total Estoque"),
            value = accessible_text(total_value()),
            icon = icon('dollar'),
            color = 'blue',
            width = '100%'
          )
        ),
        
        column(
          width = 3
        )
        
      ),
      
      br(),
      
      #### - - - - - - - - - - - - - - - - INFO BOX - - - - - - - - - - - - - - - - - ####
      
      box(
        title = accessible_text("Produtos em estoque"),
        solidHeader = TRUE,
        width = 12,
        status = "primary",
        
        
        div(
          dataTableOutput(
            ns('table_product_list')
          ),
          style = paste0("font-size:", FONT_SIZE, "px;")
        ),
        
        br(),
        
        div(
          align = "right",
          
          actionButton(
            inputId = ns("btn_create_product"),
            label = accessible_text("Novo"),
            icon = icon("plus"),
            width = '15%'
          ),
          
          actionButton(
            inputId = ns("btn_update_product"),
            label = accessible_text("Alterar"),
            icon = icon("edit"),
            width = '15%'
          ),
          
          actionButton(
            inputId = ns("btn_sell_product"),
            label = accessible_text("Realizar Venda"),
            icon = icon("check"),
            width = '15%'
          )
          
        ),
        
        
        footer = div(
          align = "center",
          actionButton(
            inputId = ns("btn_update"),
            label = accessible_text("Atualizar"),
            icon = icon("refresh"),
            width = '35%'
          )
        )
        
      )
      
    )
    
  })
  
}