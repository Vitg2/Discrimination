# Дискриминация - функции

# Функция принимает параметры двух популяций и выводит экономическую цену
# равенства (одинаковый порог для всех) и братства (равный доступ к благу
# для всех)

# N0 - численность северных
# N1 - численность южных
# B0 - доля плохих заемщиков северных
# B1 - доля плохих заемщиков южных
# m0g - среднее хороших северных
# d0g - стандартное отклонение хороших северных
# m0b - среднее плохих северных
# d0b - стандартное отклонение плохих северных
# m0g - среднее хороших северных
# d0g - стандартное отклонение хороших северных
# m0b - среднее плохих северных
# d0b - стандартное отклонение плохих северных
# m1g - среднее хороших южных
# d1g - стандартное отклонение хороших южных
# m1b - среднее плохих южных
# d1b - стандартное отклонение плохих южных
# m1g - среднее хороших южных
# d1g - стандартное отклонение хороших южных
# m1b - среднее плохих южных
# d1b - стандартное отклонение плохих южных
# profit - прибыль от правильной выдачи
# loss - убыток от неправильной выдачи

# создает датафрейм с населением для дальнейшей симулиции
demos <- function(N0=500, N1=500, B0=0.2, B1=0.7, m0g=70, m0b=50,
                             d0g=10, d0b=10, m1g=70, m1b=50, d1g=10, d1b=10) {
  # северные = благополучные
  n0b=round(N0*B0) # число плохих северных
  s0b=round(msm::rtnorm(n0b, m0b, d0b, 0 ,100)) # рейтинги плохие северные
  n0g=N0-n0b # число хороших северных
  s0g=round(msm::rtnorm(n0g,m0g, d0g, 0 ,100)) # рейтинги хорошие северные

  # южные
  n1b=round(N1*B1) # число плохих южных
  s1b=round(msm::rtnorm(n1b,m1b,d1b, 0 ,100)) # рейтинги плохие южные
  n1g=N1-n1b # число хороших южных
  s1g=round(msm::rtnorm(n1g,m1g,d1g, 0 ,100)) # рейтинги хорошие южные

  # все северные и все южные
  s0=data.frame(credit_rate=s0b, reliability=0)
  s0=rbind(s0, data.frame(credit_rate=s0g, reliability=1)) # северные=0
  s0$group=0
  s1=data.frame(credit_rate=s1b, reliability=0)
  s1=rbind(s1, data.frame(credit_rate=s1g, reliability=1)) # южные=1
  s1$group=1
  rbind(s0,s1)
}

# оптимальный порог для датафрейма
threshold_1 = function(demos, profit=4, loss=7) {
  rN= numeric(100)
  for(i in 0:100) {
    rN[i]=(sum(demos[which(demos$credit_rate>i), 2]==1)*profit-
             sum(demos[which(demos$credit_rate>i), 2]==0)*loss)/nrow(demos)}
    which.max(rN)
  }

# удельная прибыль
profit_base=function(demos, threshold=50, profit=3, loss=7){
  (sum(demos[which(demos$credit_rate>threshold), 2]==1)*profit-
     sum(demos[which(demos$credit_rate>threshold), 2]==0)*loss)/nrow(demos)
}

# доля тех, кто получит кредит
recip = function(demos, threshold){
  sum(demos$credit_rate>threshold)/nrow(demos)
}

# оптимальный уровень демографического паритета для двух групп, сколько неполучат
paritet <- function(demos1, demos2, i, profit=3, loss=7) {
  rJ= numeric(100)
  for(i in 0:100) {
    thrN=quantile(demos1$credit_rate, i/100) # северный порог
    thrS=quantile(demos2$credit_rate, i/100) # южный порог
    rJ[i]=((sum(demos1[which(demos1$credit_rate>thrN), 2]==1)*profit-
        sum(demos1[which(demos1$credit_rate>thrN), 2]==0)*loss) +
        (sum(demos2[which(demos2$credit_rate>thrS), 2]==1)*profit-
        sum(demos2[which(demos2$credit_rate>thrS), 2]==0)*loss))/
      (nrow(demos1)+nrow(demos2))
  }
  which.max(rJ) # доля неполучивших = 79%
}

# общая прибыль сценария демопаритета
profit_paritet <- function(demos1, demos2, profit=3, loss=7) {
  pr=paritet(demos1, demos2, profit=profit, loss=loss)
  threshold1=quantile(demos1$credit_rate, pr/100) # северный порог
  threshold2=quantile(demos2$credit_rate, pr/100) # южный порог
  profit_base(demos1, threshold=threshold1, profit=profit, loss=loss)+
    profit_base(demos2, threshold=threshold2, profit=profit, loss=loss)
}

# функция создает датафрейм со статистиками на основании данных demos
my_df <- function(demos) {
  dem1=demos[demos$group==0,]
  dem2=demos[demos$group==1,]
  pr=paritet(dem1, dem2)
  my_data=data.frame(Optimal_threshold_N = threshold_1(dem1), # оптимальная отсечка северных
                     Optimal_threshold_S = threshold_1(dem2),
                     Optimal_prop_N_yes = recip(dem1, threshold_1(dem1)), # доля северных с положительным решением
                     Optimal_prop_S_yes = recip(dem2, threshold_1(dem2)),
                     Optimal_prop_yes=(recip(dem1, threshold_1(dem1))*nrow(dem1)+
                                         recip(dem2, threshold_1(dem2))*nrow(dem2))/(nrow(dem1)+nrow(dem2)),
                     Optimal_Profit=profit_base(dem1, threshold = threshold_1(dem1))+
                       profit_base(dem2, threshold = threshold_1(dem2)),
                     Just_threshold = threshold_1(demos),
                     Just_prop_N_yes=recip(dem1, threshold_1(demos)),
                     Just_prop_S_yes=recip(dem2, threshold_1(demos)),
                     Just_prop_yes=(recip(dem1, threshold_1(demos))*nrow(dem1)+
                                      recip(dem2, threshold_1(demos))*nrow(dem2))/(nrow(dem1)+nrow(dem2)),
                     Just_Profit=profit_base(demos = demos, threshold = threshold_1(demos)),
                     Paritet_threshold_N = quantile(dem1$credit_rate, pr/100),
                     Paritet_threshold_S = quantile(dem2$credit_rate, pr/100),
                     Paritet_prop_yes=(100-paritet(dem1, dem2))/100,
                     Paritet_profit=profit_paritet(dem1, dem2),
                     Justice_price=profit_base(dem1, threshold = threshold_1(dem1))+
                       profit_base(dem2, threshold = threshold_1(dem2))-
                       profit_base(demos = demos, threshold = threshold_1(demos)),
                     Paritet_price=profit_base(dem1, threshold = threshold_1(dem1))+
                       profit_base(dem2, threshold = threshold_1(dem2))-profit_paritet(dem1, dem2)
  )
  return(my_data)
}

# Функция преобразует список датафреймов в массив, для последующего расчета перцентилей
### Функция для преобразования списка датафреймов в 3D-массив
## Все объекты в списке - датафреймы с одинаковыми названиями столбцов.
## https://github.com/laurencelin/SSHBS/blob/master/SSHBS_initiation.R

list2ary = function(input.list){  # на входе список списков
  rows.cols <- dim(input.list[[1]])
  sheets <- length(input.list)
  output.ary <- array(unlist(input.list), dim = c(rows.cols, sheets))
  colnames(output.ary) <- colnames(input.list[[1]])
  row.names(output.ary) <- row.names(input.list[[1]])
  return(output.ary)    # на выходе 3-D массив
}


