#include <Rcpp.h>
using namespace Rcpp;

// Function to sample a direction based on probabilities
int sampleDirection(const NumericVector& probabilities) {
  double randValue = R::runif(0, 1); // Generate a random number between 0 and 1
  double cumulativeProbability = 0.0;
  for (int i = 0; i < probabilities.size(); ++i) {
    cumulativeProbability += probabilities[i];
    if (randValue <= cumulativeProbability) {
      return i; // Return the selected direction
    }
  }
  return probabilities.size() - 1; // Return the last index if none chosen (should not happen)
}

//' Ball's Algorithm for Stochastic Descent (ballsd)
//'
//' This function implements Ball's Algorithm for Stochastic Descent to minimize or maximize an objective function `objFunc` with respect to its parameters.
//'
//' @param initialParams Initial parameters as a numeric vector.
//' @param objFunc The objective function to be optimized.
//' @param stepSizeInc Step size increase factor, applied when a new parameter set improves the objective function value.
//' @param stepSizeDec Step size decrease factor, applied when a new parameter set does not improve the objective function value.
//' @param probInc Probability increase factor, applied to increase the selection probability of a successful direction.
//' @param probDec Probability decrease factor, applied to decrease the selection probability of an unsuccessful direction.
//' @param maxIterations Maximum number of iterations to perform.
//' @return Returns a numeric vector of optimized parameters.
//' @examples
//' objFunc <- function(x) { sum((x - 1)^2) }  # Simple quadratic objective
//' initialParams <- c(0, 0)
//' result <- ballsd(initialParams, objFunc, stepSizeInc = 2, stepSizeDec = 2, probInc = 2, probDec = 2, maxIterations = 100)
//' @export
// [[Rcpp::export]]
NumericVector ballsd(NumericVector initialParams, Function objFunc, 
                     double stepSizeInc, double stepSizeDec, double probInc, double probDec, 
                     int maxIterations) {
  int nParams = initialParams.size();
  int nDirections = 2 * nParams;
  NumericVector stepSizes(nDirections);
  NumericVector probabilities(nDirections, 1.0 / nDirections);
  NumericVector params = clone(initialParams);
  double currentEnergy = as<double>(objFunc(params));
  
  // Initialize step sizes
  for (int i = 0; i < nDirections; ++i) {
    stepSizes[i] = 2;
  }
  
  for (int iter = 0; iter < maxIterations; ++iter) {
    int selectedDirection = sampleDirection(probabilities);
    
    int paramIndex = selectedDirection % nParams;
    bool isPositiveDirection = selectedDirection < nParams;
    
    NumericVector updatedParams = clone(params);
    if (isPositiveDirection) {
      updatedParams[paramIndex] += stepSizes[selectedDirection];
    } else {
      updatedParams[paramIndex] -= stepSizes[selectedDirection];
    }
    
    double newEnergy = as<double>(objFunc(updatedParams));
    
    if (newEnergy < currentEnergy) {
      params[paramIndex] = updatedParams[paramIndex];
      currentEnergy = newEnergy;
      stepSizes[selectedDirection] *= stepSizeInc;
      probabilities[selectedDirection] *= probInc;
    } else {
      stepSizes[selectedDirection] /= stepSizeDec;
      probabilities[selectedDirection] /= probDec;
    }
    
    probabilities = probabilities / sum(probabilities); // Renormalize probabilities
  }
  
  return params;
}
