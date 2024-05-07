#include <Rcpp.h>
#include <cmath>  // Include cmath for mathematical constants and functions

using namespace Rcpp;
// [[Rcpp::export]]
List BOOOM_opt(List Mat, Function func, double desired_min = -10^(60),
               double s_init = 1, int no_runs = 10, int max_iter = 100,
               double rho = 2, double phi = 10^(-20), double tol_fun = 10^(-6),
               double tol_fun_2 = 10^(-15), double desired_improv_rate = 10^(-20),
               int improv_rate_period = 20, int total_iter = 10000, int print_output = 0) {
  NumericMatrix X0 = as<NumericMatrix>(Mat[0]);
  int n = X0.nrow();
  int p = X0.ncol();
  double start_value = as<double>(func(Mat));
  List OLD_RUN_THETA = clone(Mat);
  double current_new_lh = start_value;
  double num_total_iter = 0;
  
  if (n < 2) {
    Rcout << "Minimum number of rows must be 2." << std::endl;
    return List::create();
  }
  
  if (n > p) {
    Rcout << "The number of rows must be smaller than or equal to number of columns!" << std::endl;
    return List::create();
  }
  for (int iii = 0; iii < no_runs; ++iii) {
    double epsilon = s_init * M_PI;
    List THETA = (iii == 0) ? clone(Mat) : clone(OLD_RUN_THETA);
    
    for (int i = 0; i < max_iter; ++i) {
      num_total_iter++;
      double current_lh = as<double>(func(THETA));
      
      if (print_output == 1) {
        Rcout << "Run number: " << (iii + 1) << std::endl;
        Rcout << "Iteration number (within current run): " << (i + 1) << std::endl;
        Rcout << "Total number of iterations: " << num_total_iter << std::endl;
        Rcout << "Current Obj function value: " << current_lh << std::endl;
      }
      
      double cos_value_now = cos(epsilon);
      double sin_value_now = sin(epsilon);
      for (int l = 0; l < Mat.size(); ++l) {
        NumericMatrix Mat_change = as<NumericMatrix>(Mat[l]);
        for (int rr = 0; rr < p; ++rr) {
          for (int cc = 0; cc < p; ++cc) {
            if (rr != cc) {
              NumericMatrix THETA_possibility = clone(Mat_change);
              // Positive + Negative movement
              THETA_possibility(_, rr) = cos_value_now * Mat_change(_, rr) + sin_value_now * Mat_change(_, cc);
              THETA_possibility(_, cc) = -sin_value_now * Mat_change(_, rr) + cos_value_now * Mat_change(_, cc);
              
              List Mat_update = clone(Mat);
              Mat_update[l] = THETA_possibility;
              double total_lh = as<double>(func(Mat_update));
              
              if (total_lh < current_lh) {
                Mat = clone(Mat_update);
                current_lh = total_lh;
              }
            }
          }
        }
      }
      if (abs(as<double>(func(Mat)) - current_lh) < tol_fun) {
        if (epsilon > phi) {
          epsilon /= rho;
        } else {
          break;
        }
      }
      if (as<double>(func(Mat)) < desired_min) {
        break;
      }
      if (num_total_iter > total_iter) {
        break;
      }
    }
  }
  Rcout << "********** TASK COMPLETE ****************" << std::endl;
  Rcout << "Final Obj function value :" << as<double>(func(Mat)) << std::endl;
  
  return Mat;
}
