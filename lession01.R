iris #แสดง data frame ทั้งหมดของ iris ที่ built in มาให้
head(iris) #print 6 แถวแรกของ data frame ใน console
summary(iris) #แสดงค่า sum ของ iris
iris$Species #แสดงเฉพาะ Column
table(iris$Species) #ใช้ count จำนวนว่า column นั้นมีเท่าไหร่
summary((iris$Sepal.Length))
######################################################################
#สร้าง Model
######################################################################
iris[1:5,1:3] # [rowที่ 1-5 , colที่ 1-3]
iris[ , 1:4] # ถ้าปล่อยค่าว่างคือเอาทุกค่า ทุก row
features <- iris[ , 1:4] # การ assign ค่าให้ features
head(features,10) #ใส่ params ได้ 10 แถว
species <- iris[  ,5] #เอาค่า species มาเก็บไว้ตัวแปรใหม่
head(species)
###### market research 1500 คนเพื่อมาทำ Segment ค่าทำ 3 ล้านบาท
## K-Means Clustering ##