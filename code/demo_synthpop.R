# The purpose of this script is to demonstrate the ability to generate synthetic
# data using synthpop package



# SETUP -------------------------------------------------------------------

library(tidyverse)
library(here)
library(arrow)
library(synthpop)

# IMPORT DATA -------------------------------------------------------------

data(iris)
df_iris_raw <- as_tibble(iris)
rm(iris)
write_parquet(df_iris_raw, here("data", "df_iris_raw.parquet"))


# PREPARE DATA ------------------------------------------------------------

df_iris <- df_iris_raw %>%
  rename_with(str_to_lower) %>%
  rename_with(str_replace_all, pattern = "\\.", replacement = "_")

# VISUALIZE ORIGINAL DATASET ----------------------------------------------

df_iris %>%
  ggplot(aes(x = sepal_length, y = petal_width, color = species)) +
  geom_point() +
  labs(
    title = "Original Raw Data Observations", 
    x = "Sepal Length", 
    y = "Petal Width",
    color = "Species"
  ) +
  ggsave(here("out", "plot_original.jpg"))


# GENERATE DATA -----------------------------------------------------------

synth_obj = syn(df_iris, k = 150)
df_iris_syn = synth_obj$syn


# VISUALIZE SYNTHETIC DATASET ----------------------------------------------

df_iris_syn %>%
  ggplot(aes(x = sepal_length, y = petal_width, color = species)) +
  geom_point() +
  labs(
    title = "Original Raw Data Observations", 
    x = "Sepal Length", 
    y = "Petal Width",
    color = "Species"
  ) +
  ggsave(here("out", "plot_synthetic.jpg"))
