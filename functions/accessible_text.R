accessible_text <- function(text){
  
  .style <- paste0("font-size:", FONT_SIZE, "px;")
  
  return(
    p(text, style = .style)
  )

}
