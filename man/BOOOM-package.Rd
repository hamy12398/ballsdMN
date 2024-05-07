\name{BOOOM-package}
\alias{BOOOM-package}
\alias{BOOOM}
\docType{package}
\title{
 Black-Box Optimization of Row Orthogonal Matrices  
}
\description{
The optimization utilizes Fermi’s principle to minimize objective function values of given matrices. The multiple orthogonal matrices will be rotated on all pair axes (out of existing axes) by optimized angle in counter-clock-wise direction.
}
\details{
  The function 'BOOOM_opt' to find optimal multiple orthognal matrices from objective function
}
\author{
Khoa Huynh, My Nguyen, Priyam Das.
}

}
\keyword{ package }

\examples{
     
  # Create the first orthogonal matrix
  matrix1 <- randortho(5)
  
  # Create the second orthogonal matrix
  matrix2 <- randortho(5)
  
  # Create the third orthogonal matrix
  matrix3 <- randortho(5)
  
  Mat=list(matrix1,matrix2,matrix3)
  
  
  
  calculate_l2_norm <- function(matrices1) {
    # Initialize sum of squared differences
    sum_squares <- 0
    
    # Iterate over each pair of matrices
    for (i in 1:3) {
      # Calculate the difference between corresponding matrices
      diff_matrix <- matrices1[[i]] - 2
      
      # Calculate the sum of squared differences for this pair
      sum_squares <- sum_squares + sum(diff_matrix^2)
    }
    
    # Calculate the square root of the sum of squared differences
    l2_norm <- sqrt(sum_squares)
    
    return(l2_norm)
  }
  
  result <- BOOOM_opt(Mat, calculate_l2_norm)

  
}
