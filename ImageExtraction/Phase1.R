library("magick")
library("png")
library("colorspace")
library("svDialogs")

rm(list = ls())

blank1 <- image_read("C:/Users/RISHABH/Documents/Whiz Project/ImageExtraction/1/blank1.JPG")
blank2 <- image_read("C:/Users/RISHABH/Documents/Whiz Project/ImageExtraction/1/blank2.JPG")
response1 <- image_read("C:/Users/RISHABH/Documents/Whiz Project/ImageExtraction/1/Response1.JPG")
response2 <- image_read("C:/Users/RISHABH/Documents/Whiz Project/ImageExtraction/1/Response2.JPG")

blank1 <- image_quantize(blank1,colorspace = "gray")
blank1 <- image_convert(blank1,format = "png")
blank1 <- image_resize(blank1,"800x")

blank2 <- image_quantize(blank2,colorspace = "gray")
blank2 <- image_convert(blank2,format = "png")
blank2 <- image_resize(blank2,"800x")

response1 <- image_quantize(response1,colorspace = "gray")
response1 <- image_convert(response1,format = "png")
response1 <- image_resize(response1,"800x")

response2 <- image_quantize(response2,colorspace = "gray")
response2 <- image_convert(response2,format = "png")
response2 <- image_resize(response2,"800x")

tmpName <- tempfile(pattern = "b1",fileext = ".png")
image_write(blank1,path = tmpName)
blank1 <- readPNG(tmpName)
blank1 <- round(255*blank1)
image(blank1 ,col = gray(0:255 / 256))

tmpName <- tempfile(pattern = "b2",fileext = ".png")
image_write(blank2,path = tmpName)
blank2 <- readPNG(tmpName)
blank2 <- round(255*blank2)
image(blank2 ,col = gray(0:255 / 256))

tmpName <- tempfile(pattern = "r1",fileext = ".png")
image_write(response1,path = tmpName)
response1 <- readPNG(tmpName)
response1 <- round(255*response1)
image(response1 ,col = gray(0:255 / 256))

tmpName <- tempfile(pattern = "r2",fileext = ".png")
image_write(response2,path = tmpName)
response2 <- readPNG(tmpName)
response2 <- round(255*response2)
image(response2 ,col = gray(0:255 / 256))


page1 <- blank1 - response1
page2 <- blank2 - response2

writePNG(page1/255,target = tmpName)
Image <- image_read(path = tmpName)
saveDirectory <- dlgSave(title = "Save Page1 Image to")$res
image_write(Image,path = saveDirectory,format = "png")

writePNG(page2/255,target = tmpName)
Image <- image_read(path = tmpName)
saveDirectory <- dlgSave(title = "Save Page2 Image to")$res
image_write(Image,path = saveDirectory,format = "png")

#Meta Data Page1 : blocks of 180X30 150X30 130X30 130X30 starting from 120X150 to 700X490
i <- 150
qn <- 1
while(i<480&&qn<=11){
  j <- 120
  a <- 0
  for(k in (j:(j+180))){
    for(l in (i:(i+30))){
      a <- a + page1[l,k]
     # tst[l,k] <- 255
    }
  }
  #image(tst,col = gray(0:255 / 256))
  j<-j+180
  b <- 0
  for(k in (j:(j+150))){
    for(l in (i:(i+30))){
      b <- b + page1[l,k]
    }
  }
  j<-j+150
  c <- 0
  for(k in (j:(j+130))){
    for(l in (i:(i+30))){
      c <- c + page1[l,k]
    }
  }
  j<-j+130
  d <- 0
  for(k in (j:(j+130))){
    for(l in (i:(i+30))){
      d <- d + page1[l,k]
    }
  }
  x <- max(a,b,c,d)
  if(x==a){
    print(paste0("Question ",qn," : A"))
  }else if(x==b){
    print(paste0("Question ",qn," : B"))
  }else if(x==c){
    print(paste0("Question ",qn," : C"))
  }else{
    print(paste0("Question ",qn," : D"))
  }
  i <- i + 30 
  qn <- qn+1
}
#Meta Data Page2 : blocks of 180X25 140X25 140X25 130X25 starting from 135X120 to 700X480
i <- 135
qn <- 12
while(i<480&&qn<=28){
  j <- 120
  a <- 0
  for(k in (j:(j+180))){
    for(l in (i:(i+25))){
      a <- a + page2[l,k]
      # tst[l,k] <- 255
    }
  }
  #image(tst,col = gray(0:255 / 256))
  j<-j+180
  b <- 0
  for(k in (j:(j+140))){
    for(l in (i:(i+25))){
      b <- b + page2[l,k]
    }
  }
  j<-j+140
  c <- 0
  for(k in (j:(j+140))){
    for(l in (i:(i+25))){
      c <- c + page2[l,k]
    }
  }
  j<-j+140
  d <- 0
  for(k in (j:(j+130))){
    for(l in (i:(i+25))){
      d <- d + page2[l,k]
    }
  }
  x <- max(a,b,c,d)
  if(a==b&&b==c&&c==d){
    print(paste0("Question ",qn," : U"))
  }else if(x==a){
    print(paste0("Question ",qn," : A"))
  }else if(x==b){
    print(paste0("Question ",qn," : B"))
  }else if(x==c){
    print(paste0("Question ",qn," : C"))
  }else{
    print(paste0("Question ",qn," : D"))
  }
  if(qn==13||qn==16||qn==21){
    i <- i+30
  }else if(qn==27){
    i <- i+35
  }else{
    i <- i+15
  } 
  qn <- qn+1
}

