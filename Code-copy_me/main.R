# DO NOT CHANGE THIS SECTION
## Receive the simulation parameters from job file
## Evaluate the simulation parameters in the R global environment
## For the Toy Example
## It is equivalent to run
## n <- 100

args=(commandArgs(TRUE))

if(length(args)==0){
  print("No arguments supplied.")
}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}



# Library & Helper Functions ----------------------------------------------
## TODO: add libraries and helper functions
library(tidyverse)

## TODO: Replace path here
# source("/Change/To/Absolute/Path/Of/Your/Code")



# Data Generating Process -------------------------------------------------
## Use Array ID as random seed ID
it <- Sys.getenv('SLURM_ARRAY_TASK_ID') %>% as.numeric
set.seed(it)

## TODO: Replace with your simulation code
sample_x_vec <- function(n) rpois(n, lambda = 3)

# Matrix contain 100000 columns where each column is a random sample of n
x_mat <- map_dfc(1:100000,          # Equivalent to for(i in 1:100000)
                 .f = function(x) sample_x_vec(n))

x_bar_vec <- colMeans(x_mat)


# Fit Models------------------------------------------------------------------
## TODO: Replace with your model code
x_bar_mean <- mean(x_bar_vec)
x_bar_median <- median(x_bar_vec)
x_bar_var <- var(x_bar_vec)

# Save Simulation Results -------------------------------------------------
## TODO: Replace with your result saving code
ret <- list(
  mean = x_bar_mean,
  median = x_bar_median,
  var = x_bar_var
)

job_name <- Sys.getenv('SLURM_JOB_NAME')
# Recommendation: to save the results in individual rds files
saveRDS(ret,
        # TODO: Replace path here
        paste0("/Change/To/Absolute/Path/Of/Your/Storage/", job_name,"/it_",it,".rds"))


