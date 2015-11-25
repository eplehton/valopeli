

library(ggplot2)
library(psych)

D <- read.table('data/Pilot-IA_data.txt', sep=',', header=T)

describeBy(D, group = D$isStatic)

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

plot(D$gameNumber, D$successInStatic)

ggplot(D, aes(gameNumber, y=successInStatic, colour=factor(isStatic))) +
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

