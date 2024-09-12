no_group_data <- function(){
  dplyr::tribble(
    ~koen, ~farve,
    "m", "grøn",
    "f", "blå",
    "f", "blå",
    "f", "blå",
    "f", "blå",
    "f", "rød",
    "f", "rød",
    "f", "rød",
    "f", "rød",
    "f", "rød"
  )
}

cleanup_data <- function(){
  dplyr::tribble(
    ~koen, ~farve,
    "a", "grøn",
    "a", "blå",
    "b", "grøn",
    "b", "blå",
    "c", "grøn",
    "c", "blå"
    )
}


pop_data <- function(n) {
  # Ensure reproducibility
  set.seed(123)

  # Define possible values for each variable
  ages <- sample(18:80, n, replace = TRUE)
  sexes <- sample(c("Male", "Female"), n, replace = TRUE)
  employment_statuses <- sample(c("Employed", "Unemployed", "Retired", "Student"), n, replace = TRUE)
  education_levels <- sample(c("High School", "Associate's Degree", "Bachelor's Degree", "Master's Degree", "PhD"), n, replace = TRUE)

  # Create the dataset
  data <- data.frame(
    Age = ages,
    Sex = sexes,
    Employment_Status = employment_statuses,
    Education_Level = education_levels
  )

  return(data)
}
