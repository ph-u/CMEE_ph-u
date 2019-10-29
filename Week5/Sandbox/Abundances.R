library(ggplot2)
library(minpack.lm)

time<-c(0,2,4,6,8,10,12,16,20,24) ## timepoints, in hours
log_cells<-c(3.62, 3.62, 3.63, 4.14, 5.23, 6.27, 7.57, 8.38, 8.70, 8.69) # logged cell counts - more on this below
set.seed(1234) ## set seed to ensure you always get the same random seq if fluctuates
data<-data.frame(time, log_cells+rnorm(length(time), sd=.1)) ## add some random error
names(data)<-c("t", "LogN")

ggplot(data, aes(x=t, y=LogN))+geom_point()
baranyi_model<-function(t, r_max, N_max, N_0, t_lag){ ## bayanyi model (Baranyi 1993)
  return(N_max+log10((-1+exp(r_max*t_lag) +exp(r_max*t))/(exp(r_max*t)-1 +exp(r_max*t_lag) *10^(N_max-N_0))))
}

buchanan_model<-function(t, r_max, N_max, N_0, t_lag){ ## Buchanan model -- three phase logistic (Buchanan 1997)
  return(N_0+(t>=t_lag) * (t<=(t_lag+(N_max-N_0)*log(10)/r_max)) *r_max*(t-t_lag)/log(10) +(t>=t_lag) * (t>(t_lag+(N_max-N_0)*log(10)/r_max)) * (N_max-N_0))
}

gompertz_model<-function(t, r_max, N_max, N_0, t_lag){ ## Modified gompertz growth model (Zwietering 1990)
  return(N_0 + (N_max-N_0) * exp(-exp(r_max * exp(1) * (t_lag-t)/((N_max-N_0) *log(10))+1)))
}

N_0_start<-min(data$LogN)
N_max_start<-max(data$LogN)
t_lag_start<-data$t[which.max(diff(diff(data$LogN)))]
r_max_start<-max(diff(data$LogN))/mean(diff(data$t))

fit_baranyi<-nlsLM(data$LogN~baranyi_model(t=t, r_max, N_max, N_0, t_lag), data, list(t_lag=t_lag_start, r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))
fit_buchanan<-nlsLM(data$LogN~buchanan_model(t=t, r_max, N_max, N_0, t_lag), data, list(t_lag=t_lag_start, r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))
fit_gompertz<-nlsLM(data$LogN~gompertz_model(t=t, r_max, N_max, N_0, t_lag), data, list(t_lag=t_lag_start, r_max=r_max_start, N_0=N_0_start, N_max=N_max_start))

summary(fit_baranyi)
summary(fit_buchanan)
summary(fit_gompertz)

timepoints<-seq(0,24,.1)
baranyi_points<-baranyi_model(t=timepoints, r_max = coef(fit_baranyi)["r_max"], N_max = coef(fit_baranyi)["N_max"], N_0 = coef(fit_baranyi)["N_0"], t_lag = coef(fit_baranyi)["t_lag"])
buchanan_points<-buchanan_model(t=timepoints, r_max = coef(fit_buchanan)["r_max"], N_max = coef(fit_buchanan)["N_max"], N_0 = coef(fit_buchanan)["N_0"], t_lag = coef(fit_buchanan)["t_lag"])
gompertz_points<-gompertz_model(t=timepoints, r_max = coef(fit_gompertz)["r_max"], N_max = coef(fit_gompertz)["N_max"], N_0 = coef(fit_gompertz)["N_0"], t_lag = coef(fit_gompertz)["t_lag"])

df1<-data.frame(timepoints, baranyi_points)
df1$model<-"Baranyi"
names(df1)<-c("t","LogN","model")
df2<-data.frame(timepoints, buchanan_points)
df2$model<-"Buchanan"
names(df2)<-c("t","LogN","model")
df3<-data.frame(timepoints, gompertz_points)
df3$model<-"Gompertz"
names(df3)<-c("t","LogN","model")

model_frame<-rbind(df1, df2, df3)
ggplot(data, aes(x=t, y=LogN))+
  geom_point(size=3)+
  geom_line(data=model_frame, aes(x=t, y=LogN, col=model), size=1)
