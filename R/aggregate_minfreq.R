aggregate_minfreq <- function(data, vars, graense = 3){

  data <- data |>
    dplyr::mutate_all(as.character)

  sum_vars <- NULL
  group_vars <- NULL
  for(var in vars){

    sum_vars <- c(sum_vars, var)

    sum_data <- data |>
      dplyr::group_by(across(all_of(sum_vars))) |>
      dplyr::summarise(antal = dplyr::n(),
                       .groups = "drop")

    sym_var <- dplyr::sym(var)

    var_disk <- sum_data |>
      dplyr::group_by(dplyr::across(dplyr::all_of(group_vars)))|>
      dplyr::arrange(antal, .by_group = TRUE) |>
      dplyr::mutate(sum = cumsum(antal)) |>
      dplyr::mutate(
        lag = dplyr::lag(sum, default = dplyr::first(antal)),
        tekst = dplyr::if_else(
          lag < graense | antal < graense,
          "diskretioneret",
          !!sym_var
        )
      )

    disk_name <- paste0(var, "_disk")
    sym_disk_name <- dplyr::sym(disk_name)

    names(var_disk)[names(var_disk) == "tekst"] <- disk_name

    out_disk <- var_disk |>
      dplyr::select(dplyr::all_of(sum_vars), !!sym_disk_name)

    data <- data |>
      dplyr::left_join(
        out_disk,
        by = sum_vars
      )

  sum_vars <- sum_vars[sum_vars != var]
  sum_vars <- c(sum_vars, disk_name)
  group_vars <- c(group_vars, disk_name)
  }


  return(data)


}

