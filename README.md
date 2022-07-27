# Discrimination
Modeling Scenarios in a Situation of Inequality.
The simulation shows the relative advantages of different anti-discrimination scenarios depending on the characteristics of the population.

## Language
R

## Demography

Function **demos** create dataframe with two subpopulations - "northern" and "southern". 

Аргументы = by default

N0 = 500 - population of Northerners

N1 = 500 - population of Southerners

B0 = 0.2 - proportion of bad borrowers Northerners

B1 = 0.7 - proportion of bad borrowers Southerners

m0g = 70 - average rating of good Northerners 

d0g = 10 - standard deviation of good Northerners

m0b = 50 - average rating of bad Northerners

d0b = 10 - standard deviation of bad Northerners

m1g = 70 - average rating of good Southerners

d1g = 10 - standard deviation of good Southerners

m1b = 50 - average rating of bad Southerners

d1b = 10 - standard deviation of bad Southerners

## Economics

Fuction **threshold_1** evaluate optimal threshold for population.

Arguments:

    demos - population data frame 

    profit - profit from the correct issuance of a loan

    loss - loss from improper loan disbursement

Function **profit_base** calculates the profit divided by the size of the population. The arguments are the same.

Function **recip** calculates the proportion of those who receive a loan. Arguments:

    demos - population data frame

    threshold - loan approval threshold

Function **paritet** calculates the borrowing rate for the demographic parity scenario. For both groups, the proportion should be the same.

Arguments:
    
    demos1, demos2, i, profit=3, loss=7. Two data frames with two populations, profit, and loss.

Function **profit_paritet** - is the total profit of the parity scenario. The arguments are the same.

Function **my_df** - creates a dataframe with statistics for the population (argument: _demos_). Stats list:

Optimal_threshold_N = optimal threshold for Northerners

Optimal_threshold_S = оptimal threshold for Southerners

Optimal_prop_N_yes = proportion of northerners with a positive decision in the scenario without restrictions

Optimal_prop_S_yes = proportion of southerners with a positive decision in the scenario without restrictions

Optimal_prop_yes = proportion of borrowers in the scenario without restrictions

Optimal_Profit = bank profit in the scenario without restrictions

Just_threshold = порог в сценарии "популяционной слепоты" (2 сценарий)

Just_prop_N_yes = доля северных получивших заём во 2-м сценарии

Just_prop_S_yes = доля южных получивших заём во 2-м сценарии

Just_prop_yes = доля получивших заём 2-й сценарий

Just_Profit = Прибыль во 2-м сценарии

Paritet_threshold_N = Порог северных в сценарии демографического паритета




