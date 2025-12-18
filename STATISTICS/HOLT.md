# Holt Double Exponential Smoothing (MBASIC-80)

A Microsoft BASIC-80 (MBASIC-80) program that performs time series forecasting using **Holt’s linear trend (double exponential) smoothing**. It forecasts future values from historical data and reports common accuracy/error metrics.

## What it does

- Prompts for a historical time series (2–200 points)
- Optionally lets you review/edit the entered data (paged)
- Prompts for a forecast horizon (number of future periods)
- Searches for “best” **alpha** and **beta** (by **minimum MSE**) over a fixed grid
- Produces forecasted values and computes:
  - **MAE** (Mean Absolute Error)
  - **MSE** (Mean Square Error)
  - **RMSE** (Root Mean Square Error)
  - **MAPE** (Mean Absolute Percentage Error)

## Files

- `HOLT.BAS`

## Requirements

- An **MBASIC-80** interpreter (CP/M or DOS environment)

## How to run

1. Launch MBASIC-80.
2. Load the program:
   - If saved as `.BAS`: `LOAD "HOLT.BAS"`
   - If saved as a plain listing: paste/import it and save as `.BAS` if desired
3. Run: `RUN`
4. Follow the on-screen prompts.

## Inputs

- **Number of historical points**: `N` (2–200)
- **Data points**: entered one at a time; input is validated as numeric
- **Forecast horizon**: `H` (positive integer), with the constraint `N + H <= 200`

## Output

- Best-fit parameters (by MSE grid search):
  - `BESTALPHA`, `BESTBETA`
- Error / performance metrics:
  - MAE, MSE, RMSE, MAPE
- Forecast table:
  - “PERIOD 1..H: FORECAST = …”
- Optional printed report via `LPRINT` (menu option 3)

## Notes and limitations

- **Alpha/Beta search is a grid search**: `0.10` to `0.99` in steps of `0.02`.
  - This can take noticeable time on real vintage hardware.
- **MAPE handling**: data points very close to zero are skipped to avoid division-by-zero issues.
- Array limits are fixed at 200 (`DIM Y(200), F(200), S(200), B(200)`).

## Version

- Program banner reports: **Holt’s Linear Trend Exponential Smoothing Program 1.2**

## Author

Christopher D. Van Der Kaay, Ph.D. (2025)
