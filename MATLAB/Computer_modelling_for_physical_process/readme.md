# 🔥 Finite Difference Method for Stationary 2D Heat Conduction Problem

## 📜 Project Overview
This project focuses on determining the temperature distribution within a plate in a steady-state condition using the Finite Difference Method (FDM). The goal is to provide a numerical solution to the heat conduction problem, validating the results using MATLAB® and ANSYS® Fluent.

## 🛠️ Key Features
- **Finite Difference Method**: Implementation for approximating the 2D heat conduction equation.
- **MATLAB® Simulation**: Investigation and visualization of the temperature field.
- **ANSYS® Fluent Validation**: Analytical validation of the MATLAB results.

## 📚 Project Contents
- **Introduction**: Physical problem formulation.
- **Mathematical Formulation**: Establishing appropriate finite difference terms.
- **Boundary Conditions**: Analysis of temperature and heat flux boundary conditions.
- **MATLAB Implementation**: Discretization and simulation of the temperature field.
- **Analytical Validation**: Comparison with ANSYS® Fluent results.
- **Conclusion**: Evaluation of results and findings.

## 🔍 Methodology
1. **Physical Problem Formulation**: Define the material parameters, dimensions, and boundary values.
2. **Mathematical Formulation**: Develop the general equation for heat conduction, assuming 2D steady-state conditions, constant thermal conductivity, and no internal heat generation.
3. **Finite Difference Approximation**: Use central difference methods for first and second-order derivatives.
4. **Boundary Conditions**: Apply temperature and heat flux boundary conditions.
5. **MATLAB Implementation**: Discretize the 2D plate and investigate the temperature field.
6. **Analytical Validation**: Validate MATLAB data using ANSYS® Fluent simulations.

## 📊 Results
### MATLAB Simulation
- Discretization of the 2D plate.
- Temperature field analysis using MATLAB.

### ANSYS® Fluent Validation
- Setup and solution in ANSYS® Fluent.
- Comparison of temperature data along horizontal and vertical mid-lines of the plate.

### Result Comparison
| Number of Meshes | Horizontal Midline Difference (Max/Average) | Vertical Midline Difference (Max/Average) |
| ---------------- | ------------------------------------------- | ---------------------------------------- |
| 100              | 2.5128 / 1.8324                             | 4.3920 / 2.1477                          |
| 200              | 2.0770 / 1.7260                             | 4.1900 / 2.0523                          |
| 300              | 0.5561 / 0.2375                             | 0.9431 / 0.2255                          |



## 📧 Contact
For any questions or feedback, feel free to reach out.

---
