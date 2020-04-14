data1 <- data.frame(FSoNo=c('bbc','bbc'),FChartNo=c('a','b'),FBarcode=c('123','124'),stringsAsFactors = F)
data2 <- data.frame(FSoNo=c('bbc','bbc','bbc'),FChartNo=c('a','a','b'),FBarcode=c('223','224','225'),stringsAsFactors = F)

bbc2 <- alloc_barcode(data1,data2)

bbc2;

class(bbc2)

