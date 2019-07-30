library(caret)
library(mlbench)
#regression
data("PimaIndiansDiabetes")
PimaIndiansDiabetes -> df
head(df)
#1.prepare data
set.seed(9)
n <- nrow(df) # จำนวน Row
id <- sample(1:n, size = 0.7*n) #สุ่ม Data มา 80% จาก data ทั้งหมด
train_df <- df[id, ] #สร้าง train data ที่ได้จาก id
test_df <- df[-id,] #สร้าง test data ที่ไม่อยู่ใน id ด้วย expression -id

str(df) #ดูโครงสร้างของ data frame
#2. train model Linear Regression
set.seed(99)
table(df$diabetes) / n
ctrl <- trainControl(method = "cv",
                     number = 5,
                     verboseIter = T
)
logis_model <- train( diabetes ~ .,
                     data = train_df,
                     method = "rpart",
                     trControl = ctrl
                )
predict_diabetes <- predict(logis_model, newdata = test_df)
predict_diabetes[1:10] == test_df$diabetes[1:10]
mean_result <- mean(predict_diabetes == test_df$diabetes)
mean_result
## Confustion Matrix
table(predict_diabetes, test_df$diabetes, dnn = c("Prediction","Actual"))
acc <- (46+126) / (126+42+17+46)
precision <- 46/(17+46)
recall <- 46/(46+42)
F1 <- 2*(precision * recall) / (precision+recall)
acc #model เราทายถูกกี่ %
precision 
recall 
F1
confusionMatrix(predict_diabetes, test_df$diabetes , mode = "everything", positive = "pos")
