#Create Train and Test data set

#load the train.csv file to training 
train <- read.csv("train.csv")
test <- read.csv("test.csv")

## start a local h2o cluster
localH2O = h2o.init(max_mem_size = '6g', # use 6GB of RAM of *GB available
                    nthreads = -1) 
train[,1] = as.factor(train[,1]) # convert digit labels to factor for classification
train_h2o = as.h2o(train)
test_h2o = as.h2o(test)

## set timer
s <- proc.time()

## train model
model =
  h2o.deeplearning(x = 2:785,  # column numbers for predictors
                   y = 1,   # column number for label
                   training_frame = train_h2o, # data in H2O format
                   activation = "RectifierWithDropout", # algorithm
                   balance_classes = TRUE, 
                   hidden = c(100,100), # two layers of 100 nodes
                   epochs = 15) # no. of epochs

## classify test set
h2o_y_test <- h2o.predict(model, test_h2o)

## convert H2O format into data frame and  save as csv
df_y_test = as.data.frame(h2o_y_test)
df_y_test = data.frame(ImageId = seq(1,length(df_y_test$predict)), Label = df_y_test$predict)
write.csv(df_y_test, file = "testResult.csv", row.names=F)

## shut down virutal H2O cluster
##h2o.shutdown(prompt = F)

