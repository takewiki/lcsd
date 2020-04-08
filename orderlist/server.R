library(shiny)

shinyServer(function(input, output) {


  files <- getFiles()
  dteditCn(input, output,
           name = 'files',
           thedata = files,
           edit.cols = c('FBarcode','FChartNumber','FBillNo'),
           edit.label.cols = c('二维码','图号','生产任务单号'),
           #input.types = c(Fstatus='numericInput'),
           #input.choices = list(Authors = unique(unlist(books$Authors))),
           view.cols = c('FBarcode','FChartNumber','FBillNo'),
           label.add = '新增',
           label.copy = '复制',
           label.edit = '修改',
           label.delete = '删除',
           title.add = '新增界面',
           title.edit = '修改界面',
           title.delete = '删除界面',
           #show.copy = FALSE,
           #show.insert = FALSE,
           defaultPageLength = 10,
           callback.update = books.update.callback,
           callback.insert = books.insert.callback,
           callback.delete = books.delete.callback)

})
