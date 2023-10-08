update_product <- function(id, new_product){
  
  api_url = Sys.getenv("API_URL")
  
  product <- httr::PATCH(
    url = paste0(
      api_url, '/edit/', id
    ),
    body = as.list(new_product),
    encode = "json"
  )
  
  product <- httr::content(product) %>% 
    as_tibble()
  
  return(product)
  
}
