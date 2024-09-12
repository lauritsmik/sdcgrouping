library(devtools)
library(usethis)
library(tidyverse)

use_r("aggregate_minfreq")
use_r("generate_data")
?usethis

load_all()

# cleanup test
data = cleanup_data()
vars = rev(names(data))
aggregate_minfreq(data, names(data))

# no group test
data = no_group_data()
vars = names(data)
aggregate_minfreq(data, names(data))

# population test
data = pop_data(3000)
vars = names(data)
out1 <- aggregate_minfreq(data, rev(vars))
out2 <- aggregate_minfreq(data, vars)

graense = 3

sum1 <- out1 |>
  select(ends_with("_disk")) |>
  group_by_all() |>
  summarise(n = n())

sum2 <- out2 |>
  select(ends_with("_disk")) |>
  group_by_all() |>
  summarise(n = n())

write.csv2(data, "./udisk.csv", row.names = FALSE)
?write.csv2
