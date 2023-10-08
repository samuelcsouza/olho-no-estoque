gerenciamento_ui <- function(id) {
  ns <- NS(id)
  
  uiOutput(outputId = ns("manager_ui"))
}

gerenciamento_server <- function(input, output, session, font_size) {
  ns <- session$ns
  
  #### - - - - - - - - - - - - - - - - INFO CARDS - - - - - - - - - - - - - - - - ####
  
  total_itens <- reactive({
    
    input$btn_update
    
    nrow(
      list_products()
    )
    
  })
  
  total_value <- reactive({
    
    input$btn_update
    
    list_products() %>% 
      pull(value) %>% 
      sum() %>% 
      round(2) %>% 
      paste0("R$ ", .)
    
  })
  
  #### - - - - - - - - - - - - - - - - INFO BOX - - - - - - - - - - - - - - - - - ####
  
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
      "Preço"
    )
    
    datatable(
      products(),
      colnames = .colnames,
      rownames = TRUE,
      selection = 'multiple',
      options = list(searching = TRUE,
                     paging = FALSE,
                     info = FALSE,
                     stripeClasses = FALSE,
                     scrollX = TRUE,
                     ordering = TRUE,
                     scrollY = "350px")
    )
    
  })
  
  
  
  observeEvent(input$new_create, {
    
    new <- tibble(
      id          = "Create from App",
      material    = input$new_material,
      treatment   = input$new_treatment,
      spherical   = input$new_spherical,
      cylindrical = input$new_cylindrical,
      brand       = input$new_brand,
      value       = input$new_value
    )
    
    create_product(new)
    
    shinyjs::click('btn_update')
    
    removeModal()
    
  })
  
  observeEvent(input$btn_create_product, {
    
    showModal(
      modalDialog(
        title = accessible_text("Cadastrar novo produto"),
        size = "l",
        easyClose = TRUE,
        fade = TRUE,
        footer = div(
          align = 'center',
          modalButton(
            label = '',
            icon = icon('x')
          )
        ),
        
        fluidPage(
          {
            div(
              column(
                width = 2,
                textInput(
                  inputId = ns('new_material'),
                  label = accessible_text('Material'),
                  width = '100%'
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('new_treatment'),
                  label = accessible_text('Tratamento'),
                  width = '100%'
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('new_spherical'),
                  label = accessible_text('Esférico'),
                  width = '100%'
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('new_cylindrical'),
                  label = accessible_text('Cilíndrico'),
                  width = '100%'
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('new_brand'),
                  label = accessible_text('Marca'),
                  width = '100%'
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('new_value'),
                  label = accessible_text('Preço (un)'),
                  width = '100%'
                )
              )
            )
          },
          
          br(),
          
          div(
            align = "right",
            
            actionButton(
              inputId = ns("new_create"),
              label = accessible_text("Adicionar"),
              icon = icon('check')
            )
          )
          
        )
        
      )
    )
    
  })
  
  
  observeEvent(input$new_update, {
    
    selected_row <- input$table_product_list_rows_selected
    
    product_to_update <- products()[selected_row, ] %>% 
      head(1)
    
    upt <- tibble(
      id          = product_to_update$id,
      material    = input$upt_material,
      treatment   = input$upt_treatment,
      spherical   = input$upt_spherical,
      cylindrical = input$upt_cylindrical,
      brand       = input$upt_brand,
      value       = input$upt_value
    )
    
    update_product(
      product_to_update$id, 
      upt
    )
    
    shinyjs::click('btn_update')
    
    removeModal()
    
  })
  
  observeEvent(input$btn_update_product, {
    
    selected_row <- input$table_product_list_rows_selected
    
    product_to_update <- products()[selected_row, ] %>% 
      head(1)
    
    showModal(
      modalDialog(
        title = accessible_text("Alterar produto"),
        size = "l",
        easyClose = TRUE,
        fade = TRUE,
        footer = div(
          align = 'center',
          modalButton(
            label = '',
            icon = icon('x')
          )
        ),
        
        fluidPage(
          {
            div(
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_material'),
                  label = accessible_text('Material'),
                  width = '100%',
                  value = product_to_update$material
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_treatment'),
                  label = accessible_text('Tratamento'),
                  width = '100%',
                  value = product_to_update$treatment
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_spherical'),
                  label = accessible_text('Esférico'),
                  width = '100%',
                  value = product_to_update$spherical
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_cylindrical'),
                  label = accessible_text('Cilíndrico'),
                  width = '100%',
                  value = product_to_update$cylindrical
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_brand'),
                  label = accessible_text('Marca'),
                  width = '100%',
                  value = product_to_update$brand
                )
              ),
              
              column(
                width = 2,
                textInput(
                  inputId = ns('upt_value'),
                  label = accessible_text('Preço (un)'),
                  width = '100%',
                  value = product_to_update$value
                )
              )
            )
          },
          
          br(),
          
          div(
            align = "right",
            
            actionButton(
              inputId = ns("new_update"),
              label = accessible_text("Editar"),
              icon = icon('check')
            )
          )
          
        )
        
      )
    )
    
  })
  
  
  output$tbl_sell_product <- renderDataTable({
    
    selected_row <- input$table_product_list_rows_selected
    
    product_to_sell <- products()[selected_row, ]
    
    datatable(
      data = product_to_sell %>% select(-id),
      rownames = FALSE,
      selection = 'none',
      options = list(searching = FALSE,
                     paging = FALSE,
                     info = FALSE,
                     stripeClasses = FALSE,
                     scrollX = TRUE,
                     ordering = FALSE,
                     scrollY = "350px")
    )
    
  })
  
  observeEvent(input$new_sell, {
    
    selected_row <- input$table_product_list_rows_selected
    
    product_to_delete <- products()[selected_row, ]
    
    ids <- product_to_delete$id
    
    for (id in ids) {
      delete_product(id)
    }
    
    shinyjs::click('btn_update')
    
    removeModal()
    
  })
  
  observeEvent(input$btn_sell_product, {
    
    selected_row <- input$table_product_list_rows_selected
    
    product_to_sell <- products()[selected_row, ]
    
    showModal(
      modalDialog(
        title = accessible_text("Vender produto"),
        size = "l",
        easyClose = TRUE,
        fade = TRUE,
        footer = div(
          align = 'center',
          modalButton(
            label = '',
            icon = icon('x')
          )
        ),
        
        fluidPage(
          dataTableOutput(ns('tbl_sell_product')),
          
          br(),
          
          div(
            align = "right",
            
            actionButton(
              inputId = ns("new_sell"),
              label = accessible_text("Confirmar Venda"),
              icon = icon('check')
            )
          )
          
        )
        
      )
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