qmds <- list.files(pattern = "^[3].[1-5].*qmd$",
                   path = "Randomization_simulation_methods/",
                   full.names = TRUE)

for (qq in qmds) {
  message("Processing ", qq)
  syscall <- paste0("quarto render ", qq, " --to revealjs")
  system(syscall)
}
