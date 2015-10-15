

library(ggplot2)

D <- read.table('data/rounds.txt', sep=',', header=T)

plot(D$roundNumber, D$finalInterval)

ggplot(D, aes(x=roundNumber, y=finalInterval, colour=factor(isStatic))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
  # + facet_grid(. ~ isStatic)
