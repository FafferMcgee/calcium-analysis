install.packages( c('devtools',
                   'drc',
                   'MESS',
                   'Sandwich',
                   'ggplot2',
                   'dplyr', 
                   'tidyr',
                   'lmtest',
                   'multcomp',
                   'plyr',
                   'bio3d',
                   'shiny',
                   'rsconnect',
                   'muscle',
                   'shiny',
                   'knitr',
                   'data.table',
                   'Cairo'
                   ))

library('devtools')

install_github('FafferMcGee/Calcium-Analysis')
install_git('https://git.bioconductor.org/packages/muscle')


# Installation of biomaRt as of 20181105
# Taken from: https://bioconductor.org/packages/release/bioc/html/biomaRt.html
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("biomaRt", version = "3.8")
