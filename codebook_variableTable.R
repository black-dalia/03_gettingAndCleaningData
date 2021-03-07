Variables<-names(Q5_mean_by_gr)
Variables<-as.data.frame(Variables)
#########
Variables<-mutate(Variables,measurement_type=Variables)
Variables$measurement_type[grep("Acc",Variables$measurement_type,value = F)]<-"Accelerometer"
Variables$measurement_type[grep("Gyro",Variables$measurement_type,value = F)]<-"Gyroscope"
Variables$measurement_type[80:81]<-"N/A"

#########
Variables<-mutate(Variables,Direction=Variables)
Variables$Direction[grep("_X",Variables$Direction,value = F)]<-"X"
Variables$Direction[grep("_Y",Variables$Direction,value = F)]<-"Y"
Variables$Direction[grep("_Z",Variables$Direction,value = F)]<-"Z"
Variables$Direction[grep("[^_Z|_Y|_X]",Variables$Direction,value = F)]<-"N/A"

#########
Variables<-mutate(Variables,domain=Variables)
Variables$domain<-substring(Variables$domain,8,8)
Variables$domain[which(Variables$domain=="t")]<-"Time"
Variables$domain[which(Variables$domain=="f")]<-"Frequency"
Variables$domain[80:81]<-"N/A"

save(list = ls(.GlobalEnv), file = "data.Rdata")
codebook(Q5_mean_by_gr,reliabilities = NULL,survey_repetition = "auto")
