library(plyr)
library(ggplot2)
library(car)
library(nlme)
library(lsmeans)

#helper functions *********************************************************
{

#summarySE

summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  library(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = mean   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

## Norms the data within specified groups in a data frame; it normalizes each
## subject (identified by idvar) so that they have the same mean, within each group
## specified by betweenvars.
##   data: a data frame.
##   idvar: the name of a column that identifies each subject (or matched subjects)
##   measurevar: the name of a column that contains the variable to be summariezed
##   betweenvars: a vector containing names of columns that are between-subjects variables
##   na.rm: a boolean that indicates whether to ignore NA's
normDataWithin <- function(data=NULL, idvar, measurevar, betweenvars=NULL,
                           na.rm=FALSE, .drop=TRUE) {
  library(plyr)
  
  # Measure var on left, idvar + between vars on right of formula.
  data.subjMean <- ddply(data, c(idvar, betweenvars), .drop=.drop,
                         .fun = function(xx, col, na.rm) {
                           c(subjMean = mean(xx[,col], na.rm=na.rm))
                         },
                         measurevar,
                         na.rm
  )
  
  # Put the subject means with original data
  data <- merge(data, data.subjMean)
  
  # Get the normalized data in a new column
  measureNormedVar <- paste(measurevar, "_norm", sep="")
  data[,measureNormedVar] <- data[,measurevar] - data[,"subjMean"] +
    mean(data[,measurevar], na.rm=na.rm)
  
  # Remove this subject mean column
  data$subjMean <- NULL
  
  return(data)
}

## Summarizes data, handling within-subjects variables by removing inter-subject variability.
## It will still work if there are no within-S variables.
## Gives count, un-normed mean, normed mean (with same between-group mean),
##   standard deviation, standard error of the mean, and confidence interval.
## If there are within-subject variables, calculate adjusted values using method from Morey (2008).
##   data: a data frame.
##   measurevar: the name of a column that contains the variable to be summariezed
##   betweenvars: a vector containing names of columns that are between-subjects variables
##   withinvars: a vector containing names of columns that are within-subjects variables
##   idvar: the name of a column that identifies each subject (or matched subjects)
##   na.rm: a boolean that indicates whether to ignore NA's
##   conf.interval: the percent range of the confidence interval (default is 95%)
summarySEwithin <- function(data=NULL, measurevar, betweenvars=NULL, withinvars=NULL,
                            idvar=NULL, na.rm=FALSE, conf.interval=.95, .drop=TRUE) {
  
  # Ensure that the betweenvars and withinvars are factors
  factorvars <- vapply(data[, c(betweenvars, withinvars), drop=FALSE],
                       FUN=is.factor, FUN.VALUE=logical(1))
  
  if (!all(factorvars)) {
    nonfactorvars <- names(factorvars)[!factorvars]
    message("Automatically converting the following non-factors to factors: ",
            paste(nonfactorvars, collapse = ", "))
    data[nonfactorvars] <- lapply(data[nonfactorvars], factor)
  }
  
  # Get the means from the un-normed data
  datac <- summarySE(data, measurevar, groupvars=c(betweenvars, withinvars),
                     na.rm=na.rm, conf.interval=conf.interval, .drop=.drop)
  
  # Drop all the unused columns (these will be calculated with normed data)
  datac$sd <- NULL
  datac$se <- NULL
  datac$ci <- NULL
  
  # Norm each subject's data
  ndata <- normDataWithin(data, idvar, measurevar, betweenvars, na.rm, .drop=.drop)
  
  # This is the name of the new column
  measurevar_n <- paste(measurevar, "_norm", sep="")
  
  # Collapse the normed data - now we can treat between and within vars the same
  ndatac <- summarySE(ndata, measurevar_n, groupvars=c(betweenvars, withinvars),
                      na.rm=na.rm, conf.interval=conf.interval, .drop=.drop)
  
  # Apply correction from Morey (2008) to the standard error and confidence interval
  #  Get the product of the number of conditions of within-S variables
  nWithinGroups    <- prod(vapply(ndatac[,withinvars, drop=FALSE], FUN=nlevels,
                                  FUN.VALUE=numeric(1)))
  correctionFactor <- sqrt( nWithinGroups / (nWithinGroups-1) )
  
  # Apply the correction factor
  ndatac$sd <- ndatac$sd * correctionFactor
  ndatac$se <- ndatac$se * correctionFactor
  ndatac$ci <- ndatac$ci * correctionFactor
  
  # Combine the un-normed means with the normed results
  merge(datac, ndatac)
}

#******************************************************************************************************
}

#read data
{
D <- read.table('data/datat.txt', sep=',', header=T)

D.tests.flow <- merge(D, ans, by=c("subId", "roundId"))

success <- ddply(D, .(group, subId, roundId, isTestGame), summarise,
                    SIS = mean(successInStatic),
                    PTS = mean(pressesToSuccess),
                    Inter = mean(gameInterval),
                    MI = min(gameInterval),
                    PIC = mean(previousIntervalChange))

success.flow <- merge(success, ans, by=c("subId", "roundId"))

success.group <- ddply(D, .(group, roundId, isTestGame), summarise,
                       SIS = mean(successInStatic),
                       SISsd = sd(successInStatic),
                       PTS = mean(pressesToSuccess),
                       Inter = mean(gameInterval),
                       PIC = mean(previousIntervalChange)) 

success.subject <-  ddply(D, .(subId, roundId, isTestGame), summarise,
                       SIS = mean(successInStatic),
                       SISsd = sd(successInStatic),
                       PTS = mean(pressesToSuccess),
                       Inter = mean(gameInterval),
                       PIC = mean(previousIntervalChange)) 
}

#anova
{
success.tests$roundFact <- ordered(success.tests$roundId)
success.tests$groupFact <- factor(success.tests$group)

fm <- lm(SIS ~ roundFact * groupFact, data=success.tests)
summary(fm)
options("contrasts"=c("contr.sum", "contr.poly"))
Anova(fm, type=3)
}

# mixed effects model
{
# fixed efektejä "joista ollaan kiinnostuneita"
# sen lisäksi random efektillä otetaan huomioon varianssia josta ei olle kiinnostuneita


#round and group effects on SIS
{
options(contrasts = c("contr.sum", "contr.poly"))

success.tests <- success[ success$isTestGame == 1,]
success.tests$group <- factor(success.tests$group)
success.tests$roundId <- ordered(success.tests$roundId)



fm <- lme(SIS ~ roundId*group, random = ~ 1 | subId, data=success.tests)
intervals(fm)
summary(fm)
plot(fm)
qqnorm(resid(fm))

anova(fm, type="marginal")


lsmeans(fm, pairwise ~ group)
lsmeans(fm, pairwise ~ roundId)
lsm <- lsmeans(fm, poly ~ roundId)
summary(lsm)
}

#flow's effect on learning
{
options(contrasts = c("contr.sum", "contr.poly"))

success.flow$roundId <- ordered(success.flow$roundId)

fm <- lme(SIS ~ flow10, random = ~ 1 | subId, data=success.flow)
intervals(fm)
summary(fm)

anova(fm, type = "marginal")

}
}

# correlations plot with success
{

ggplot(success.flow, aes(x=f12, y=SIS)) +
  geom_point(shape=1,
             position=position_jitter(width=0.5,height=0)) +    # Use hollow circles
  geom_smooth(method=lm,   # Add linear regression line
              se=FALSE)    # Don't add shaded confidence region
}

# regression analysis
{
SIS.fm <- lm(SIS ~  flow10 + motiv3 + f11 + f12 + f13 + age + liking + skill, data = success.flow)
summary(SIS.fm)
Anova(SIS.fm, type=3)

f12.fm <- lm(f12 ~  flow10 + motiv3 + f11 + SIS + f13 + age + liking + skill, data = success.flow)
summary(f12.fm)
Anova(f12.fm, type=3)
}

#group success graphs
{
{
successSummary <- summarySEwithin(success, measurevar = "SIS", 
                                  betweenvars = c("group","isTestGame"), 
                                  withinvars = "roundId", 
                                  idvar = "subId",
                                  na.rm = FALSE, conf.interval = .95, .drop = TRUE)

pd <- position_dodge(.7)

labels <- c("0" = "Training", "1" = "Tests")

pdf("plots.pdf", width=8/2.54, height=(8*(344/422))/2.54)

ggplot(successSummary, aes(x=ordered(roundId), y=SIS, colour=factor(group), group=factor(group))) + 
  geom_point(position = pd, size = 1.2, aes(shape = factor(group))) +
  geom_line(position = pd, size = 0.4) +
  geom_errorbar(width=1, size = 0.4, aes(ymin=SIS-ci, ymax=SIS+ci), position = pd) +
  xlab("Round") + 
  theme_classic() +
  scale_shape_discrete(name="", labels=c("1"="hard", "2"="medium", "3"="easy")) +
  scale_colour_discrete(name="", labels=c("1"="hard", "2"="medium", "3"="easy")) +
  theme(legend.title=element_blank()) +
  theme(legend.text = element_text(size = 8)) +
  theme(legend.background = element_rect(fill="transparent", colour=NA)) + 
  theme(legend.position= c(1.14, 0.52)) + 
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  theme(axis.title.x = element_text(size=10),
        axis.text.x  = element_text(size=6),
        axis.ticks.x = element_blank()) + 
  theme(axis.title.y = element_text(angle=90, size=10),
        axis.text.y  = element_text(size=6)) +
  ylab("Successrate") + 
  facet_grid(isTestGame ~ ., labeller=labeller(isTestGame = labels), scales = "free") +
    theme(strip.text.y = element_text(size = 10, angle=0),
        strip.background = element_rect(colour ="white", fill = "#FFFFFF")) +
  ggtitle("Successrate in training and testgames") + 
  theme(plot.title = element_text(size = 12))

dev.off()
}

ggplot(success.group, aes(x=roundId, y=SIS, shape=factor(group), colour=factor(group))) + 
  geom_point(size=3) +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free") +
  xlab("Round") + 
  scale_shape_discrete(name="", labels=c("1"="20 %", "2"="50 %", "3"="90 %")) +
  scale_colour_discrete(name="", labels=c("1"="20 %", "2"="50 %", "3"="90 %")) +
  theme_bw(base_size=12)

ggplot(success, aes(x=roundId, y=SIS, colour=factor(group))) + 
  stat_summary(fun.data="mean_cl_normal", geom="errorbar", position=pd) +
  geom_line(data=success.group) +
  facet_grid(isTestGame ~ ., scales = "free")


ggplot(success.group, aes(x=roundId, y=PTS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  geom_errorbar(width=.1, aes(ymin=SIS-ci, ymax=SIS+ci)) +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success.group, aes(x=roundId, y=Inter, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success.group, aes(x=roundId, y=PIC, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")
}

#individual success graphs
{

gamelabels <- c("0" = "Training", "1" = "Tests")
grouplabels <- c("1" = "Hard", "2" = "Medium", "3" = "Easy")
ggplot(success, aes(x=ordered(roundId), y=SIS, colour=factor(subId), group=factor(group))) + 
  geom_point(size = 3.5) +
  geom_line(size = 0.6) +
  xlab("Round") + 
  theme_bw() +
  theme(panel.grid.minor=element_blank(),
        panel.grid.major=element_blank()) +
  theme(legend.position="none") +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.major.x=element_blank()) + 
  theme(axis.title.x = element_text(size=18),
        axis.text.x  = element_text(size=16),
        axis.ticks.x = element_blank()) + 
  theme(axis.title.y = element_text(angle=0, size=18),
        axis.text.y  = element_text(size=16)) +
  ylab("Rate") + 
  facet_grid(isTestGame ~ group, labeller=labeller(isTestGame = gamelabels, group = grouplabels), scales = "free") +
  theme(strip.text.y = element_text(size = 18, angle=0, face="bold"),
        strip.text.x = element_text(size = 18, angle=0, face="bold"),
        strip.background = element_rect(colour ="white", fill = "#FFFFFF")) +
  ggtitle("Individual successrates in training and testgames") + 
  theme(plot.title = element_text(size = 18))

ggplot(success, aes(x=roundId, y=SIS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ group, scales = "free")

success.tests <- success[ success$isTestGame == 1,]
ggplot(success.tests, aes(x=roundId, y=SIS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(. ~ group, scales = "free")

ggplot(success, aes(x=roundId, y=PTS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success, aes(x=roundId, y=MI, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")
}

#splitted only successful games
{

D.splitted <- split(D, D$successInStatic)

onlySuccess <- ddply(D.splitted$`1`, .(subId, roundId, isTestGame, group), summarise,
                     SIS = mean(successInStatic),
                     PTS = mean(pressesToSuccess),
                     Inter = mean(gameInterval),
                     MI = min(gameInterval),
                     PIC = mean(previousIntervalChange))  

onlySuccess.group <- ddply(D.splitted$`1`, .(group, roundId, isTestGame), summarise,
                       SIS = mean(successInStatic),
                       PTS = mean(pressesToSuccess),
                       Inter = mean(gameInterval),
                       PIC = mean(previousIntervalChange)) 

onlySuccess.group.MMI <- ddply(onlySuccess, .(group, roundId, isTestGame), summarise,
                                MMI = mean(MI))
}


#Succesful interval mins
{
ggplot(onlySuccess, aes(x=roundId, y=MI, colour=factor(subId))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ group, scales = "free")

ggplot(onlySuccess, aes(x=factor(group), y=MI)) + 
  geom_boxplot() +
  facet_grid(isTestGame ~ ., scales = "free")


#Succesful interval means per subject

ggplot(onlySuccess.group, aes(x=roundId, y=Inter, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

#Succesful min means per group

ggplot(onlySuccess.group.MMI, aes(x=roundId, y=MMI, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")
}



