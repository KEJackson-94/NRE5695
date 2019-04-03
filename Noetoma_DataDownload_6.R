sleep_for_a_minute <- function() { Sys.sleep(60) } #This sets a clock to measure the time for the script to execute
start_time <- Sys.time()
sleep_for_a_minute()

library('ggplot2')
library('plyr')
library('mapdata')
library('neotoma')

NewEngland.dataset <- c()
x <- 0

gpids <- get_table(table.name='GeoPoliticalUnits')
for (st in c('Connecticut','New Hampshire','Vermont','Massachusetts','Maine')){
  print(st)
  ID <- gpids[which(gpids$GeoPoliticalName == st),1]
  print(ID)} # Rhode Island isn't inlcuded b/c it doesn't have any sites meeting the criteria
             # Inlcuding the Rhode Island code will results in get_dataset() accessing ALL 
             # Neotoma data (I don't know why)

all.datasets <- get_dataset(datasettype = 'pollen', gpid = c(6442,7923,7368,8981,7326), 
                            altmin = 100, altmax = 430, taxonname = 'Poaceae') # gpid are copied from those printed in line 22
all.downloads <- get_download(all.datasets, verbose = FALSE)
compiled.cores <- compile_taxa(all.downloads, 'P25')

names(compiled.cores) <- c('s1','s2','s3','s4','s5','s6','s7','s8','s9','s10',
                           's11','s12','s13','s14','s15','s16','s17','s18','s19','s20',
                           's21','s22','s23','s24','s25','s26','s27','s28','s29','s30',
                           's31','s32','s33','s34','s35','s36','s37','s38','s39','s40',
                           's41','s42','s43','s44','s45','s46','s47','s48','s49','s50',
                           's51','s52','s53','s54','s55','s56','s57','s58','s59','s60',
                           's61','s62','s63','s64')

cc <- c('s1','s2','s3','s4','s5','s6','s7','s8','s9','s10',
        's11','s12','s13','s14','s15','s16','s17','s18','s19','s20',
        's21','s22','s23','s24','s25','s26','s27','s28','s29','s30',
        's31','s32','s33','s34','s35','s36','s37','s38','s39','s40',
        's41','s42','s43','s44','s45','s46','s47','s48','s49','s50',
        's51','s52','s53','s54','s55','s56','s57','s58','s59','s60',
        's61','s62','s63','s64')

library('analogue')

# Plot Poaceae #

p1.df <- (NA)

for (i in 1:length(cc)){
  i.poaceae <-  tran(x = compiled.cores[[i]]$counts, method = 'percent')[,'Poaceae']
  poaceae.df <- data.frame(poaceae = c(i.poaceae),
                           age = c(compiled.cores[[i]]$sample.meta$age),
                           site = c(rep(i, length(i.poaceae))))
  p1.df <- rbind(p1.df, poaceae.df)}

  
p1 <- qplot(p1.df$age,p1.df$poaceae, data=p1.df, geom=c("point"), 
      method="lm", formula=y~x, color=site, 
      xlab="Years Before Present", ylab="Percent Poaceae (Grass)") +ylim(0,20)+ xlim(-50,600) + geom_smooth()

# Plot Pinus #

p2.df <- (NA)

for (i in 1:length(cc)){
  i.poaceae <-  tran(x = compiled.cores[[i]]$counts, method = 'percent')[,'Quercus']
  poaceae.df <- data.frame(poaceae = c(i.poaceae),
                           age = c(compiled.cores[[i]]$sample.meta$age),
                           site = c(rep(i, length(i.poaceae))))
  p2.df <- rbind(p2.df, poaceae.df)}


p2 <- qplot(p2.df$age,p2.df$poaceae, data=p2.df, geom=c("point"), 
            method="lm", formula=y~x, color=site, 
            xlab="Years Before Present", ylab="Percent Pinus (Pine)") +ylim(0,50)+ xlim(-50,600) + geom_smooth()

# Plot Tsuga #

p3.df <- (NA)

for (i in 1:length(cc)){
  i.poaceae <-  tran(x = compiled.cores[[i]]$counts, method = 'percent')[,'Tsuga']
  poaceae.df <- data.frame(poaceae = c(i.poaceae),
                           age = c(compiled.cores[[i]]$sample.meta$age),
                           site = c(rep(i, length(i.poaceae))))
  p3.df <- rbind(p3.df, poaceae.df)}


p3 <- qplot(p3.df$age,p3.df$poaceae, data=p3.df, geom=c("point"), 
            method="lm", formula=y~x, color=site,
            xlab="Years Before Present", ylab="Percent Tsuga (Hemlock)") +ylim(0,50)+ xlim(-50,600) + geom_smooth()

# Plot Acer #

p4.df <- (NA)

for (i in 1:length(cc)){
  i.poaceae <-  tran(x = compiled.cores[[i]]$counts, method = 'percent')[,'Acer']
  poaceae.df <- data.frame(poaceae = c(i.poaceae),
                           age = c(compiled.cores[[i]]$sample.meta$age),
                           site = c(rep(i, length(i.poaceae))))
  p4.df <- rbind(p4.df, poaceae.df)}


p4 <- qplot(p4.df$age,p4.df$poaceae, data=p4.df, geom=c("point"), 
            method="lm", formula=y~x, color=site, 
            xlab="Years Before Present", ylab="Percent Acer (Maple)") +ylim(0,20)+ xlim(-50,600) + geom_smooth()

### This produces a merged figure of relevant taxa cleans up the figures ###

install.packages("cowplot")
library(ggplot2)
library(cowplot)
plot_grid(p1, p2, p3, p4, labels = c("A", "B", "C", "D"), nrow = 2, ncol = 2, align = "v")

end_time <- Sys.time()

end_time - start_time

for (i in 1:length(pubs)){
  print(pubs[[i]][[1]][[1]])} # This prints out all of the citations for data used in above analysis

  
