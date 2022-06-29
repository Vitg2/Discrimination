# Discrimination
Modeling Scenarios in a Situation of Inequality.
The simulation shows the relative advantages of different anti-discrimination scenarios depending on the characteristics of the population.

## Language
R

## Demography

function **demos** create dataframe with two subpopulations - "northern" and "southern". 

Аргументы = by default

N0 = 500 - population of Northern

N1 = 500 - population of Southern

B0 = 0.2 - proportion of bad borrowers Northern

B1 = 0.7 - proportion of bad borrowers Southern

m0g = 70 - average rating of good Northern 

d0g = 10 - standard deviation of good Northern

m0b = 50 - average rating of bad Northern

d0b = 10 - standard deviation of bad Northern

m1g = 70 - average rating of good Southern

d1g = 10 - standard deviation of good Southern

m1b = 50 - average rating of bad Southern

d1b = 10 - standard deviation of bad Southern

## Economics

Функция **threshold_1** рассчитывает оптимальный порог для заданного населения.

Аргументы:

demos - датафрейм с населением 

profit - profit from the correct issuance of a loan

loss - loss from improper loan disbursement

Функция **profit_base** рассчитывает прибыль, деленную на размер населения. Аргументы те же.

Функция **recip** рассчитывает долю тех, кто получает заем. Аргументы:

demos - датафрейм с населением 



Функция my_df 

Функция profit_base рассчитывает 

threshold - порог одобрения 

