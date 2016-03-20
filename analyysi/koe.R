library(plyr)
library(ggplot2)
library(psych)

D <- read.table('data/datat.txt', sep=',', header=T)

describeBy(D, group = D$isTestGame)



success <- ddply(D, .(subId, roundId, isTestGame), summarise,
                    SIS = mean(successInStatic),
                    PTS = mean(pressesToSuccess),
                    Inter = mean(gameInterval),
                    MI = min(gameInterval),
                    PIC = mean(previousIntervalChange))                 

success.group <- ddply(D, .(group, roundId, isTestGame), summarise,
                       SIS = mean(successInStatic),
                       PTS = mean(pressesToSuccess),
                       Inter = mean(gameInterval),
                       PIC = mean(previousIntervalChange)) 


#individual success

describeBy(success, group = success$subId)

ggplot(success, aes(x=roundId, y=SIS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success, aes(x=roundId, y=PTS, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success, aes(x=roundId, y=MI, colour=subId)) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

#groups success

describeBy(success.group, group = success.group$group)

ggplot(success.group, aes(x=roundId, y=SIS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success.group, aes(x=roundId, y=PTS, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")

ggplot(success.group, aes(x=roundId, y=Inter, colour=factor(group))) + 
  geom_point() +
  geom_line() +
  facet_grid(isTestGame ~ ., scales = "free")


#splitted only successful games

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
#Succesful interval mins

ggplot(onlySuccess, aes(x=roundId, y=MI, colour=factor(subId))) + 
  geom_point() +
  geom_line() +
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

#splitted only succesfultests

D.splittedTest <- split(D.splitted$`1`, D$isTestGame)

