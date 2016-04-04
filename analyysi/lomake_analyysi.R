library(plyr)
library(ggplot2)
library(psych)

answersData <- read.table('kysely.txt', sep='\t', header=T)

sub.answers <- ddply(answersData, .(group, subId), summarise,
                 mf01 = mean(f01),
                 mf02 = mean(f02),
                 mf03 = mean(f03),
                 mf04 = mean(f04),
                 mf05 = mean(f05),
                 mf06 = mean(f06),
                 mf07 = mean(f07),
                 mf08 = mean(f08),
                 mf09 = mean(f09),
                 mf10 = mean(f10),
                 mf11 = mean(f11),
                 mf12 = mean(f12),
                 mf13 = mean(f13),
                 mm01 = mean(m01),
                 mm02 = mean(m02),
                 mm03 = mean(m03),
                 mvirkeys = mean(virkeys))    

ggplot(sub.answers, aes(x=group, y=mf01)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf02)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf03)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf04)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf05)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf06)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf07)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf08)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf09)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf10)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf11)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf12)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mf13)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mm01)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mm02)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mm03)) + 
  geom_point() +
  geom_jitter()

ggplot(sub.answers, aes(x=group, y=mvirkeys)) + 
  geom_point() +
  geom_jitter()


