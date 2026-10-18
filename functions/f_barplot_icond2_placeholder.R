f_barplot_icond2_placeholder <- function(){
  ## function to create an empty plot
  # -> used if input for f_barplot_icond2() is not in the right format
  #    or empty
  plot(c(0, 1), c(0, 1), ann = F, bty = 'n', type = 'n', xaxt = 'n', yaxt = 'n')
}