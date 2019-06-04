test <- read.csv("F:/my works/Handwriting/test.csv")

rotate <- function(x)t(apply(x,2,rev))
par(mfrow=c(2,3))
indices = read.csv("F:/my works/Handwriting/testResult.csv")
lapply(485:490, 
       function(x) image(
         rotate(matrix(unlist(test[x,]),nrow = 28,byrow = T)),
         col=grey.colors(255),
         axes = FALSE,
         xlab = paste("It is ",indices[x,2])
        )
)

