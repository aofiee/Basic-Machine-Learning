#การ Predict ทำนายข้อมูล
# Supervised Learning
head(mtcars)
#######
#ชื่อรถยนต์         column mpg คือที่เราจะทำนาย
#                   mpg cyl  disp hp drat wt    qsec   vs am   gear carb
#Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
summary(mtcars$mpg)
hist(mtcars$mpg, breaks = 10) #นำค่าที่ได้มา plot graph histrogram ทางสถิติ
cor(mtcars$wt,mtcars$mpg) #หาความสัมพันธ์ระหว่าง 2 ตัวแปรที่เป็นตัวเลขทั้งคู่
plot(mtcars$wt,mtcars$mpg) #ตัวแปรต้นใช้แกน x ตัวแปรตามที่ต้องทำนายใช้ Y
lm_model <- lm(mpg ~ wt , data = mtcars) #linear model ทำ linear regration ทำนายผล
lm_model
plot(mtcars$wt,mtcars$mpg,pch = 16)
abline(lm_model) #ใส่เส้นค่า slope เข้าไป plot 
new_car <- data.frame(wt = 0.2725) #สร้างรถของเรามาทำนาย
new_car
predict(lm_model,newdata = new_car)
lm_model <- lm (mpg ~ wt + hp + am , data = mtcars)
lm_model

new_car <- data.frame(wt = 0.27,hp = 1200,am = 0) #harley กินน้ำมัน 
new_car
predict(lm_model,newdata = new_car)