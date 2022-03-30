#! /usr/local/bin/RScript
# Basic script to plot ld figures from plink output
library(tidyverse)

files = list.files(path="outputs/500", pattern = "*.ldf.ld", full.names = TRUE)

PlotLD <- function (file) {
  lddf<-read.delim(file,sep="",stringsAsFactors=FALSE) %>% as_tibble() %>% arrange(R2) %>% 
    filter(R2 >0.4)
  chrom<-lddf %>% select(CHR_A) %>% unique()

  ggplot(lddf) +
    geom_point(aes(x=BP_A, y=BP_B, color=R2), alpha=0.5) +
    scale_color_gradient(low="khaki1", high="red") + 
    ggtitle(chrom$CHR_A) +
    theme(plot.title=element_text(hjust=0.5)) +
    theme_bw()
  
ggsave(paste0("outputs/500/figs/",chrom$CHR_A,".jpeg"))
}
  
lapply(files, PlotLD)



