extract_SINADEF <- function(df,var,dates.by="weekly") {
  # year = 4 digits numeric
  # month= 2 digits character
  # PENDIENTE: Hacer logic check - que pasa si hay años o meses no válidos?
  # Can be daily; annualy not implemented
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
            if(l==format(Sys.Date(), "%m") & i==format(Sys.Date(), "%Y")){k<=format(Sys.Date(), "%d")} else{TRUE}
        ){
          
          df.filtered <- df %>% 
            dplyr::filter(annus==as.character(i) & mensis==as.character(l) & dies==as.character(k)
            )
          
          output.total <- df.filtered %>%
            group_by(dep,prov,distr,
                     !!var
            ) %>%
            dplyr::summarise(Total=n()) %>%
            ungroup()%>%
            gather(edad_cat.by5,n,Total)
          
          # Se extraen los datos y se añaden los totales
          if (dates.by=="weekly") {
            
            output <- df.filtered %>%
              group_by(dep,prov,distr,edad_cat.by5,
                       !!var
              ) %>%
              dplyr::summarise(n=n()) %>%
              ungroup() %>%
              merge(output.total,by=c(c("dep","prov","distr","edad_cat.by5"),as.character(var),"n"),all=T) %>%
              #complete(nesting(dep,prov,distr),edad_cat.by5,!!var) %>% 
              replace(is.na(.), as.integer(0)) %>%
              dplyr::mutate(date = paste0(i,"/",l,"/",k),
                            date = week(date))
          }
          
          if (dates.by=="daily") {
            
            output <- df.filtered %>%
              group_by(dep,prov,distr,edad_cat.by5,
                       !!var
              ) %>%
              dplyr::summarise(n=n()) %>%
              ungroup() %>%
              merge(output.total,by=c(c("dep","prov","distr","edad_cat.by5"),as.character(var),"n"),all=T)%>%
              tidyr::complete(nesting(dep,prov,distr),edad_cat.by5,!!var) %>% 
              replace(is.na(.), as.integer(0)) %>%
              dplyr::mutate(date = paste0(i,"/",l,"/",k))
          }
          
          sinadef_procesado <- rbind(sinadef_procesado,output)
          
          print(paste0(i,"/",l,"/",k))
          rm(output)
        }
      }
      
      sinadef_procesado <- sinadef_procesado  %>%
        dplyr::group_by(dep,prov,distr,edad_cat.by5,
                        !!var,date)%>%
        dplyr::summarise(n=sum(n,na.rm=T)) %>% ungroup()
      
    }
    
    print("Completing and nesting - Might take a while")
    sinadef_procesado <- sinadef_procesado  %>%
      tidyr::complete(nesting(dep,prov,distr),edad_cat.by5,!!var,date)
    
    
  }
  # Se extraen los totales por grupos de edad quinquenales
  
  return(sinadef_procesado)
}