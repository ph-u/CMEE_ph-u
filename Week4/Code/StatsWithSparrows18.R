#!/bin/env Rscript

# Author: ph-u
# Script: StatsWithSparrows18.R
# Desc: minimal R function with two in-script tests
# Input: none -- run in R console line-by-line
# Output: R terminal output
# Arguments: 0
# Date: Oct 2019

a<-read.table("../Data/ObserverRepeatability.txt", header = T)
library(dplyr)
a %>% group_by(StudentID) %>% summarise(count=length(StudentID))
a %>% group_by(StudentID) %>% summarise(count=length(StudentID)) %>% summarise(length(StudentID))
a %>% group_by(StudentID) %>% summarise(count=length(StudentID)) %>% summarise(sum(count))
length(a$StudentID)
a %>% group_by(StudentID) %>% summarise(count=length(StudentID)) %>% summarise(sum(count^2))
mod<-lm(a$Tarsus~a$StudentID)
mod<-lm(a$Tarsus~a$Leg+a$Handedness+a$StudentID)
anova(mod)
library(lme4)
lmm<-lmer(a$Tarsus~a$Leg+a$Handedness+(1|a$StudentID))
summary(lmm)
var(a$Tarsus)
