qmds <- list.files(pattern = "^[1-5].[1-5].*qmd$",
                   path = "Data_visualization/",
                   full.names = TRUE)

for (qq in qmds) {
  message("Processing ", qq)
  syscall <- paste0("quarto render ", qq, " --to revealjs")
  system(syscall)
}
