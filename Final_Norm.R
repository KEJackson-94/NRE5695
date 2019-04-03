
install.packages('readr')
install.packages('dplyr')
install.packages('ggplot2')
install.packages('scales')
install.packages('quantmod')

library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(quantmod)
setwd("C:/NRE5695/CSV_XLS")
SedRt_Data <- read_csv('NRE5695_SedRt_comp.csv')

# Plot Sedimentation Rate

p1 <- qplot(SedRt_Data$SedRate,SedRt_Data$Date, data=SedRt_Data, geom=c("point") , color=Site, 
            xlab="Instantaneous Sedimentation Rate (cm/yr)", ylab="Age") +ylim(1500,2000)+ xlim(0,1.5) + geom_path()
#print (p1)

# Plot OM

OM_Data <- read_csv('NRE5695_OM_comp_norm.csv')

p2 <- qplot(OM_Data$OM_norm, OM_Data$Date, data=OM_Data, geom=c("point") , color=Site, 
            xlab="Organic Matter (scaled)", ylab="") +ylim(1500,2000)+ xlim(0,1) + geom_path()
#print (p2)

# Plot DI_TP

DI_TP_Data <- read_csv('NRE5695_TP_comp_norm.csv')

p3 <- qplot(DI_TP_Data$DI_TP_norm, DI_TP_Data$Date, data=DI_TP_Data, geom=c("point") , color=Site, 
            xlab="Diatom-Inferred Total Phosphorous (scaled)", ylab="") +ylim(1500,2000)+ xlim(0,1) + geom_path()
#print (p3)

#install.packages("cowplot")
library(ggplot2)
library(cowplot)
plot_grid(p2,p3,p1, labels = c("A", "B", "C"), nrow = 1, ncol = 3, align = "v")

prow <- plot_grid( p1 + theme(legend.position="none"),
                   p2 + theme(legend.position="none"),
                   p3 + theme(legend.position="none"),
                   align = 'vh',
                   labels = c("A", "B", "C"),
                   hjust = -1,
                   nrow = 1)
#prow

legend <- get_legend(p1)
p <- plot_grid( prow, legend, rel_widths = c(3, .3))
p
