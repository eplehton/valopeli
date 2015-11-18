

library(ggplot2)

D <- read.table('data/rounds.txt', sep=',', header=T)

plot(D$gameNumber, D$gameInterval)

ggplot(D, aes(x=gameNumber, y=gameInterval, colour=factor(isStatic))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
  # + facet_grid(. ~ isStatic)

