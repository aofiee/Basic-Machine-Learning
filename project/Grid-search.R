library(caret)
library(mlbench)
#library(skimr)
#mtcars %>%
#  group_by(am) %>%
#  skim(hp)

#regression
data("BostonHousing")
BostonHousing -> df
head(df)
#1.prepare data
set.seed(9)
n <- nrow(df) # จำนวน Row
id <- sample(1:n, size = 0.8*n) #สุ่ม Data มา 80% จาก data ทั้งหมด
train_df <- df[id, ] #สร้าง train data ที่ได้จาก id
test_df <- df[-id,] #สร้าง test data ที่ไม่อยู่ใน id ด้วย expression -id

str(df) #ดูโครงสร้างของ data frame
#2. train model k-nearest (KNN)
set.seed(99)
grid_search <- expand.grid(k = c(1,3,5,7,9,11)) # k คือเพื่อนบ้านที่อยู่รอบๆเรา ถ้าเลือกค่าน้อย error จะเยอะ 
ctrl <- trainControl(method = "repeatedcv",
                     number = 5,
                     repeats = 5,
                     verboseIter = T
                     )
#เทรน Data เพื่อทำนายค่า medv จากค่าที่สัมพันธ์กัน
knn_model <- train( medv ~ lstat + rm + b, #~ . ใช้ทุก column หรือจะระบุก็ได้ rm+d+lstat
       data = train_df,
       method = "knn",
       trControl = ctrl,
       tuneGrid = grid_search
       )
knn_model
#3. test model
predicted_medv <- predict(knn_model,newdata = test_df)
predicted_medv[1:10]
test_df$medv[1:10]
#ยกกำลัง 2 เพื่อไม่ให้ error มีค่า ติดลบและถอดรูทเมื่อจบเพื่อหักล้างกัน
RMSE <- sqrt(mean((predicted_medv - test_df$medv)**2))
knn_model
RMSE
