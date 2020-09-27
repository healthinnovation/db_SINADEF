extract_SINADEF <- function(df,var) {
  # year = 4 digits numeric
  # month= 2 digits character
  # PENDIENTE: Hacer logic check - que pasa si hay años o meses no válidos?
  
  var <- sym(var)
  
  annus.list <- sort(unique(df$annus)) # Años a solicitar
  mensis.list <- sort(unique(df$mensis)) # Meses a solicitar
  dies.list <- sort(unique(df$dies)) # Meses a solicitar
  
  sinadef_procesado <- data.frame(dep = as.character(),
                                  prov =as.character(),
                                  distr =as.character(),
                                  edad_cat.by5=as.character(),
                                  var=as.character(),
                                  n=as.integer(),
                                  date=as.character())
  
  
  
  
  for (i in 1:length(annus.list)) {
    
    i <- annus.list[i]
    
    for (l in 1:length(mensis.list)) {
      
      l <- mensis.list[l]
      
      for (k in 1:length(dies.list)) {
        
        k <- dies.list[k]
        
        if (if(i==format(Sys.Date(), "%Y")){l<=format(Sys.Date(), "%m")} else{TRUE} &
            if(l==format(Sys.Date(), "%m")){k<=format(Sys.Date(), "%d")} else{TRUE}
        ){
          
          df.filtered <- df %>% 
            filter(annus==i & mensis==l & dies==k
            )
          
          output.total <- df.filtered %>%
            group_by(dep,prov,distr,
                     !!var
            ) %>%
            summarise(Total=n()) %>%
            ungroup()%>%
            gather(edad_cat.by5,n,Total)
          
          # Se extraen los datos y se añaden los totales
          output <- df.filtered %>%
            group_by(dep,prov,distr,edad_cat.by5,
                     !!var
            ) %>%
            summarise(n=n()) %>%
            ungroup() %>%
            merge(output.total,by=c(c("dep","prov","distr","edad_cat.by5"),as.character(var),"n"),all=T)%>%
            complete(nesting(dep,prov,distr),edad_cat.by5,!!var) %>% 
            replace(is.na(.), as.integer(0)) %>%
            mutate(date = paste0(i,"/",l,"/",k))
          
          sinadef_procesado <- rbind(sinadef_procesado,output)
          
          print(paste0(i,"/",l,"/",k))
          rm(output)
        }
      }
    }
  }
  # Se extraen los totales por grupos de edad quinquenales
  
  return(sinadef_procesado)
}