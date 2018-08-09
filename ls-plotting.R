# Least squares plotting, data comes from outside

require(ggplot2)

LSPlot <- function(h, a, b) {
  p <- ggplot(data = h, mapping = aes(x = x, xmin = 0, 
                                      xmax = 1, 
                                      ymin = 0, 
                                      ymax = 1),
              legend = FALSE)
  
  p <- p + geom_point(mapping = aes(x = x, y = y), 
                      size = 2, 
                      color = "red")
  
  p <- p + geom_errorbar(mapping = aes(x = x, 
                                       ymin = ymi, 
                                       ymax = yma), 
                         size = 0.2, 
                         width = 0.01, 
                         color = "black")
  
  fxab <- function(x) a*x + b  # this is the straight line fit to data
  d <- fxab(h$x) - h$y         # this is the vector of distances
  sqrs <- sapply(d, function(x) x^2) # just for didactic purposes, sqrs <- d*d would work too
  
  p <- p + stat_function(fun = fxab, 
                         size = 0.1, 
                         color = "blue")
  
  ssqr <- sum(sqrs)      # sum of squares of distances
  sq_side <- sqrt(ssqr)  # side of the square equal to the sum of squares
  
  x <- 1.0; y <- 0.0; sq <- data.frame(x, y)  # where to plot the sum square
  
  p <- p + geom_rect(data = sq, 
                     mapping = aes(xmin = x - sq_side, xmax = x, 
                                   ymin = y, ymax = y + sq_side),
                     alpha = 0.2, 
                     size = 0.1, 
                     color = "black", 
                     fill = "grey")
  
  x <- 0.9; y <- 0.05; tx <- data.frame(x, y)
  
  p <- p + geom_text(data = tx, mapping = 
                         aes(x = x, y = y, label = "Sum of d^2"), 
                       size = 2, 
                       color = "black")
  
  
  fyab <- function(y) y/a - b/a

  p <- p + geom_rect(mapping = aes(xmin = ifelse(fyab(y) < x, x, 
                                                 x - abs(fxab(x) - y)), 
                                   xmax = ifelse(fyab(y) < x, 
                                                 x + abs(fxab(x) - y), x), 
                                   ymin = ifelse(fxab(x) < y, 
                                                 y - abs(fxab(x) - y), y), 
                                   ymax = ifelse(fxab(x) < y, 
                                                 y, y + abs(fxab(x) - y))),
                     alpha = 0.2, 
                     size = 0.1, 
                     color = "black", 
                     fill = "grey")
  
  p <- p + coord_fixed(ratio = 1)
  return p
}
