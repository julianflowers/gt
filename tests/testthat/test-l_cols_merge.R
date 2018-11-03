context("Latex -- Ensuring that the `cols_merge*()` functions work as expected")

# Create a shortened version of `mtcars`
mtcars_short <- mtcars[1:5, ]

# Create a table with rownames and four columns of values
tbl <-
  dplyr::tribble(
    ~col_1, ~col_2, ~col_3, ~col_4,
    767.6,  928.1,  382.0,  674.5,
    403.3,  461.5,   15.1,  242.8,
    686.4,   54.1,  282.7,   56.3,
    662.6,  148.8,  984.6,  928.1,
    198.5,   65.1,  127.4,  219.3,
    132.1,  118.1,   91.2,  874.3,
    349.7,  307.1,  566.7,  542.9,
    63.7,  504.3,  152.0,  724.5,
    105.4,  729.8,  962.4,  336.4,
    924.2,  424.6,  740.8,  104.2)

test_that("the function `cols_merge()` works correctly", {

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with a `pattern`
  tbl_latex <-
    gt(mtcars_short) %>%
    cols_merge(
      col_1 = "drat",
      col_2 = "wt",
      pattern = "{1} ({2})")

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.620\\) & 16.46 & 0 & 1 & 4 & 4",
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.875\\) & 17.02 & 0 & 1 & 4 & 4",
      ".*22.8 & 4 & 108 &  93 & 3.85 \\(2.320\\) & 18.61 & 1 & 1 & 4 & 1",
      ".*21.4 & 6 & 258 & 110 & 3.08 \\(3.215\\) & 19.44 & 1 & 0 & 3 & 1",
      ".*18.7 & 8 & 360 & 175 & 3.15 \\(3.440\\) & 17.02 & 0 & 0 & 3 & 2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with a `pattern` and use the `vars()` helper
  tbl_latex <-
    gt(mtcars_short) %>%
    cols_merge(
      col_1 = vars(drat),
      col_2 = vars(wt),
      pattern = "{1} ({2})")

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.620\\) & 16.46 & 0 & 1 & 4 & 4",
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.875\\) & 17.02 & 0 & 1 & 4 & 4",
      ".*22.8 & 4 & 108 &  93 & 3.85 \\(2.320\\) & 18.61 & 1 & 1 & 4 & 1",
      ".*21.4 & 6 & 258 & 110 & 3.08 \\(3.215\\) & 19.44 & 1 & 0 & 3 & 1",
      ".*18.7 & 8 & 360 & 175 & 3.15 \\(3.440\\) & 17.02 & 0 & 0 & 3 & 2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns, twice,
  # with two different `pattern`s; use the `vars()` helper
  tbl_latex <-
    gt(mtcars_short) %>%
    cols_merge(
      col_1 = vars(drat),
      col_2 = vars(wt),
      pattern = "{1} ({2})") %>%
    cols_merge(
      col_1 = vars(gear),
      col_2 = vars(carb),
      pattern = "{1}-{2}")

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.620\\) & 16.46 & 0 & 1 & 4-4",
      ".*21.0 & 6 & 160 & 110 & 3.90 \\(2.875\\) & 17.02 & 0 & 1 & 4-4",
      ".*22.8 & 4 & 108 &  93 & 3.85 \\(2.320\\) & 18.61 & 1 & 1 & 4-1",
      ".*21.4 & 6 & 258 & 110 & 3.08 \\(3.215\\) & 19.44 & 1 & 0 & 3-1",
      ".*18.7 & 8 & 360 & 175 & 3.15 \\(3.440\\) & 17.02 & 0 & 0 & 3-2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()
})

test_that("the `cols_merge_uncert()` function works correctly", {

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with `cols_merge_uncert()`
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = "col_1",
      col_uncert = "col_2")

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 ± 928.1 & 382.0 & 674.5",
      ".*403.3 ± 461.5 &  15.1 & 242.8",
      ".*686.4 ±  54.1 & 282.7 &  56.3",
      ".*662.6 ± 148.8 & 984.6 & 928.1",
      ".*198.5 ±  65.1 & 127.4 & 219.3",
      ".*132.1 ± 118.1 &  91.2 & 874.3",
      ".*349.7 ± 307.1 & 566.7 & 542.9",
      ".*63.7 ± 504.3 & 152.0 & 724.5",
      ".*105.4 ± 729.8 & 962.4 & 336.4",
      ".*924.2 ± 424.6 & 740.8 & 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with `cols_merge_uncert()` and use the `vars()` helper
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = vars(col_1),
      col_uncert = vars(col_2))

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 ± 928.1 & 382.0 & 674.5",
      ".*403.3 ± 461.5 &  15.1 & 242.8",
      ".*686.4 ±  54.1 & 282.7 &  56.3",
      ".*662.6 ± 148.8 & 984.6 & 928.1",
      ".*198.5 ±  65.1 & 127.4 & 219.3",
      ".*132.1 ± 118.1 &  91.2 & 874.3",
      ".*349.7 ± 307.1 & 566.7 & 542.9",
      ".*63.7 ± 504.3 & 152.0 & 724.5",
      ".*105.4 ± 729.8 & 962.4 & 336.4",
      ".*924.2 ± 424.6 & 740.8 & 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns, twice,
  # with `cols_merge_uncert()` and use the `vars()` helper
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_uncert(
      col_val = vars(col_1),
      col_uncert = vars(col_2)) %>%
    cols_merge_uncert(
      col_val = vars(col_3),
      col_uncert = vars(col_4))

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 ± 928.1 & 382.0 ± 674.5",
      ".*403.3 ± 461.5 &  15.1 ± 242.8",
      ".*686.4 ±  54.1 & 282.7 ±  56.3",
      ".*662.6 ± 148.8 & 984.6 ± 928.1",
      ".*198.5 ±  65.1 & 127.4 ± 219.3",
      ".*132.1 ± 118.1 &  91.2 ± 874.3",
      ".*349.7 ± 307.1 & 566.7 ± 542.9",
      ".*63.7 ± 504.3 & 152.0 ± 724.5",
      ".*105.4 ± 729.8 & 962.4 ± 336.4",
      ".*924.2 ± 424.6 & 740.8 ± 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()
})

test_that("the `cols_merge_range()` function works correctly", {

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with `cols_merge_range()`
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = "col_1",
      col_end = "col_2")

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 — 928.1 & 382.0 & 674.5",
      ".*403.3 — 461.5 &  15.1 & 242.8",
      ".*686.4 —  54.1 & 282.7 &  56.3",
      ".*662.6 — 148.8 & 984.6 & 928.1",
      ".*198.5 —  65.1 & 127.4 & 219.3",
      ".*132.1 — 118.1 &  91.2 & 874.3",
      ".*349.7 — 307.1 & 566.7 & 542.9",
      ".*63.7 — 504.3 & 152.0 & 724.5",
      ".*105.4 — 729.8 & 962.4 & 336.4",
      ".*924.2 — 424.6 & 740.8 & 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns
  # with `cols_merge_range()` and use the `vars()` helper
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = vars(col_1),
      col_end = vars(col_2))

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 — 928.1 & 382.0 & 674.5",
      ".*403.3 — 461.5 &  15.1 & 242.8",
      ".*686.4 —  54.1 & 282.7 &  56.3",
      ".*662.6 — 148.8 & 984.6 & 928.1",
      ".*198.5 —  65.1 & 127.4 & 219.3",
      ".*132.1 — 118.1 &  91.2 & 874.3",
      ".*349.7 — 307.1 & 566.7 & 542.9",
      ".*63.7 — 504.3 & 152.0 & 724.5",
      ".*105.4 — 729.8 & 962.4 & 336.4",
      ".*924.2 — 424.6 & 740.8 & 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()

  # Create a `tbl_latex` object with `gt()`; merge two columns, twice,
  # with `cols_merge_range()` and use the `vars()` helper
  tbl_latex <-
    gt(tbl) %>%
    cols_merge_range(
      col_begin = vars(col_1),
      col_end = vars(col_2)) %>%
    cols_merge_range(
      col_begin = vars(col_3),
      col_end = vars(col_4))

  # Expect a characteristic pattern
  grepl(
    paste0(
      ".*767.6 — 928.1 & 382.0 — 674.5",
      ".*403.3 — 461.5 &  15.1 — 242.8",
      ".*686.4 —  54.1 & 282.7 —  56.3",
      ".*662.6 — 148.8 & 984.6 — 928.1",
      ".*198.5 —  65.1 & 127.4 — 219.3",
      ".*132.1 — 118.1 &  91.2 — 874.3",
      ".*349.7 — 307.1 & 566.7 — 542.9",
      ".* 63.7 — 504.3 & 152.0 — 724.5",
      ".*105.4 — 729.8 & 962.4 — 336.4",
      ".*924.2 — 424.6 & 740.8 — 104.2.*"),
    tbl_latex %>%
      as_latex() %>% as.character()) %>%
    expect_true()
})