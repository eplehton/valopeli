

library(ggplot2)
library(psych)

D <- read.table('data/erno3_data.txt', sep=',', header=T)

describeBy(D, group = D$isTestGame)

plot(D$gameNumber, D$gameInterval)

ggplot(D, aes(x=gameNumber, y=gameInterval, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
  # + facet_grid(. ~ isTestGame)

plot(D$gameNumber, D$finalInterval)

ggplot(D, aes(game, y=finalInterval, colour=factor(isTestGame))) +
  geom_point() + 
  stat_smooth(method="lm") +
  geom_line() +
  theme_bw() + facet_grid(. ~ isTestGame)

plot(D$gameNumber, D$successInStatic)

ggplot(D, aes(gameNumber, y=successInStatic, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isTestGame)

plot(D$gameNumber, D$previousIntervalChange)

ggplot(D, aes(gameNumber, y=previousIntervalChange, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isStatic)

