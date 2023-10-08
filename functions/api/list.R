list_products <- function(skip = 0, limit = 100){
  
  api_url = Sys.getenv("API_URL")
  
  products <- httr::GET(
    url = paste0(
      api_url, '?skip=', skip, '&limit=', limit
    )
  )
  
  products <- httr::content(products)
  
  products <- lapply(products$data, as_tibble) %>% 
    dplyr::bind_rows()
  
  return(products)
  
}