library(tuber)
library(tidyverse)
library(caret)
#youtube <- yt_oauth(
#  app_id = "",
#  app_secret = ""
#)
#youtube
#content_yt <- get_all_channel_video_stats(
#  channel_id = 'UC5FX2EmL4t7c305hfr-idwQ'
#)
#write.csv(content_yt,file = "cool.csv")
#content_yt
#ดูก่อนว่าได้มากี่ record
nrow(khotkool_youtube_content)
#สั่ง แสดง head ออกมาดู 6 อันว่ามีไรมั่ง
head(khotkool_youtube_content)
#มี feature อะไรให้เราเอามาเล่นบ้างล่ะ
names(khotkool_youtube_content)

glimpse(khotkool_youtube_content)
#เช็คข้อมูลกันก่อนว่ามี missing data ป่าววว
any(is.na(khotkool_youtube_content))
#พอดีเจอ missing data 1 record งั้นลบแม่ง
clean_data_khotkool <- na.omit(khotkool_youtube_content)
#ไหนๆ มีมั้ย เช็คอีกที
any(is.na(clean_data_khotkool))

#comment_content <- get_all_comments(video_id = 'iawt_JNv17g')
#tidyverse pipe จัดการชุดข้อมูลแยกตามรายการที่อยู่ใน โคตรคูล Channel กันทีละอัน
#เบื้องต้นคงเก็บไว้แค่ title viewCount likeCount dislikeCount commentCount url ตัดพวกวันที่ออก ไม่รู้จะเอาไปไร
clean_data_khotkool %>%
  filter(str_detect(title,'หมีพาซิ่ง')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "mee_pa_zine") -> mee_pa_zine

#clean หมีพาซิ่งแล้ว
head(mee_pa_zine)

#จัดการรายการวันละม้วนต่อ
clean_data_khotkool %>%
  filter(str_detect(title,'วันละม้วน')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "one_la_muan") -> one_la_muan

head(one_la_muan)

clean_data_khotkool %>%
  filter(str_detect(title,'คนหน้าหมี') & !str_detect(title,'VLOG')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "khon_na_mee") -> khon_na_mee
#ตามด้วยนี่ รายการโปรด คนหน้าหมี

head(khon_na_mee)

clean_data_khotkool %>%
  filter(str_detect(title,'แม่แยมเอง') & !str_detect(title,'VLOG')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "maeyam_eang") -> mae_yam_eang
#แม่แยมเอง อันนี้ไม่เคยดู ฮาๆๆ ไม่เป็นไร พัก data ไว้ก่อน

head(mae_yam_eang)

clean_data_khotkool %>%
  filter(str_detect(title,'VLOG')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "vlog") -> vlog
#vlog ก็ไม่เคยดู พักไว้ๆ

head(vlog)

clean_data_khotkool %>%
  filter(str_detect(title,'จีบหนูหน่อย') & !str_detect(title,'VLOG')) %>%
  select(X,title,viewCount,likeCount,dislikeCount,commentCount,url) %>%
  mutate(content_group = "jeep_nu_noi") -> jeep_nu_noi
#นี่รายการโปรดอีกตัว ฮาๆๆ คนมาออกรายการไม่น่าโสดนะแหม่

head(jeep_nu_noi)
#combine all content channel
all_content_channel <- rbind(mee_pa_zine,one_la_muan,jeep_nu_noi,vlog,mae_yam_eang,khon_na_mee)
#ลำดับรายการที่มียอดวิว มากที่สุดได้แก่รายการรรรรรรร หมีพาซิ่งครับ ซิ่งมียอดวิวมากถึง 30 กว่าล้านยอดวิว
#หมีพาซิ่งมี 18 คลิป
#vlog มี 32 คลิป
#จีบหนูหน่อย 17 คลิป
#คนหน้าหมี 27 คลิป
#แม่แยมเอง 21 คลิป
#วันละม้วน 21 คลิป
all_content_channel %>%
  group_by(content_group) %>%
  summarise(mostViews = sum(viewCount)) %>%
  arrange(desc(mostViews)) %>%
  ggplot(.,mapping = aes(
    x=reorder(content_group,-mostViews),
    y=mostViews/1000)) + geom_col(col = "blue", fill = "navy", alpha = 0.7) +
  coord_flip() +
  labs(x = "Content Name",
       y = "Total Views x 1000")

#งั้นเอารายการหมีพาซิ่งมาดูกันว่าเทปไหน ฮิตสุด
mee_pa_zine %>%
  arrange(desc(viewCount)) %>%
  head(10) %>%
  select(url,viewCount)  %>%
  ggplot(.,mapping = aes(
    x=reorder(url,-viewCount),
    y=viewCount/100)) + geom_col(col = "blue", fill = "navy", alpha = 0.7) +
  coord_flip() +
  labs(x = "Content Name",
       y = "Total Views x 100")

#หาความสัมพันธ์ระหว่าง dislike กับ ยอดวิวว่าสัมพันธ์กันไหม
cor(all_content_channel$dislikeCount,all_content_channel$viewCount)
#หาความสัมพันธ์ระหว่าง dislike กับ ยอดไลค์
cor(all_content_channel$dislikeCount,all_content_channel$likeCount)
#หาความสัมพันธ์ระหว่าง dislike กับ ยอดจำนวนคอมเม้น
cor(all_content_channel$dislikeCount,all_content_channel$commentCount)

#1.prepare data
set.seed(9)
# จำนวน Row
n <- nrow(all_content_channel)
#สุ่ม Data มา 70% จาก data ทั้งหมด
id <- sample(1:n, size = 0.7*n)
#สร้าง train data ที่ได้จาก id
train_df <- all_content_channel[id, ]
#สร้าง test data ที่ไม่อยู่ใน id ด้วย expression -id
test_df <- all_content_channel[-id,] 
#ดูโครงสร้างของ data frame
str(all_content_channel)

set.seed(99)
grid_search <- expand.grid(k = c(1,3,5)) 
ctrl <- trainControl(method = "repeatedcv",
                     number = 5,
                     repeats = 5,
                     verboseIter = T
)
#เอา collumn ที่มีความสัมพันธ์กันมาเทรน
my_model <- train( dislikeCount ~ viewCount + likeCount + commentCount,
                   data = train_df,
                   method = "knn",
                   trControl = ctrl,
                   tuneGrid = grid_search
)
my_model
#3. test model
predicted_dislike <- predict(my_model,newdata = test_df)
predicted_dislike[10:20]
test_df$dislikeCount[10:20]
RMSE <- sqrt(mean((predicted_dislike - test_df$dislikeCount)**2))
my_model
RMSE
saveRDS(my_model,file = "youtube.rds")


