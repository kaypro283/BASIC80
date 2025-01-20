# COMPACT-LEDGER V1.1

**Compact-Ledger** is an accounting program written in **MBASIC-80 for CP/M**, inspired by the 1980s **Mini-Ledger** by Paradigm Consultants. Designed for the **Kaypro II/83, IV/83, and 10**, it lets you manage revenues, expenses, and generate reports.

## Features
- Define up to **99 unique codes** for revenues and expenses.
- Record transactions with amounts, descriptions, and dates.
- Generate detailed reports:
  - By date range, code, or category.
  - Monthly summaries.
- Save and load data files, export to CSV, and print reports.

## Requirements
- **OS**: CP/M
- **Hardware**: Kaypro II/83 or compatible
- **Interpreter**: MBASIC-80

## Getting Started
1. Copy `COMPACT-LEDGER.BAS` to your CP/M system.
2. Load with `MBASIC COMPACT-LEDGER.BAS`.
3. Run the program using `RUN`.
4. Use the main menu to:
   - Define codes.
   - Add ledger entries.
   - Generate and view reports.
   - Save/export data to files.

## Sample Workflow
1. Define codes (`R01` for revenue, `E01` for expenses).
2. Add transactions (e.g., rent, sales).
3. Generate reports by date range or category.
4. Save your ledger (`JAN2025.DAT`) or export to CSV.

## Known Limitations
- Max **99 codes** and **3000 ledger entries**.
- Data must be saved before exiting to avoid loss.

## License
This project is licensed under the **MIT License**. See the `LICENSE` file for details.
