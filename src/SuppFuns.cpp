#include <Rcpp.h>
using namespace Rcpp;

//' Ackley's function in 2D
 //'
 //' @param x A numeric vector of length 2 representing the coordinates (x, y).
 //' @return The value of Ackley's function at the given coordinates.
 //' @export
 // [[Rcpp::export]]
 double ackley2D(NumericVector x) {
   const double a = 20.0;
   const double b = 0.2;
   const double c = 2 * M_PI;
   double term1 = -a * exp(-b * sqrt(0.5 * (x[0] * x[0] + x[1] * x[1])));
   double term2 = -exp(0.5 * (cos(c * x[0]) + cos(c * x[1])));
   return term1 + term2 + a + exp(1);
 }
 
 //' Griewank's function in 2D
 //'
 //' @param x A numeric vector of length 2 representing the coordinates (x, y).
 //' @return The value of Griewank's function at the given coordinates.
 //' @export
 // [[Rcpp::export]]
 double griewank2D(Rcpp::NumericVector x) {
   const int n = x.size();
   double sum = 0.0, prod = 1.0;
   for(int i = 0; i < n; i++) {
     sum += x[i] * x[i];
     prod *= cos(x[i] / sqrt(i + 1));
   }
   return 1 + sum / 4000.0 - prod;
 }
 