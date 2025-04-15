# load packages required
library(Seurat)
library(tidyverse)

# make sure to install schard before starting. Schard converts the h5ad file to a seurat file. 
data <- schard::h5ad2seurat(paste(getwd(),'/data/pbmc_ct0.60_noribo.h5ad', sep=""))

# subset the cells you want to analyze (from cell_type_0.60 metadata label)
# here the example uses "CD16+ monocytes"
ss <- subset(data, subset = cell_type_0.60 %in% c("CD16+ monocytes"))

# preprocess is a function that preprocesses the raw count matrix from Seurat.
# data will be log-normalized and variable features are determined. 
# Data is centered and scaled between -1 and 1
# PCA is performed on the normalized, scaled data. 
preprocess <- function(seuratObject) {
  seuratObject <- NormalizeData(seuratObject)
  seuratObject <- FindVariableFeatures(seuratObject)
  seuratObject <- ScaleData(seuratObject)
  seuratObject <- RunPCA(seuratObject)
  return(seuratObject)
}

ss <- preprocess(ss)

# extract the loadings from PCA , convert to a dataframe to plot
loads <- Loadings(ss, reduction="pca")
loads_df <- as.data.frame(loads)
loads_df$gene <- rownames(loads_df)

# find the top 10 genes for the first 3 PCs. 
top_genes_long <- loads_df %>%
  pivot_longer(cols = starts_with("PC_"), names_to = "PC", values_to = "loading") %>%
  filter(PC %in% c("PC_1", "PC_2", "PC_3")) %>%
  group_by(PC) %>%
  slice_max(order_by = abs(loading), n = 10) %>%
  ungroup()

# Plot the loadings. 
ggplot(top_genes_long, aes(x = reorder(gene, loading), y = loading, fill = PC)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  facet_wrap(~ PC, scales = "free_y") +
  labs(title = "CD16+ Monocytes: Top 10 PCA Loadings for PCs 1–3", x = "Gene", y = "Loading") +
  scale_fill_manual(values = c("PC_1" = "#1f77b4", "PC_2" = "#ff7f0e", "PC_3" = "#9467bd")) + 
  scale_y_continuous(breaks = seq(-0.1, 0.1, by=0.1)) +
  theme_minimal()
