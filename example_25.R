# From https://github.com/richelbilderbeek/pirouette_article/issues/45 :
#
# Measure the influence of the alignment RNG, by using a same twin tree,
# but 100 different alignment RNG seed.

suppressMessages(library(pirouette))
suppressMessages(library(ggplot2))

################################################################################
# Constants
################################################################################
is_testing <- is_on_travis()
example_no <- 25

for (rng_seed in seq(314, 318)) {

  print(rng_seed)

  folder_name <- paste0("example_", example_no, "_", rng_seed)

  set.seed(314) # Always the same
  phylogeny <- create_yule_tree(n_taxa = 6, crown_age = 10)

  pir_params <- create_std_pir_params(folder_name = folder_name)
  pir_params$twinning_params$rng_seed_twin_tree <- 314 # Always the same

  if (is_testing) {
    pir_params <- shorten_pir_params(pir_params)
  }

  errors <- pir_run(
    phylogeny,
    pir_params = pir_params
  )

  utils::write.csv(
    x = errors,
    file = file.path(folder_name, "errors.csv"),
    row.names = FALSE
  )

  pir_plot(errors) +
    ggsave(file.path(folder_name, "errors.png"), width = 7, height = 7)

  pir_to_pics(
    phylogeny = phylogeny,
    pir_params = pir_params,
    folder = folder_name
  )

  pir_to_tables(
    pir_params = pir_params,
    folder = folder_name
  )
}
