create_product <- function(product){
  
  api_url = Sys.getenv("API_URL")
  
  product <- httr::POST(
    url = paste0(
      api_url, '/new'
    ),
    body = as.list(product),
    encode = "json"
  )
  
  product <- httr::content(product) %>% 
    as_tibble()
  
  return(product)
  
}