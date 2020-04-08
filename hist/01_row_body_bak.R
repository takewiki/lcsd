menu_row <- tabItem(tabName = "row",
                    fluidRow(
                      column(width = 3,
                             box(
                               title = "外部标签", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_file('file_ext_barcode','选择外部标签文件'),
                               mdl_ListChoose1('rule_ext_sorted','排序规则',list('二维码从小到大(升序)','二维码从大到小(降序)'),list(FALSE,TRUE),selected = FALSE),
                              # mdl_ListChoose1('rule_ext_sorted2','处理规则',list(' 规则1','规则2'),list(FALSE,TRUE),selected = FALSE),
                               actionButton('btn_ext_barcode','预览外部标签')
                             ),
                             box(
                               title = "LC内部标签", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_file('file_inner_barcode','选择内部标签文件')
                             ),
                             box(
                               title = "匹配规则", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_ListChoose1('rule_ext_match','匹配规则',list('二维码从小到大(升序)','二维码从大到小(降序)'),list(FALSE,TRUE),selected = FALSE),
                               actionButton('match_do','智能匹配'),
                               mdl_download_button('match_dl','下载配货单')
                             )
                      ),
                      
                      column(width = 9,
                             box(
                               title = "预览外部标签内容", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_dataTable('preview_ext_barcode',label = '预览外部标签内容')
                             ),
                             box(
                               title = "预览内部标签内容", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_dataTable('preview_inner_barcode',label = '预览内部标签内容')
                             ),
                             box(
                               title = "预览配货单内容", width = NULL, solidHeader = TRUE, status = "primary",
                               mdl_dataTable('preview_inner_barcode2',label = '预览配货单内容')
                             )
                      )
                    )
)
