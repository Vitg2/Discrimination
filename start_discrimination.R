library(plotly)
library(msm) # нормальное ограниченное распределение
# распределение слабой группы №1
a1=round(rtnorm(100,15,10,0,100)) # нормальное ограниченное распределение
x = sort(a1) # кредитный рейтинг
y=ave(x, x, FUN=seq_along) # Это для постороения гистограммы с кружками
d <- data.frame(x, y)
# распределение сильной группы №2
a2=round(rtnorm(100,35,10,0,100))
x2 = sort(a2)
y2=ave(x2, x2, FUN=seq_along)
d2=setNames(data.frame(x2, y2), c("x", "y"))
d$group=1
d2$group=2
d3=rbind(d,d2)
d3=d3[order(d3$x),]
d3$y=ave(d3$x, d3$x, FUN=seq_along)
d3$group=as.factor(d3$group)

a <- list(
  autotick = FALSE,
  ticks = "",
  tick0 = 0,
  dtick = 1,
  ticklen = 10,
  tickwidth = 2,
  tickcolor = toRGB("blue")
)

# нормально вроде с вертикалью
col =c('red', 'blue')
plot_ly()  %>%
  add_trace(data = d3, x= ~ x, y= ~y, type = 'scatter', mode = 'markers',
            color=~group, colors=col, marker=list(size=10)) %>%
  add_segments(x = 30, xend = 30, y = 0.5, yend = 12, color = I('green'),
               size=I(3)) %>%
  layout(margin = list(l = 150, r = 20, b = 40, t = 10),
         yaxis = c(a, zeroline = FALSE, showgrid = FALSE, title =
                     paste0('количество претендентов', "\n&nbsp;", "\n&nbsp;")),
         xaxis = list(zeroline = FALSE, showgrid = FALSE, title = "Кредитный рейтинг")
  ) %>% hide_legend()

threshold=50

