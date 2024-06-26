% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/optimized_HUM.R
\name{BOOOM_opt}
\alias{BOOOM_opt}
\title{Black-Box Optimization of Row Orthogonal Matrices  }

\value{
Optimal orthogonal Matrices 
}

\description{
The function runs the optimization utilizing Fermi’s principle to minimize objective function values of given matrices. The multiple orthogonal matrices will be rotated on all pair axes (out of existing axes) by optimized angle in counter-clock-wise direction.
}


\usage{
BOOOM_opt(
  Mat,
  func,
  desired_min = -10^(60), 
  s_init = 1, 
  no_runs = 1000, 
  max_iter = 10000, 
  rho = 2, 
  phi = 10^(-20), 
  tol_fun = 10^(-6), 
  tol_fun_2 = 10^(-15), 
  desired_improv_rate = 10^(-20), 
  improv_rate_period = 20, 
  total_iter = 10000000, 
  print_output = 0
)
}
\arguments{
\item{Mat}{List of multiple orthognal matrix input}

\item{func}{The interested function to ooptimize}

\item{s_init}{Initial Global Step Size. Default Value is 1.}

\item{no_runs}{Number of Runs. Default Value is 1,000.}

\item{max_iter}{Max Number Of Iterations In each Run. Default Value is 10,000.}

\item{rho}{Factor by which step-size value is decremented to enable jumps of
smaller step-sizes. Default Value is 2.}

\item{phi}{Value of the smallest step-size. Default Value is \eqn{10^{-20}}.}

\item{tol_fun}{Termination Tolerance on the function value. Default Value is \eqn{10^{-6}}.}

\item{tol_fun_2}{Termination Tolerance on the difference of solutions in two consecutive runs. Default Value is \eqn{10^{-10}}.}

\item{improv_rate_period}{The number of iteration of a Run to control the rate of decrement of objective function value}

\item{desired_improv_rate}{The rate of decrement of objective function value over last improv_rate_period many iterations. If the decrement rate of the objective function per iteration is less than desired_improv_rate, then function break and terminate the run. Default Value is \eqn{10^{-10}}.}

\item{total_iter}{Total Number Of Iterations. Default Value is 10,000,000.}

\item{print}{Binary Command to print optimized value of objective function after each iteration. FALSE is set fault}
}



\examples{
     
  # Create the orthogonal matrices list
  matrix1 <- randortho(5)
  matrix2 <- randortho(5)
  matrix3 <- randortho(5)
  
  Mat_A=list(matrix1,matrix2,matrix3)
    
  ## function
  calculate_l2_norm_ms <- function(matrices1) {
  # Initialize sum of squared differences
  sum_squares <- 0
  set.seed(1)
  matrix6 <- randortho(5)
  matrix7 <- randortho(5)
  matrix8 <- randortho(5)
  
  Mat_B=list(matrix6,matrix7,matrix8)
  for (i in 1:3) {
    # Calculate the difference between corresponding matrices
    diff_matrix <- matrices1[[i]] - Mat_B[[i]]
    
    # Calculate the sum of squared differences for this pair
    sum_squares <- sum_squares + sum(diff_matrix^2)
  }
  
  # Calculate the square root of the sum of squared differences
  l2_norm <- sqrt(sum_squares)
  
  return(l2_norm)
}

  
  BOOOM_opt((Mat_A), calculate_l2_norm_ms)

  
}
