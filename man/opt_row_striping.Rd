% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/opts.R
\name{opt_row_striping}
\alias{opt_row_striping}
\title{Option to add or remove row striping}
\usage{
opt_row_striping(data, row_striping = TRUE)
}
\arguments{
\item{data}{A table object that is created using the \code{\link[=gt]{gt()}} function.}

\item{row_striping}{A logical value to indicate whether row striping should
be added or removed.}
}
\value{
An object of class \code{gt_tbl}.
}
\description{
By default, a \strong{gt} table does not have row striping enabled. However, this
function allows us to easily enable or disable striped rows in the table
body. This function serves as a convenient shortcut for
\verb{<gt_tbl> \%>\% tab_options(row.striping.include_table_body = TRUE|FALSE)}.
}
\section{Figures}{

\if{html}{\figure{man_opt_row_striping_1.png}{options: width=100\%}}
}

\section{Function ID}{

9-2
}

\examples{
# Use `exibble` to create a gt table with
# a number of table parts added; next, we
# add row striping to every second row with
# the `opt_row_striping()` function
tab_1 <-
  exibble \%>\%
  gt(rowname_col = "row", groupname_col = "group") \%>\%
  summary_rows(
    groups = "grp_a",
    columns = vars(num, currency),
    fns = list(
      min = ~min(., na.rm = TRUE),
      max = ~max(., na.rm = TRUE)
    )) \%>\%
  grand_summary_rows(
    columns = vars(currency),
    fns = list(
      total = ~sum(., na.rm = TRUE)
    )) \%>\%
  tab_source_note(source_note = "This is a source note.") \%>\%
  tab_footnote(
    footnote = "This is a footnote.",
    locations = cells_body(columns = 1, rows = 1)
  ) \%>\%
  tab_header(
    title = "The title of the table",
    subtitle = "The table's subtitle"
  ) \%>\%
  opt_row_striping()

}
\seealso{
Other Table Option Functions: 
\code{\link{opt_align_table_header}()},
\code{\link{opt_all_caps}()},
\code{\link{opt_footnote_marks}()},
\code{\link{opt_table_lines}()},
\code{\link{opt_table_outline}()}
}
\concept{Table Option Functions}
