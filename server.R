

#shinyserver start point----
 shinyServer(function(input, output,session) {
   
  #1.预览外部标签内容------- 
   file_ext_barcode <- var_file('file_ext_barcode')
   rule_ext_sorted <- var_ListChoose1('rule_ext_sorted');
   
   data_ext_barcode <- reactive({
     file_ext_barcode <- file_ext_barcode();
     res <- readxl::read_excel(file_ext_barcode);
     res <- res[,c('订单号',	'物料号'	,'二维码','印版线束')];
     res <- res[order(res$`二维码`,decreasing = rule_ext_sorted()),]
     return(res);
     
   })
   
   data_ext_barcode_pre <- reactive({
     res <-data_ext_barcode()
     res <- head(res)
     return(res)
     
   })
   
   observeEvent(input$btn_ext_barcode,{
     run_dataTable2('preview_ext_barcode',data_ext_barcode_pre())
   })
   
  
   
  
})
