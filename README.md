# Wind Turbine Blade Design Using Blade Element Momentum (BEM) Theory

## Overview

This project implements a MATLAB-based Blade Element Momentum (BEM) model for the preliminary aerodynamic design of a Horizontal Axis Wind Turbine (HAWT) blade.

The code calculates the optimal blade geometry, including:

- Blade chord distribution
- Blade twist distribution
- Reynolds number estimation
- Wind speed probability distribution (Weibull distribution)
- Mechanical power output estimation
- Blade geometry data for aerodynamic simulation software

The objective is to generate a wind turbine blade design that maximizes power extraction while maintaining stable aerodynamic performance across a range of operating wind speeds.

---

## Theory

The project is based on Blade Element Momentum (BEM) Theory, which combines:

### Momentum Theory

- Models the rotor as an actuator disk.
- Determines induced velocities and extracted wind energy.

### Blade Element Theory

- Divides the blade into multiple radial sections.
- Calculates aerodynamic forces on each blade element.

The implementation follows the methodology presented in:

> Chaudhary et al. – *Modeling and Optimal Design of Small HAWT Blades for Analyzing the Starting Torque Behavior*

Prandtl Tip Loss correction is incorporated to improve blade-tip aerodynamic accuracy.

---

## Features

### Blade Geometry Generation

The program computes:

- Local inflow angle
- Local tip speed ratio (TSR)
- Blade chord length distribution
- Blade twist distribution

for each blade element along the rotor span.

### Reynolds Number Estimation

The average blade chord is used to estimate the operating Reynolds number for airfoil performance assessment.

### Weibull Wind Distribution

A Weibull probability distribution is generated to represent realistic site wind conditions.

### Power Prediction

Mechanical power output is estimated across a range of wind speeds using aerodynamic force calculations derived from BEM theory.

---

## Input Parameters

The following parameters can be modified directly in the MATLAB script:

| Parameter | Description |
|------------|------------|
| Airfoil | Selected airfoil profile |
| TSR | Design tip speed ratio |
| Wind Speed | Design wind speed |
| Radius | Blade radius |
| Alpha | Design angle of attack |
| Lift Coefficient | Airfoil lift coefficient |
| Drag Coefficient | Airfoil drag coefficient |
| Number of Blades | Rotor blade count |
| Air Density | Atmospheric density |
| Number of Elements | Blade discretization sections |

### Example Configuration

```matlab
airfoil = 'SD 7062';
TSR = 6;
windSpeed = 10;
R = 0.75;
alpha = 7;
liftC = 1.1;
dragC = 0.02;
bladeN = 3;
rho = 1.225;
N = 50;
```

---

## Outputs

### Blade Geometry Table

The code exports a table containing:

| Position (m) | Twist (deg) | Chord (m) |
|-------------|-------------|-----------|

This data can be imported directly into aerodynamic simulation tools such as ASHES.

### Power Curve

The model generates a power curve:

```text
Power (W) vs Wind Speed (m/s)
```

for turbine performance evaluation.

### Wind Distribution

A Weibull probability distribution is generated for site wind resource assessment.

---

## Methodology

### Step 1 – Blade Discretization

The rotor blade is divided into multiple radial elements.

### Step 2 – Inflow Angle Calculation

The local inflow angle is calculated for each blade section using the local TSR.

### Step 3 – Tip Loss Correction

Prandtl's tip loss factor is applied to account for finite blade effects.

### Step 4 – Chord and Twist Calculation

The optimal chord and twist distributions are calculated for each blade section.

### Step 5 – Reynolds Number Estimation

The average blade chord is used to estimate operating Reynolds number.

### Step 6 – Power Estimation

Tangential aerodynamic forces are calculated and integrated to determine rotor power output.

---

## Project Structure

```text
WoC_matlab-main/
│
├── bem11.m
├── README.md
├── Example Outputs/
│
└── Documentation/
```

---

## Software Requirements

- MATLAB R2020a or newer
- No additional toolboxes required

---

## Running the Code

1. Open MATLAB.
2. Load the project directory.
3. Open:

```matlab
bem11.m
```

4. Click **Run**.

The script will:

- Calculate blade chord distribution
- Calculate blade twist distribution
- Estimate Reynolds number
- Generate Weibull wind distribution
- Predict turbine power output
- Export blade geometry data

---

## Applications

This project can be used for:

- Wind turbine blade design
- Renewable energy research
- Aerodynamic optimization studies
- Undergraduate engineering projects
- Postgraduate research projects
- Preliminary rotor performance assessment

---

## Future Improvements

Potential future developments include:

- Airfoil polar interpolation
- Dynamic stall modelling
- Variable pitch analysis
- Structural load calculations
- CFD validation
- Automatic optimization algorithms
- OpenFAST integration
- QBlade integration

---

## References

1. Chaudhary, H., et al.
   *Modeling and Optimal Design of Small HAWT Blades for Analyzing the Starting Torque Behavior*

2. Hansen, M. O. L.
   *Aerodynamics of Wind Turbines*

3. Burton, T., Jenkins, N., Sharpe, D., Bossanyi, E.
   *Wind Energy Handbook*

---

## Author

Composites Teams

Winds of Change | Engineering for change

University of Edinburgh
