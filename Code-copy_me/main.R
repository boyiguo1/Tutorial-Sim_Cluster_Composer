# DO NOT CHANGE THIS SECTION
## Receive the simulation parameters from job file
## Evaluate the simulation parameters in the R global environment
## For the Toy Example
## It is equivalent to run
## n_train <- 500
## n_test <- 1000
## p <- 4

args=(commandArgs(TRUE))

if(length(args)==0){
  print("No arguments supplied.")
}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
}


# Required Library

# Load helper functions
## TODO: Replace path here
# source("/Change/To/Absolute/Path/Of/Your/Code")

# Use Array ID as random seed ID
it <- Sys.getenv('SLURM_ARRAY_TASK_ID') %>% as.numeric
set.seed(it)

## TODO: Replace with your simulation code
# Data Generating Process -------------------------------------------------


# Fit Models------------------------------------------------------------------


# Save Simulation Results -------------------------------------------------

job_name <- Sys.getenv('SLURM_JOB_NAME')
# Recommendation: to save the results in individual rds files
saveRDS(ret,
        # TODO: Replace path here
        paste0("/Change/To/Absolute/Path/Of/Your/Storage/", job_name,"/it_",it,".rds"))


