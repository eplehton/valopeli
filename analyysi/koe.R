library(plyr)
library(ggplot2)
library(psych)

D <- read.table('data/datat.txt', sep=',', header=T)

describeBy(D, group = D$isTestGame)

plot(D$gameNumber, D$gameInterval)


success <- ddply(D, .(subId, roundId, isTestGame), summarise,
                    SIS = mean(successInStatic),
                    PTS = mean(pressesToSuccess))

ggplot(success, aes(x=roundId, y=SIS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)

ggplot(success, aes(x=roundId, y=PTS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)


success.group <- ddply(D, .(group, roundId, isTestGame), summarise,
                 SIS = mean(successInStatic),
                 PTS = mean(pressesToSuccess))

ggplot(success.group, aes(x=roundId, y=SIS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)

ggplot(success.group, aes(x=roundId, y=PTS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)


ggplot(D, aes(x=gameNumber, y=gameInterval, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
  # + facet_grid(. ~ isTestGame)

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

plot(D$gameNumber, D$pressesToSuccess)

ggplot(D, aes(gameNumber, y=pressesToSuccess, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isStatic)

plot(D$gameNumber, D$duration)

ggplot(D, aes(gameNumber, y=duration, colour=factor(isTestGame))) +
  geom_point() + 
  geom_line() +
  theme_bw() 
# + facet_grid(. ~ isStatic)

# Simple Bar Plot 
counts <- table(D$successInStatic, D$roundId)
barplot(counts, main="successInStatic",
        xlab="roundId", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

