qmds <- list.files(pattern = "^[3-4].[1-5].*qmd$",
                   path = "Bayesian_inference_1/",
                   full.names = TRUE)

for (qq in qmds) {
  message("Processing ", qq)
  syscall <- paste0("quarto render ", qq, " --to revealjs")
  system(syscall)
}
