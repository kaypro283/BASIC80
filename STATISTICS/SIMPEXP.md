# Simple Exponential Smoothing (Microsoft BASIC-80)

## About  
A MBASIC-80 implementation of the Simple Exponential Smoothing algorithm for time series forecasting, featuring automatic optimization of the smoothing parameter (alpha), interactive stationarity diagnostics, and comprehensive forecast accuracy metrics.

## Features  
- Supports up to 100 historical data points and forecast horizons  
- Brute-force optimization of alpha to minimize Mean Squared Error (MSE)  
- Statistical measures: MAE, MSE, RMSE, MAPE, SMAPE  
- 95% forecast confidence intervals  
- Interactive stationarity checks (mean/variance shift and differencing)  
- Printable statistical summary and chart  

## Requirements  
This program is written in MBASIC-80 and is compatible with CP/M or DOS based systems or modern emulators that support MBASIC.

## Usage  
1. Run the program in your MBASIC-80 interpreter.  
2. Enter the number of historical data points (2–100).  
3. Input the data values one by one.  
4. Specify the forecast horizon (must satisfy N + H ≤ 100).  
5. Choose a step size for alpha optimization (e.g., 0.01).  
6. Optionally view stationarity diagnostics and metric explanations.  
7. Review the forecast results, intervals, and statistical metrics.  

## Forecast Accuracy Metrics  
- **MAE**: Mean Absolute Error  
- **MSE**: Mean Squared Error  
- **RMSE**: Root Mean Squared Error  
- **MAPE**: Mean Absolute Percentage Error  
- **SMAPE**: Symmetric Mean Absolute Percentage Error

Interpretation guidance is provided based on MAPE thresholds.

## License  
This project is provided for educational and historical computing purposes. No license specified.

## Author  
Christopher D. van der Kaay, Ph.D. 
