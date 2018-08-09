# Least squares plotting, data comes from outside

library(ggplot2)

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

