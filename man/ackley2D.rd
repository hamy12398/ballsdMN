\name{ackley2D}
\alias{ackley2D}
\title{Ackley Function in 2D}
\description{
  Computes the value of the Ackley function at a given point in 2-dimensional space.
}
\usage{
ackley2D(x)
}
\arguments{
  \item{x}{A numeric vector of length 2 representing the coordinates \eqn{(x_1, x_2)} at which the Ackley function is evaluated.}
}
\details{
 The Ackley function attains its global minimum at \eqn{(x_1, x_2) = (0, 0)}, where \eqn{f(x) = 0}.
}
\value{
  A single numeric value representing the value of the Ackley function at the provided point.
}

\note{
  The Ackley function frequently serves as a benchmark for evaluating optimization and search algorithms.
}
\examples{
ackley2D(c(0,0))
}
\keyword{optimization}
