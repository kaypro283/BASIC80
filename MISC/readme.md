# MBASIC-80 LunarCalc v3.1

**Moon Phase, Illumination, and Sunrise/Sunset Calculator**  
Author: C. van der Kaay  
Year: 2025

## Overview

LunarCalc v3.1 is a vintage-style astronomy calculator written in MBASIC-80.  
It computes:

- Moon phase and illumination
- Julian Day
- Sunrise and sunset times (approximate, UTC)
- Solar declination

All calculations are based on Meeus-style approximations and user input.

## Features

- Input year, month, day, time, and location
- Calculates lunar phase and illumination %
- Classifies moon phase (New, Full, etc.)
- Estimates sunrise and sunset based on latitude/longitude
- Includes delta-T correction

## Usage

Run this program using a compatible MBASIC-80 environment or emulator.

Follow the on-screen prompts to enter:

- Year, month, and day
- Hour and minute (UTC)
- Delta-T in seconds (e.g., 69)
- Latitude (decimal degrees, N=+ / S=-)
- Longitude (decimal degrees, E=+ / W=-)

After entering the data, the program will display:

- Julian Day
- Lunar age
- Moon phase name
- Illumination percentage
- Approximate sunrise and sunset times in UTC


## Limitations

- Accuracy is approximate; not suitable for professional astronomical use.
- Delta-T must be manually provided.
- Sunrise/sunset times do not account for atmospheric refraction or elevation.
