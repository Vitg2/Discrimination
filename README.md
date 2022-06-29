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

threshold - порог одобрения займа

Функция **paritet** рассчитывает долю получивших заем для сценария демографического паритета. Для обеих групп доля должна быть одинаковая.

Аргументы: demos1, demos2, i, profit=3, loss=7. Два датафрейма с населениеми прибыль с убытками.

Функция **profit_paritet** - общая прибыль сценария паритета. Аргументы те же. 

Функция **my_df** - создает датафрейм со статистиками для населения (аргумент - demos). Список статистик:

Optimal_threshold_N = оптимальный порог для северных

Optimal_threshold_S = оптимальный порог для южных

Optimal_prop_N_yes = доля северных с положительным решением в сценарии без ограничений

Optimal_prop_S_yes = доля южных с положительным решением в сценарии без ограничений

Optimal_prop_yes = доля получивших заём 1-й сценарий

Optimal_Profit = прибыль банка в сценарии без ограничений

Just_threshold = порог в сценарии "популяционной слепоты" (2 сценарий)

Just_prop_N_yes = доля северных получивших заём во 2-м сценарии

Just_prop_S_yes = доля южных получивших заём во 2-м сценарии

Just_prop_yes = доля получивших заём 2-й сценарий

Just_Profit = profit_base(demos = demos, threshold = threshold_1(demos)),
                     Paritet_threshold_N = quantile(dem1$credit_rate, pr/100),
                     Paritet_threshold_S = quantile(dem2$credit_rate, pr/100),
                     Paritet_prop_yes=(100-paritet(dem1, dem2))/100,
                     Paritet_profit=profit_paritet(dem1, dem2),
                     Justice_price=profit_base(dem1, threshold = threshold_1(dem1))+
                       profit_base(dem2, threshold = threshold_1(dem2))-
                       profit_base(demos = demos, threshold = threshold_1(demos)),
                     Paritet_price=profit_base(dem1, threshold = threshold_1(dem1))+
                       profit_base(dem2, threshold = threshold_1(dem2))-profit_paritet(dem1, dem2)


