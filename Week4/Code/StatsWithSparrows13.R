#!/bin/env Rscript

# Author: ph-u
# Script: StatsWithSparrows13.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

d<-read.table("../Data/SparrowSize.txt", header = T)
d.1<-d[which(!is.na(d$Wing)),]
hist(d.1$Wing)
m.1<-lm(d.1$Wing~d.1$Sex.1)
summary(m.1)
boxplot(d.1$Wing~d.1$Sex.1)
anova(m.1)
t.test(d.1$Wing~d.1$Sex.1, var.equal=T)
boxplot(d.1$Wing~d.1$BirdID, ylab = "Wing length (mm)")

library(dplyr)
tbl_df(d.1)
# glimpse(d.1)
d$Mass %>% cor.test(d$Tarsus, na.rm=T)
d.1 %>% group_by(BirdID) %>% summarise(count=length(BirdID))
count(d.1, BirdID)
d.1 %>% group_by(BirdID) %>% summarise(count=length(BirdID)) %>% count(count)
count(d.1, d.1$BirdID) %>% count(count)
m.3<-lm(d.1$Wing~as.factor(d.1$BirdID))
anova(m.3)
boxplot(d$Mass~d$Year)
m.2<-lm(d$Mass~as.factor(d$Year))
anova(m.2)
summary(m.2)
t(model.matrix(m.2))

## exercise
d.2<-d[which(d$Year!=2000),]
mm.1<-anova(lm(d.2$Mass~d.2$Sex.1)) ## more useful
aov(d.2$Mass~d.2$Sex.1)
aov(lm(d.2$Mass~d.2$Sex.1)) ## same as above
mm.1;summary(mm.1)
