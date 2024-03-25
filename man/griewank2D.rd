\name{griewank2D}
\alias{griewank2D}
\title{Griewank Function Evaluation}
\description{
  Computes the Griewank function value at a given point in 2-dimensional space.
}
\usage{
griewank2D(x)
}
\arguments{
  \item{x}{ A numeric vector representing a point in 2-dimensional space where the Griewank function is evaluated.}
}
\details{
 The Griewank function achieves its global minimum at \eqn{\mathbf{x} = 0}, where \eqn{f(\mathbf{x}) = 0}.
}
\value{
 A single numeric value representing the result of evaluating the Griewank function at the specified point.
}
\note{
  The function is designed for 2D input.
}
\examples{
# Evaluate the Griewank function at the origin
griewank2D(c(0, 0))

}
\keyword{optimization}
