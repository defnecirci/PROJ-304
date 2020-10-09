library("ggplot2")
library("ggtree")
library("stringr")
library("RColorBrewer")
library("tidyverse")

#/home/burak/2020-05-01/augur/result/results/tree.nwk
#read tree
tree <- read.tree("/Users/apple/Desktop/tree.nwk")
#form a circular graph
circ <- ggtree(tree, layout = "circular", ladderize = TRUE,branch.length="none")

#/home/berk/4_master_cluster/subtypes_ordered_time.tsv
p_df <- read.table(file = '/Users/apple/Desktop/subtypes_ordered_time.tsv', sep = '\t', header = TRUE)
#change the order of the columns
p_df<-p_df[, c("header","L_S", "X614_DG", "Barcode", "Six_Major","major_1","sub","major_2")]
#arrange column names
p_df<-p_df %>% 
  rename(
    "L/S" = L_S,
    "614 G/D" = X614_DG,"Phylo-major" = major_1,"Phylo-sub"=sub,"Six major"=Six_Major
  )
#remove majo2_2 column
p_df$major_2=NULL

#take Turkey samples
Turkey_Data <- filter(p_df, grepl('Turkey', header))
Turkey_Data$' '="Turkey"
#add another column that specifies whether they are from Turkey or not
p_df$' '<-Turkey_Data$' '[match(p_df$header,Turkey_Data$header)] 

#take cluster sets
df <- subset(p_df, select = -1 )

# change unknowns ones with NA
df[df == "Unknown"] <- NA
df[df == "U_type"] <- NA
df[df == "N_type"] <- NA
df[df == "-1"] <- NA

#change names to get different colors on the graph
df$`Phylo-major` = str_replace(df$`Phylo-major`,"1"," 1")
df$`Phylo-major` = str_replace(df$`Phylo-major`,"2"," 2")
df$`Phylo-major` = str_replace(df$`Phylo-major`,"3"," 3")
df$`Phylo-major` = str_replace(df$`Phylo-major`,"4"," 4")



#match samples with their clusters 
rownames(df) <- tree$tip.label

#increase the number of the color palette
getPalette = colorRampPalette(brewer.pal(8, "Set1"))

#specify colors
col <- c(( getPalette(20)),brewer.pal(10, "Set3"),brewer.pal(6, "Set2"),brewer.pal(6, "Paired"),brewer.pal(8, "Set2"))

#plot the graph
png("clustersfinal.png",width=15000, height=20000)
gheatmap(circ, df[, (1:7), drop=T], width=0.5,offset = 0.00000000000000000001, color=NULL,
         colnames_angle=90, colnames_offset_y = 0.25,hjust=0, font.size=60) +
  scale_fill_manual(values=col, name="values")

dev.off()

