# MOONCALC — An MBASIC-80 Astronomy Tool

**Author:** Christopher D. Van Der Kaay, Ph.D.  
**Version:** 1.0 (2025)  
**Platform:** MBASIC-80 (CP/M and DOS compatible)  
**File:** `MOONCALC.BAS`  

---

## What is MOONCALC?

MOONCALC is a fully self-contained astronomy tool written in Microsoft BASIC-80 (MBASIC), capable of calculating:

- The **current lunar phase** and percentage illumination
- The **next full moon and new moon** (based on elongation angles)
- **Sunrise and sunset times** for any location on Earth

This is not a NASA tool, but it *is* a surprisingly powerful lunar calculator written in MBASIC. It’s a tribute to what 8-bit systems can still do. The program is designed for systems running CP/M or DOS, and it has been tested extensively in MBASIC-80. It's a complete, stand-alone tool requiring no external libraries or modules — just a BASIC interpreter.

MOONCALC performs several iterative astronomical calculations, including precise lunar phase searches using small time increments (0.00001 days per step, or ~0.864 seconds). While this allows for reasonably accurate results on legacy hardware, performance will vary significantly depending on your system's speed.

This program has been tested on an IBM XT clone with a NEC V20 at ~10 MHz, 286, and a Pentium III running DOS

Sarches for full or new moons may take any where from several seconds to several minutes. Slower Z80-based systems (such as Kaypro, Osborne, or similar CP/M machines) may take longer to complete a full lunar cycle scan (potentially hours). **If you're running MOONCALC on slower 8-bit machines, please be patient.**

---

## Why I Wrote This

This project has been a proverbial labor of love. Over the course of about a month or so, I combined my interest in astronomy and math with my love of BASIC.

My goal was to make a useful and educational astronomy program that runs on 8-bit systems, while focusing on compatibility with other BASIC dialects. It was also fun to write!

---

## Features

- **Compatibility**  
  No use of `ELSE`, `END IF`, `ELSE IF`, `WHILE`, `WEND`, single-quote comments, etc. to ensure portability with other dialects of BASIC.

- **Double-Precision Calculations**  
  Numeric variables (except for string arrays) are explicitly declared as double-precision.

- **Astronomical Accuracy Within 8-bit Limits**  
  - Moon phase and illumination calculations use Meeus-style approximations.  
  - Lunar elongation determines full and new moon events via time-stepped search (0.00001 days per step ≈ 0.864 seconds).
  - Sunrise and sunset are calculated using standard solar declination and hour angle formulas.

- **User Input Validation**  
  Includes leap year checks, day/month constraints, and range checking for all astronomical parameters.

---

## Known Limitations

While MOONCALC is accurate given the platform, there are some limitations:

### Full Moon and New Moon Accuracy
- The time can be off by a few hours comapred to published results.
- This is due to:
  - The relatively simple solar and lunar position models (using only mean anomalies and basic trigonometric corrections)
  - The limited numeric resolution of MBASIC's floating-point engine
  - The lack of iterative root-finding or perturbation modeling (which programs like NASA’s SPICE or JPL DE ephemerides would use)

### Sunrise and Sunset
- These are generally spot on, often within a minute or two of modern calculators.
- Atmospheric effects (e.g., refraction) are not modeled.

---

## Running the Program

You can run `MOONCALC.BAS` on any MBASIC-80 interpreter.

### Steps:
1. Boot into CP/M or DOS
2. Load your MBASIC interpreter
3. Load the program
4. Run it!

---

## Algorithms & Approach

- **Julian Date Conversion:** Handles both Julian and Gregorian calendars (with 1582 cutoff).
- **Delta-T Estimation:** Polynomial approximations by century (1600–2100), fallback default if out of range.
- **Phase Detection:** Matches the Moon’s elongation to 0° (new moon) and 180° (full moon) within a ±0.1° tolerance.
- **Time Stepping:** 0.00001-day increments (0.864 sec) for precise search using only basic FOR-loops and trigonometry.
- **Moon Distance:** Approximated using cosine terms of mean anomaly and elongation delta.

---

## Planned Features

This is an ongoing project, and I plan to expand it with additional astronomical functionality and documentation.

### Upcoming Features:
- **Moonrise and Moonset Time Calculation**
  - This will involve computing the Moon's declination and hour angle similarly to the sunrise/sunset routine, but with additional handling for its rapid motion and varying parallax.
  - May require small-step iterations similar to the existing lunar phase search.

- **Detailed Program Documentation**
  - I plan to write a technical guide explaining the underlying algorithms:
    - Lunar phase modeling
    - Julian Date conversion and Delta-T use
    - Approximate ephemeris calculations
    - How MBASIC handles floating-point arithmetic

If you have suggestions or want to collaborate, feel free to open an issue or reach out!
