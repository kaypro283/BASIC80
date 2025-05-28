# Holt-Winters Forecasting in Microsoft BASIC-80

A comprehensive **Holt-Winters exponential smoothing** forecasting engine written in structured **BASIC**, originally designed for **MBASIC-80** on CP/M or DOS systems.

## Features

- Supports both **additive** and **multiplicative** seasonal models  
- Automatically detects **seasonal period (P)** using the **autocorrelation function (ACF)**
- Performs **exhaustive grid search** to optimize smoothing parameters:  
  - `α` (Alpha) – Level  
  - `β` (Beta) – Trend  
  - `γ` (Gamma) – Seasonality
- Computes forecasts with **95% prediction intervals**
- Calculates standard error metrics:  
  - **MPE** (Mean Percentage Error)  
  - **MAPE** (Mean Absolute Percentage Error)  
  - **MAE**, **RMSE**, and more
- Includes diagnostic tests for residuals:  
  - **Durbin-Watson statistic**  
  - **Ljung-Box Q test**
- Includes a **debug mode** with built-in sample data
- User interface supports **interactive input**, **input validation**, and **info/help menus**

## Intended Use

Originally developed as a **statistical modeling tool for time series forecasting** on vintage systems, this program is ideal for:
- Educational use (learning exponential smoothing and classical forecasting)
- Historical preservation of computational methods
- Demonstrating robust forecasting in constrained environments

## Platform Details

- Written for **MBASIC-80**
- Compatible with other BASIC interpreters with modification
  
## Author

**Christopher D. Van Der Kaay, Ph.D.**
