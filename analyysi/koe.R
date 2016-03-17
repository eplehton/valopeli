library(plyr)
library(ggplot2)
library(psych)

D <- read.table('data/datat.txt', sep=',', header=T)

describeBy(D, group = D$isTestGame)

success <- ddply(D, .(subId, roundId, isTestGame), summarise,
                    SIS = mean(successInStatic),
                    PTS = mean(pressesToSuccess))

describeBy(success, group = success$subId)

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

describeBy(success.group, group = success.group$group)

ggplot(success.group, aes(x=roundId, y=SIS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)

ggplot(success.group, aes(x=roundId, y=PTS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ .)


# Simple Bar Plot 
counts <- table(success.group)
barplot(counts)

