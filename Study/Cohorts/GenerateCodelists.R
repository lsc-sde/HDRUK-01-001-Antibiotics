cli::cli_text("- GETTING CODELISTS ({Sys.time()})")

ingredients <- read_csv(here("Cohorts", "ingredients.csv"),
  col_types = list(
    concept_id = col_double(),
    ingredient_name = col_character(),
    cohort_name = col_character(),
    atc = col_character()
  )
)

ing_av <- cdm$concept %>%
  filter(
    domain_id == "Drug",
    concept_class_id == "Ingredient",
    standard_concept == "S",
    concept_id %in% ingredients$concept_id
  ) %>%
  pull("concept_id")

# Create a codelist for the antibiotics at ingredient level.

ingredient_desc <- getDrugIngredientCodes(
    cdm = cdm,
    name = ing_av,
    type = "codelist")

names(ingredient_desc) <- toSnakeCase(names(ingredient_desc))

#### Access Ingredients

access_ingredients <- read_csv(here("Cohorts", "access_ingredients.csv"),
                        col_types = list(
                          concept_id = col_double(),
                          ingredient_name = col_character(),
                          cohort_name = col_character(),
                          atc = col_character()
                        )
)

acc_ing_av <- cdm$concept %>%
  filter(
    domain_id == "Drug",
    concept_class_id == "Ingredient",
    standard_concept == "S",
    concept_id %in% access_ingredients$concept_id
  ) %>%
  pull("concept_id")

# Create a codelist for the antibiotics at ingredient level.

acc_ingredient_desc <- getDrugIngredientCodes(
  cdm = cdm,
  name = acc_ing_av,
  type = "codelist")

names(acc_ingredient_desc) <- toSnakeCase(names(acc_ingredient_desc))
