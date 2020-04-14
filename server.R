

#shinyserver start point----
 shinyServer(function(input, output,session) {
   
  #1.预览外部标签内容------- 
   file_ext_barcode <- var_file('file_ext_barcode')
   rule_ext_sorted <- var_ListChoose1('rule_ext_sorted');
   
   var_ext_so <- var_text('filter_ext_so')
   
   
   data_ext_barcode <- reactive({
     file_ext_barcode <- file_ext_barcode();
     ext_so <- var_ext_so()
     res <- readxl::read_excel(file_ext_barcode);
     res <- res[,c('订单号',	'物料号'	,'二维码','印版线束')];
    
     if(len(ext_so) >0){
        res <- res[res$`订单号` == ext_so & !is.na(res$`订单号`),]
        print(res)
     }else(
        print(res)
     )
     res <- res[order(res$`二维码`,decreasing = rule_ext_sorted()),]
     return(res);
     
   })
   
   data_ext_barcode_pre <- reactive({
     res <-data_ext_barcode()
    # res <- head(res)
     return(res)
     
   })
   
   data_ext_barcode_db<- reactive({
      res <-data_ext_barcode()
      names(res) <-c('FSoNo','FChartNo','FBarcode','FNote')
      res$FNote <- tsdo::na_replace(res$FNote,'')
      res$FNote <- as.character(res$FNote)
      # res <- head(res)
      return(res)
      
   })
   
   
   
   observeEvent(input$btn_ext_barcode,{
     run_dataTable2('preview_ext_barcode',data_ext_barcode_db())
   })
   
   var_barcode <- var_text('mo_chartNo')
   var_inner_sort <- var_ListChoose1('rule_inner_sorted')
   
   #处理上传事项
   observeEvent(input$btn_ext_barcode_upload,{
      
      tsda::upload_data(conn,'takewiki_ext_barcode',data_ext_barcode_db())
      pop_notice('已上传服务器')
   })
   
   
   #内部条码标签
   data_inner_barcode <-reactive({
      data <-query_barcode_chartNo(fchartNo = var_barcode(),fbillno=input$mo_fbillno,order_asc = var_inner_sort())
      return(data)
   })
   
   data_inner_barcode_db <- reactive({
      data <- data_inner_barcode()
      names(data) <-c('FBarcode','FChartNo','FMoNo')
      if(len(var_ext_so()) ==0){
         pop_notice('请在外部标签填写销售订单号')
         return(data)
      }else{
         res <- tsdo::df_addCol(data,'FSoNo',var_ext_so())
         res$FSoNo <- tsdo::na_replace(res$FSoNo,'')
         return(res)
      }
     
   })
   observeEvent(input$btn_inner_barcode,{
      
      data <- data_inner_barcode_db()
      run_dataTable2('preview_inner_barcode',data = data)
   })
   

   
  #处理内部条码上传逻辑
   observeEvent(input$btn_inner_barcode_upload,{
      
      
      
      tsda::upload_data(conn,'takewiki_inner_barcode',data_inner_barcode_db())
      pop_notice('已上传服务器')
      #code here 
      
   })
   
   
   #处理智能匹配的内容
   
   data_barcode_match_db <- reactive({
      res <-barcode_match_preview(conn,var_ext_so())
      return(res)
   })
   data_barcode_match_preview <- reactive({
      res <- data_barcode_match_db();
      names(res) <-c('销售订单号','图号','外部二维码','内部二维码')
      return(res)
   })
   
   observeEvent(input$match_do,{
      #code here
      barcode_allocate_auto(conn,var_ext_so())
     
   })
   
   observeEvent(input$match_preview,{
      run_dataTable2('preview_match_barcode', data_barcode_match_preview())
      
   })
   
   #人工修改
   books <- getBooks(var_ext_so())
   print(books)
   dtedit2(input, output,
           name = 'books',
           thedata = books,
           edit.cols = c('FBarcode_ext','FBarcode_inner'),
           edit.label.cols = c('外部二维码','内部二维码'),
           input.types = c(FBarcode_inner='textAreaInput'),
           #input.choices = list(fname = unique(unlist(books$fname))),
           view.cols = c('FSoNo','FChartNo','FBarcode_ext','FBarcode_inner'),
           view.captions = c('销售订单号','图号','外部二维码','内部二维码'),
           show.delete = F,
           show.update = T,
           show.insert = F,
           show.copy = F,
           callback.update = books.update.callback,
           callback.insert = books.insert.callback,
           callback.delete = books.delete.callback)
   
  
})
