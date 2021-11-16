library(dplyr)

sim_prmt <- expand.grid(
  p = c(4, 10, 50, 100, 200),
  n_train = c(500),
  n_test = c(10000),
  dis = c("gaussian", "binomial")#, "poisson")
) %>%
  data.frame()

# A wrapper function to set up each job
start.sim <- function(
  p,
  n_train, n_test, dis
) {

  p.name <- paste0("p_", p)
  dis.name <- paste0("dis_", dis)

  job.name <- paste("bgam_main_", dis.name, p.name,
                    sep="-")

  # NOTE:
  ## Job name has to be unique for each of your simulation setting
  ## DO NOT USE GENERIC JOB NAME FOR CONVENIENCE
  job.flag <- paste0("--job-name=",job.name)

  err.flag <- paste0("--error=",job.name,".err")

  out.flag <- paste0("--output=",job.name,".out")

  # Pass simulation parameters to jobs
  arg.flag <- paste0("--export=ntrain=", n_train, ",",
                     "ntest=", n_test, ",",
                     "p=", p,",",
                     "dist=", dis )

  # Create Jobs
  system(
    paste("sbatch", job.flag, err.flag, out.flag, arg.flag,".job")
  )
}


for(i in 1:NROW(sim_prmt)){
  do.call(start.sim, sim_prmt[i,])
}
