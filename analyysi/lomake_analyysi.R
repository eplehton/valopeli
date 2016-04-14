library(plyr)
library(ggplot2)
library(psych)

ans <- read.table('kysely/kyselyt.txt', sep='\t', header=T)

attach(ans)
ans$f11rec7[f11 == 1] <- 1
ans$f11rec7[f11 == 2] <- 2.5
ans$f11rec7[f11 == 3] <- 4
ans$f11rec7[f11 == 4] <- 5.5
ans$f11rec7[f11 == 5] <- 7
ans$f11rec7[f11 == 6] <- 5.5
ans$f11rec7[f11 == 7] <- 4
ans$f11rec7[f11 == 8] <- 2.5
ans$f11rec7[f11 == 9] <- 1
detach(ans)

attach(ans)
ans$f12rec7[f12 == 1] <- 1
ans$f12rec7[f12 == 2] <- 2.5
ans$f12rec7[f12 == 3] <- 4
ans$f12rec7[f12 == 4] <- 5.5
ans$f12rec7[f12 == 5] <- 7
ans$f12rec7[f12 == 6] <- 5.5
ans$f12rec7[f12 == 7] <- 4
ans$f12rec7[f12 == 8] <- 2.5
ans$f12rec7[f12 == 9] <- 1
detach(ans)

attach(ans)
ans$f13rec7[f13 == 1] <- 1
ans$f13rec7[f13 == 2] <- 2.5
ans$f13rec7[f13 == 3] <- 4
ans$f13rec7[f13 == 4] <- 5.5
ans$f13rec7[f13 == 5] <- 7
ans$f13rec7[f13 == 6] <- 5.5
ans$f13rec7[f13 == 7] <- 4
ans$f13rec7[f13 == 8] <- 2.5
ans$f13rec7[f13 == 9] <- 1
detach(ans)

ans <- transform( ans,
                  flow10 = (f01 + f02 + f03 + f04 + f05 + f06 + f07 + f08 + f09 + f10)/10,
                  flow13 = (f01 + f02 + f03 + f04 + f05 + f06 + f07 + f08 + f09 + f10 + f11rec7 + f12rec7 + f13rec7)/13,
                  flow3 = (f11 + f12 + f13)/3,
                  motiv3 = (m01 + m02 + m03)/3,
                  difficulty = (f01 + f13rec7)/2
)


ans.roundmeans <- ddply (ans, .(group, subId), summarise,
                 f01 = mean(f01),
                 f02 = mean(f02),
                 f03 = mean(f03),
                 f04 = mean(f04),
                 f05 = mean(f05),
                 f06 = mean(f06),
                 f07 = mean(f07),
                 f08 = mean(f08),
                 f09 = mean(f09),
                 f10 = mean(f10),
                 f11 = mean(f11),
                 f12 = mean(f12),
                 f13 = mean(f13),
                 f11rec7 = mean (f11rec7),
                 f12rec7 = mean (f12rec7),
                 f13rec7 = mean (f13rec7),
                 m01 = mean(m01),
                 m02 = mean(m02),
                 m03 = mean(m03),
                 virkeys = mean(virkeys),
                 flow10 = mean(flow10),
                 flow13 = mean(flow13),
                 flow3 = mean(flow3),
                 motiv3 = mean(motiv3),
                 difficulty = mean(difficulty),
                 age = mean(age),
                 sex = mean(sex1n0m),
                 hand = mean(handedness1o0v),
                 playtime = mean(playtime),
                 gamespeed = mean(gamespeed),
                 game_exp = mean(game_exp),
                 liking = mean(liking),
                 skill = mean(skill)
)

ans.roundmeans.group <- ddply(ans.roundmeans, .(group), summarise,
                              f01 = mean(f01),
                              f02 = mean(f02),
                              f03 = mean(f03),
                              f04 = mean(f04),
                              f05 = mean(f05),
                              f06 = mean(f06),
                              f07 = mean(f07),
                              f08 = mean(f08),
                              f09 = mean(f09),
                              f10 = mean(f10),
                              f11 = mean(f11),
                              f12 = mean(f12),
                              f13 = mean(f13),
                              f11rec7 = mean (f11rec7),
                              f12rec7 = mean (f12rec7),
                              f13rec7 = mean (f13rec7),
                              m01 = mean(m01),
                              m02 = mean(m02),
                              m03 = mean(m03),
                              virkeys = mean(virkeys),
                              flow10 = mean(flow10),
                              flow13 = mean(flow13),
                              flow3 = mean(flow3),
                              motiv3 = mean(motiv3),
                              difficulty = mean(difficulty),
                              age = mean(age),
                              sex = mean(sex),
                              hand = mean(hand),
                              playtime = mean(playtime),
                              gamespeed = mean(gamespeed),
                              game_exp = mean(game_exp),
                              liking = mean(liking),
                              skill = mean(skill)
)

ans.group <- ddply(ans, .(group, kierros), summarise,
                   f01 = mean(f01),
                   f02 = mean(f02),
                   f03 = mean(f03),
                   f04 = mean(f04),
                   f05 = mean(f05),
                   f06 = mean(f06),
                   f07 = mean(f07),
                   f08 = mean(f08),
                   f09 = mean(f09),
                   f10 = mean(f10),
                   f11 = mean(f11),
                   f12 = mean(f12),
                   f13 = mean(f13),
                   f11rec7 = mean (f11rec7),
                   f12rec7 = mean (f12rec7),
                   f13rec7 = mean (f13rec7),
                   m01 = mean(m01),
                   m02 = mean(m02),
                   m03 = mean(m03),
                   virkeys = mean(virkeys),
                   flow10 = mean(flow10),
                   flow13 = mean(flow13),
                   flow3 = mean(flow3),
                   motiv3 = mean(motiv3),
                   difficulty = mean(difficulty),
                   age = mean(age),
                   sex = mean(sex1n0m),
                   hand = mean(handedness1o0v),
                   playtime = mean(playtime),
                   gamespeed = mean(gamespeed),
                   game_exp = mean(game_exp),
                   liking = mean(liking),
                   skill = mean(skill)
)

# multiple regression

flowproduced <- lm(flow13 ~ group + sex + age + game_exp + liking + skill, data = ans.roundmeans)
summary(flowproduced)

#anova

flowmodel <- aov(flow13 ~ group, data = ans.roundmeans)
summary(flowmodel)
plot(flowmodel)

by(ans$flow13, list(ans$kierros, ans$group), stat.desc, basic = FALSE)


# graphs

ggplot(ans.group, aes(x=kierros, y=flow10, colour=factor(group))) + 
  geom_point() +
  geom_line()

ggplot(ans.group, aes(x=kierros, y=flow13, colour=factor(group))) + 
  geom_point() +
  geom_line()

ggplot(ans.group, aes(x=kierros, y=flow3, colour=factor(group))) + 
  geom_point() +
  geom_line()


ggplot(ans.roundmeans, aes(x=factor(group), y=flow10)) + 
  geom_point() + 
  geom_boxplot()


ggplot(ans.roundmeans, aes(x=factor(group), y=flow13)) + 
  geom_point() + 
  geom_boxplot()


ggplot(ans.roundmeans, aes(x=factor(group), y=flow3)) + 
  geom_point() + 
  geom_boxplot()

ggplot(ans.roundmeans, aes(x=factor(group), y=difficulty)) + 
  geom_point() + 
  geom_boxplot()

