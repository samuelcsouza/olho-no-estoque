delete_product <- function(id){
  
  api_url = Sys.getenv("API_URL")
  
  product <- httr::DELETE(
    url = paste0(
      api_url, '/delete/', id
    )
  )
  
  if( product$status_code == 200 ){
    return(TRUE)
  }
  
  return(FALSE)

}