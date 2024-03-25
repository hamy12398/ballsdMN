\name{ballsd}
\alias{ballsd}
\title{ballsd}
\description{
  Optimization by Bayesian adaptive locally linear stochastic descent.
}
\usage{
ballsd(initialParams, objFunc, stepSizeInc, stepSizeDec, probInc, probDec, maxIterations)
}
\arguments{
  \item{initialParams}{Initial parameter values as a numeric vector.}
  \item{objFunc}{Objective function to be minimized or maximized. Should take a single argument, the parameter vector, and return a single numeric value.}
  \item{stepSizeInc}{Factor by which the step size is increased when a new parameter set improves the objective function.}
  \item{stepSizeDec}{Factor by which the step size is decreased when a new parameter set does not improve the objective function.}
  \item{probInc}{Factor by which the probability is increased for selecting a direction that improves the objective function.}
  \item{probDec}{Factor by which the probability is decreased for selecting a direction that does not improve the objective function.}
  \item{maxIterations}{Maximum number of iterations to perform.}
}
\details{
  The `ballsd` function implements an adaptive stochastic optimization algorithm. It adjusts the parameters of the objective function in directions chosen based on a probabilistic model. This model favors directions that have historically led to improvements in the objective function, adjusting both the step sizes and the probabilities of choosing each direction based on the outcome of each iteration.
}
\value{
  Returns a numeric vector of the optimized parameters after the specified number of iterations or upon convergence.
}
\references{
  Insert references to the literature or websites where the algorithm is described in more detail here.
}
\author{
  My Nguyen <nguyenm21@vcu.edu>
}
\note{
  Add any additional notes regarding the function here.
}
\seealso{
  \code{\link{optim}}, for general-purpose optimization in R.
}
\examples{
# Define a simple quadratic objective function
objFunc <- function(x) { sum((x - 1)^2) }

# Initial parameters
x0 <- c(0, 0)

# Run the optimization
result <- ballsd(initialParams = x0, objFunc, stepSizeInc = 2, stepSizeDec = 2, probInc = 2, probDec = 2, maxIterations = 100)

# View the optimized parameters
print(result)
}
\keyword{optimization}
