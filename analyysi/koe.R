

library(ggplot2)

D <- read.table('data/ernoR3_data.txt', sep=',', header=T)

plot(D$gameNumber, D$gameInterval)

ggplot(D, aes(x=gameNumber, y=gameInterval, colour=factor(isStatic))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
  # + facet_grid(. ~ isStatic)

plot(D$gameNumber, D$finalInterval)

ggplot(D, aes(gameNumber, y=finalInterval, colour=factor(isStatic))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isStatic)

plot(D$gameNumber, D$previousIntervalChange)

ggplot(D, aes(gameNumber, y=previousIntervalChange, colour=factor(isStatic))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isStatic)