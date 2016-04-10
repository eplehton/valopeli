library(plyr)
library(ggplot2)
library(psych)

answersData <- read.table('kysely.txt', sep='\t', header=T)

ans.roundmeans <- ddply(answersData, .(group, subId), summarise,
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
                 mvirkeys = mean(virkeys),
                 mflow10 = mean(mf01, mf02, mf03, mf04, mf05, mf06, mf07, mf08, mf09, mf10),
                 motiv3 = mean(mm01, mm02, mm03)

ans.group.roundmeans <- ddply(ans.roundmeans, .(group), summarise,
                     gmf01 = mean(mf01),
                     gmf02 = mean(mf02),
                     gmf03 = mean(mf03),
                     gmf04 = mean(mf04),
                     gmf05 = mean(mf05),
                     gmf06 = mean(mf06),
                     gmf07 = mean(mf07),
                     gmf08 = mean(mf08),
                     gmf09 = mean(mf09),
                     gmf10 = mean(mf10),
                     gmf11 = mean(mf11),
                     gmf12 = mean(mf12),
                     gmf13 = mean(mf13),
                     gmm01 = mean(mm01),
                     gmm02 = mean(mm02),
                     gmm03 = mean(mm03),
                     gmvirkeys = mean(mvirkeys),
                     gmflow10 = mean(gmf01, gmf02, gmf03, gmf04, gmf05, gmf06, gmf07, gmf08, gmf09, gmf10))

ans.group <- ddply(answersData, .(group, kierros), summarise,
                     rmf01 = mean(f01),
                     rmf02 = mean(f02),
                     rmf03 = mean(f03),
                     rmf04 = mean(f04),
                     rmf05 = mean(f05),
                     rmf06 = mean(f06),
                     rmf07 = mean(f07),
                     rmf08 = mean(f08),
                     rmf09 = mean(f09),
                     rmf10 = mean(f10),
                     flow10 = mean(rmf01, rmf02, rmf03, rmf04, rmf05, rmf06, rmf07, rmf08, rmf09, rmf10),
                     rmm01 = mean(m01),
                     rmm02 = mean(m02),
                     rmm03 = mean(m03),
                     rmvirkeys = mean(virkeys))

ggplot(ans.group, aes(x=kierros, y=flow10, colour=factor(group))) + 
  geom_point() +
  geom_line()
  
ggplot(ans.group.roundmeans, aes(x=group, y=gmflow10)) + 
  geom_point() + 
  geom_line()











#group ans per questions

ggplot(ans.group.roundmeans, aes(x=group, y=gmf01)) + 
  geom_point() + 
  geom_line()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf02)) + 
  geom_point() 

ggplot(ans.group.roundmeans, aes(x=group, y=gmf03)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf04)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf05)) + 
  geom_point() 

ggplot(ans.group.roundmeans, aes(x=group, y=gmf06)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf07)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf08)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf09)) + 
  geom_point() 

ggplot(ans.group.roundmeans, aes(x=group, y=gmf10)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf11)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmf12)) + 
  geom_point() +

ggplot(ans.group.roundmeans, aes(x=group, y=gmf13)) + 
  geom_point() 

ggplot(ans.group.roundmeans, aes(x=group, y=gmm01)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmm02)) + 
  geom_point() 

ggplot(ans.group.roundmeans, aes(x=group, y=gmm03)) + 
  geom_point()

ggplot(ans.group.roundmeans, aes(x=group, y=gmvirkeys)) + 
  geom_point()

#answers per question 

ggplot(ans.roundmeans, aes(x=group, y=mf01)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf02)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf03)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf04)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf05)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf06)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf07)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf08)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf09)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf10)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf11)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf12)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mf13)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mm01)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mm02)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mm03)) + 
  geom_point() +
  geom_jitter()

ggplot(ans.roundmeans, aes(x=group, y=mvirkeys)) + 
  geom_point() +
  geom_jitter()


