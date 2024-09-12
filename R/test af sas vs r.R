sas_disk <- read.csv("./sas_disk.csv")

sas_data <- sas_disk |>
  select(id, ends_with("_disk"))  |>
  rename(age_disk = age_char_disk) |>
  mutate(id = as.character(id))

sas_sum <- sas_data |>
  select(ends_with("_disk")) |>
  group_by_all() |>
  summarise(n = n()) |>
  arrange(across(everything()))

r_sum <- out2 |>
  select(ends_with("_disk")) |>
  group_by_all() |>
  summarise(n = n()) |>
  arrange(across(everything()))

all(sas_sum == r_sum)

colnames(sas_data) <- paste("sas", colnames(sas_data), sep = "_")

join <- out2 |>
  left_join(sas_data, join_by("id" == "sas_id"))
