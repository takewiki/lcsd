library(DTeditCn);
#设置为中文
DTeditCn::setDTtoCn();

#设置数据库连接

source('conn.R',encoding = 'utf-8')



getFiles <- function() {
  
  query <-"select FBarcode,FChartNumber,FBillNo  from takewiki_t_mo_barcode";
  res <- dbGetQuery(conn,query)

  return(res)
  
  

}

##### Callback functions.
books.insert.callback <- function(data, row) {
  query <- paste0("INSERT INTO [dbo].takewiki_t_mo_barcode
           (FBarcode,FChartNumber,FBillNo)
     VALUES (",
                  "'", data[row,]$FBarcode, "', ",
                  "'", data[row,]$FChartNumber, "', ",
                  "'", data[row,]$FBillNo, "' ",
              ")"
                  )
  print(query)
  dbSendUpdate(conn,query);        
   return(getFiles())
}

books.update.callback <- function(data, olddata, row) {
  query <- paste0("UPDATE test_qiri_order SET ",
                  "forderCreateDate =  '", data[row,]$forderCreateDate , "', ",
                  "so_phone = '", data[row,]$so_phone, "', ",
                  "so_name = '", data[row,]$so_name, "', ",
                  "so_store_prov = '", data[row,]$so_store_prov, "', ",
                  "so_store_city = '", data[row,]$so_store_city, "', ",
                  "so_store_number = '", data[row,]$so_store_number, "', ",
                  "so_carType = '", data[row,]$so_carType, "', ",
                  "so_carNumber = '", data[row,]$so_carNumber, "', ",
                  "fstatus = ", data[row,]$fstatus, 
                  "  WHERE FInterId =   ", data[row,]$FInterId )
 

  dbSendUpdate(conn,query);
  return(getFiles())
}

books.delete.callback <- function(data, row) {
  query <- paste0("DELETE FROM  takewiki_t_mo_barcode  WHERE FBarcode = ", data[row,]$FBarcode)
  dbSendUpdate(conn,query);
  return(getFiles())
}
