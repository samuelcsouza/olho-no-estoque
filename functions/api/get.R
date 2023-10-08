get_product <- function(id){
  
  api_url = Sys.getenv("API_URL")
  
  product <- httr::GET(
    url = paste0(
      api_url, '/', id
    )
  )
  
  if( product$status_code == 404 ){
    return(tibble())
  }
  
  product <- httr::content(product) %>% 
    as_tibble()
  
  return(product)
  
}