# contract
getLink <- function(x) {
    
    linkBase <- "https://www.checkthepolice.org/database" 
    
    space <- "%20"
    
    term <- as.character(x)
    
    newTerm <- gsub(" ", space, term)
    
    link <- paste0(linkBase, newTerm)
    
    return(link)
}