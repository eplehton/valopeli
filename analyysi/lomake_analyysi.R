library(plyr)
library(ggplot2)
library(car)
library(lsmeans)

#functions
{
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
}

#data bringing
{
ans <- read.table('kysely/kyselyt.txt', sep='\t', header=T)

attach(ans)
ans$sId[subId == "KH1"] <- "S01"
ans$sId[subId == "KH2"] <- "S02"
ans$sId[subId == "KH3"] <- "S03"
ans$sId[subId == "KH4"] <- "S04"
ans$sId[subId == "KH6"] <- "S06"
ans$sId[subId == "KH7"] <- "S07"
ans$sId[subId == "KH8"] <- "S08"
ans$sId[subId == "KH9"] <- "S09"
ans$sId[subId == "KH10"] <- "S10"
ans$sId[subId == "KH11"] <- "S11"
ans$sId[subId == "KH12"] <- "S12"
ans$sId[subId == "KH13"] <- "S13"
ans$sId[subId == "KH14"] <- "S14"
ans$sId[subId == "KH15"] <- "S15"
ans$sId[subId == "KH16"] <- "S16"
ans$sId[subId == "KH17"] <- "S17"
ans$sId[subId == "KH18"] <- "S18"
ans$sId[subId == "KH19"] <- "S19"
ans$sId[subId == "KH20"] <- "S20"
ans$sId[subId == "KH21"] <- "S21"
ans$sId[subId == "KH22"] <- "S22"
ans$sId[subId == "KH23"] <- "S23"
ans$sId[subId == "KH24"] <- "S24"
ans$sId[subId == "KH25"] <- "S25"
ans$sId[subId == "KH26"] <- "S26"
ans$sId[subId == "KH27"] <- "S27"
ans$sId[subId == "KH28"] <- "S28"
ans$sId[subId == "KH29"] <- "S29"
ans$sId[subId == "KH30"] <- "S30"
ans$sId[subId == "KH31"] <- "S31"
ans$sId[subId == "KH32"] <- "S32"
ans$sId[subId == "KH33"] <- "S33"
ans$sId[subId == "KH34"] <- "S34"
detach(ans)

attach(ans)
ans$roundId[kierros == 1] <- 5
ans$roundId[kierros == 2] <- 9
ans$roundId[kierros == 3] <- 13
detach(ans)

library(reshape)
ans <- rename(ans, c(subId="subId_old"))
ans <- rename(ans, c(sId="subId"))

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
}

# multiple regression and anovas
{
flow13.fm <- lm(flow13 ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(flow13.fm)
Anova(flow13.fm, type=3)
lsm <- lsmeans(flow13.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(flow13.fm, poly ~ group)
summary(lsm)

flow10.fm <- lm(flow10 ~ factor(sex) + age + liking + skill + f11 + f12 + f13, data = ans.roundmeans)
summary(flow10.fm)
Anova(flow10.fm, type=3)
lsm <- lsmeans(flow10.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(flow10.fm, poly ~ group)
summary(lsm)

difficulty.fm <- lm(difficulty ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(difficulty.fm)
Anova(difficulty.fm, type=3)
lsm <- lsmeans(difficulty.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(difficulty.fm, poly ~ group)
summary(lsm)


f13.fm <- lm(f13 ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(f13.fm)
Anova(f13.fm, type=3)
lsm <- lsmeans(f13.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(f13.fm, poly ~ group)
summary(lsm)

f12.fm <- lm(f12 ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(f12.fm)
Anova(f12.fm, type=3)
lsm <- lsmeans(f12.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(f12.fm, poly ~ group)
summary(lsm)

f11.fm <- lm(f11 ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(f11.fm)
Anova(f11.fm, type=3)
lsm <- lsmeans(f11.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(f11.fm, poly ~ group)
summary(lsm)

motiv3.fm <- lm(motiv3 ~ factor(group) + factor(sex) + age + liking + skill, data = ans.roundmeans)
summary(motiv3.fm)
Anova(motiv3.fm, type=3)
lsm <- lsmeans(motiv3.fm, pairwise ~ group)
summary(lsm)
lsm <- lsmeans(motiv3.fm, poly ~ group)
summary(lsm)

}

# graphs
{
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

ggplot(ans.roundmeans, aes(x=factor(group), y=f02)) + 
  geom_point() + 
  geom_boxplot()

ggplot(ans.roundmeans, aes(x=factor(group), y=flow13)) + 
  geom_point() + 
  geom_boxplot()

ggplot(ans.roundmeans, aes(x=factor(group), y=flow3)) + 
  geom_point() + 
  geom_boxplot()

ggplot(ans.roundmeans, aes(x=factor(group), y=f11)) + 
  geom_point() + 
  geom_boxplot()

flow_plot <- ggplot(ans.roundmeans, aes(x=factor(group), y=flow13, fill = factor(group))) + 
  geom_point() + 
  geom_boxplot() +
  guides(fill=FALSE) +
  theme_bw() +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  xlab("Group") + 
  ylab(paste("Rating")) + 
  theme(axis.title.x = element_text(size=16),
        axis.text.x  = element_text(size=14)) + 
  theme(axis.title.y = element_text(angle=90, size=16),
        axis.text.y  = element_text(size=14)) +
  scale_x_discrete(breaks=c("1", "2", "3"),
                   labels=c("Easy", "Medium", "Hard")) +
  ggtitle("The amount of flow felt") + 
  theme(plot.title = element_text(size = 16)) + 
  expand_limits(y=c(0,7))


motiv_plot <- ggplot(ans.roundmeans, aes(x=factor(group), y=motiv3, fill = factor(group))) + 
  geom_point() + 
  geom_boxplot() +
  guides(fill=FALSE) +
  theme_bw() +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  xlab("Group") + 
  ylab(paste("Rating")) + 
  theme(axis.title.x = element_text(size=16),
        axis.text.x  = element_text(size=14)) + 
  theme(axis.title.y = element_text(angle=90, size=16),
        axis.text.y  = element_text(size=14)) +
  scale_x_discrete(breaks=c("1", "2", "3"),
                   labels=c("Easy", "Medium", "Hard")) +
  ggtitle("Motivation to continue playing") + 
  theme(plot.title = element_text(size = 16)) + 
  expand_limits(y=c(0,7))


difficulty_plot1 <- ggplot(ans.roundmeans, aes(x=factor(group), y=difficulty, fill = factor(group))) + 
  geom_point() + 
  geom_boxplot() +
  guides(fill=FALSE) +
  theme_bw() +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  xlab("Group") + 
  ylab(paste("Rating")) + 
  theme(axis.title.x = element_text(size=16),
        axis.text.x  = element_text(size=14)) + 
  theme(axis.title.y = element_text(angle=90, size=16),
        axis.text.y  = element_text(size=14)) +
  scale_x_discrete(breaks=c("1", "2", "3"),
                   labels=c("Easy", "Medium", "Hard")) +
  ggtitle("Is there a right amount of challenge") + 
  theme(plot.title = element_text(size = 16)) + 
  expand_limits(y=c(0,7))


difficulty_plot2 <- ggplot(ans.roundmeans, aes(x=factor(group), y=f13, fill = factor(group))) + 
  geom_point() + 
  geom_boxplot() +
  guides(fill=FALSE) +
  theme_bw() +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  xlab("Group") + 
  ylab(paste("Rating")) + 
  theme(axis.title.x = element_text(size=16),
        axis.text.x  = element_text(size=14)) + 
  theme(axis.title.y = element_text(angle=90, size=16),
        axis.text.y  = element_text(size=14)) +
  scale_x_discrete(breaks=c("1", "2", "3"),
                       labels=c("Hard", "Medium", "Easy")) +
  ggtitle("Percieved difficulty level") + 
  theme(plot.title = element_text(size = 16)) + 
  expand_limits(y=c(0,9))

multiplot(flow_plot, motiv_plot, difficulty_plot1, difficulty_plot2, cols=2)

}
