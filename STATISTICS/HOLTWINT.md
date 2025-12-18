# Holt-Winters Forecasting (MBASIC-80)

A Microsoft BASIC-80 (MBASIC-80) program that builds a **Holt–Winters exponential smoothing** model for time series forecasting with **level**, **trend**, and **seasonality**. Supports **additive** and **multiplicative** seasonality (plus an **AUTO** mode), automatically estimates the seasonal period, performs a parameter grid search, and reports forecast accuracy and residual diagnostics.

## What it does

- Prompts for a historical time series (up to 600 points, per `DIM`)
- Supports seasonal model selection:
  - **Additive** (`A`)
  - **Multiplicative** (`M`) (requires all data > 0)
  - **AUTO** (`AUTO`) (runs both and selects the lower RMSE)
- Automatically detects the **seasonal period `P`** using the **autocorrelation function (ACF)**
- Optimizes smoothing parameters by grid search:
  - **Alpha (α)** = level
  - **Beta (β)** = trend
  - **Gamma (γ)** = seasonality
  - Search can be **Fast** (80 combos) or **Full** (810 combos)
- Produces forecasts with **95% prediction intervals**
- Computes error metrics (held-out / forecast horizon):
  - **MPE**, **MAPE**, **MAE**, **RMSE**, and **MSE**
- Computes residual diagnostics (in-sample one-step residuals):
  - **Durbin–Watson statistic**
  - **Ljung–Box Q test**
- Includes an **INFO** menu and a **DEBUG** mode with built-in sample data

## Files

- `HOLTWIN.BAS`

## Requirements

- **MBASIC-80** interpreter (CP/M or DOS environment)
- Other BASIC interpreters may work with minor adjustments

## How to run

1. Launch MBASIC-80.
2. Load the program (example): `LOAD "HOLTWIN.BAS"`
3. Run: `RUN`
4. At the prompt:
   - Press **RETURN** to start
   - Type **INFO** for the info/help menu
   - Type **DEBUG** to auto-populate sample data and run AUTO mode

## Inputs

- **Seasonality model**: `A`, `M`, or `AUTO` (skipped if DEBUG)
- **Number of historical points**: `N` (validated as a positive integer)
- **Data points**: entered one-by-one with basic numeric validation and confirmation
- **Forecast horizon**: `H` (1–100); training size is `TRAINSIZE = N - H`
- **Search mode**:
  - `F` = Fast search (coarser grid)
  - `FULL` = Full search (denser grid)

## Output

- Detected seasonal period: `P` (defaults to 12 if not detected)
- Best smoothing parameters:
  - `BESTALPHA`, `BESTBETA`, `BESTGAMMA`
- Forecasts and **95% prediction intervals** (Upper/Lower)
- Held-out error metrics:
  - MPE, MAPE, MAE, RMSE, MSE
- Residual diagnostics:
  - Durbin–Watson, Ljung–Box Q
- ACF tables for:
  - Historical data (`ACFY`)
  - Residuals (`ACFRES`)
- Optional printing via `LPRINT` (menu option `P`)
- On-screen “review” report (`V`)

## Notes and limitations

- **Multiplicative model requires all Y > 0.** If AUTO mode detects non-positive values, it will skip multiplicative and use additive results.
- **Seasonal period detection** is ACF-based and capped by the program’s limits (`MAXLAG` up to 100). Very large `P` values can be rejected.
- **Parameter search is brute force** and can be slow on vintage hardware, especially in `FULL` mode.
- **Intervals** use an in-sample one-step residual standard error (`SE`) and scale by `SQR(step)`.

## Version

- Program banner reports: **Holt–Winters Forecasting Program v1.2**

## Author

Christopher D. Van Der Kaay, Ph.D. (2025)
