# Simple Exponential Smoothing (MBASIC-80)

A Microsoft BASIC-80 (MBASIC-80) implementation of **Simple Exponential Smoothing (SES)** for time series forecasting. The program interactively accepts historical data, **brute-force optimizes alpha (α)** to minimize **MSE**, optionally runs basic stationarity checks, and reports forecast accuracy metrics and **95% forecast intervals**.

## What it does

- Prompts for historical data (`N`, 2–100) and a forecast horizon (`H`), with `N + H <= 100`
- Searches for an **optimal alpha (α)** using a user-defined step size
- Generates constant SES forecasts for the horizon (future forecast = last smoothed value)
- Computes forecast accuracy metrics:
  - **MAE**, **MSE**, **RMSE**
  - **MAPE** (skips points where actual = 0)
  - **SMAPE** (handles zero/near-zero cases more robustly)
- Computes **95% forecast confidence intervals** for each step ahead
- Includes optional, interactive stationarity diagnostics:
  - First-differenced series display
  - Mean/variance comparison (first half vs second half)
- Provides metric explanations and a printable summary report

## Files

- `SIMPEXP.BAS'

## Requirements

- An **MBASIC-80** interpreter (CP/M or DOS environment)

## How to run

1. Launch MBASIC-80.
2. Load the program (example): `LOAD "SES.BAS"`
3. Run: `RUN`
4. Follow the prompts:
   - Enter `N` data points
   - Enter forecast horizon `H`
   - Enter alpha step size (e.g., `0.01`)
   - Optionally view diagnostics and metric explanations

## Inputs

- **N**: number of historical points (2–100)
- **Y(i)**: data points (validated as numeric)
- **H**: forecast horizon (positive integer), must satisfy `N + H <= 100`
- **ALPHASTEP**: search step size (`0.001` to `0.1`)
- Optional prompts:
  - View metric explanations (Y/N)
  - View first-differenced series (Y/N)
  - Compare means/variances of halves (Y/N)

## Output

- Optimal alpha: `ALPHA`
- Forecasts for steps `1..H`, including:
  - Forecast value
  - Lower 95% interval
  - Upper 95% interval
- Accuracy metrics (computed on in-sample one-step errors):
  - MAE, MSE, RMSE, MAPE (if defined), SMAPE (if defined)
- MAPE threshold interpretation (highly accurate / good / reasonable / inaccurate)
- Menu options to restart, show results again, print report, or end

## Notes and limitations

- **SES is best for series with no trend or seasonality** (the program states this in the intro text).
- **Alpha optimization is a grid search** from `ALPHASTEP` to `0.99`.
- **MAPE** is undefined when actuals are zero; the program skips those points and prints `N/A` if none are usable.
- Forecast intervals are computed from residual variance and a step-ahead variance factor (SES assumption, no trend/seasonality).

## Version

- Program banner reports: **Simple Exponential Smoothing Forecasting Tool v1.2**

## Author

Christopher D. van der Kaay, Ph.D. (2025)
