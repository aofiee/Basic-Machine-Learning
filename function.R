x <- c(NA,1,2,3,4,5,6,7,8,9,0,NA)
x
mean(x)
sd(x)
min(x)
max(x)
median(x)

mean(x,na.rm = T)
sd(x,na.rm = T)
min(x,na.rm = T)
max(x,na.rm = T)
median(x,na.rm = T)

func_change_surname <- function(name){
  new_name <- c(name,"lerdprasert")
  new_name
  result <- paste(new_name, collapse=" ")
  result
}
func_change_surname("Khomkrid")

func_ret_swap_gender <- function(gender){
  if (gender == "M"){
    return("F")
  }else{
    return("M")
  }
}
func_ret_swap_gender("M")
func_ret_swap_gender("F")

func_ret_fullname <- function(first_name,surname){
  fullname <- paste(c(first_name,surname),collapse = " ")
  return(fullname)
}

func_ret_fullname(surname = "Lerdprasert", first_name = "Khomkrid")

sample(1:100,size = 5)

roll_dices <- function(){
  dices_one <- sample(1:6, size = 1)
  dices_two <- sample(1:6, size = 1)
  return(dices_one+dices_two)
}
roll_dices()

roll_dices2 <- function(){
  result <- sample(1:6, size = 2, replace = T)
  sum(result)
}

roll_dices2()
