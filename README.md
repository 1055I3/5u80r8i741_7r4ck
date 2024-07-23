[![Julia](https://img.shields.io/badge/Made%20with-Julia-9558B2?logo=julia&logoColor=white)](https://julialang.org/)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Windows](https://img.shields.io/badge/Windows-0078D6)](https://en.wikipedia.org/wiki/Windows_10)
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)

# Suborbital Track

Projection of a satellite orbit onto the surface of the Earth.

## Description

Suppose that we want to launch a satellite, but we have to decide which orbit are we going to send it to?

The satellite should service a certain area on the ground and we want to make sure that it passes above those regions.

Building and launching satellites is exhausting, so we cannot afford to launch multiple satellites in different orbits just to see which one is the best.

We write a program that for a given set of orbital elements, namely *semi-major axis* $a$, *eccentricity* $e$, *inclination* $i$, *longitude of the ascending node* $\Omega$ and *argument of the periapsis* $\omega$ calculates the ground track of a satellite flying in that orbit.

Now we can launch satellites.

## Requirements

This project has been developed using `Julia 1.9.2` and library `Plots 1.40.5` on `Windows 10 Pro 22H2`. It has been successfully run on `Julia 1.8.5` and `Julia 1.10.4` and in general should work on `Julia 1.7.x` and subsequent versions.

## Run the Simulation

First, position your working directory in the `5u80r8i741_7r4ck` directory of the project as it was cloned.

The program is intended to be executed using the following template.
```
julia -t "auto" main.jl [semi-major axis] [eccentricity] [inclination] [longitude of the ascending node] [argument of periapsis] [revolutions]
```
For example, if you wanted to calculate ground track for two periods of a *Molniya* orbit you would run the following.
```
julia -t "auto" main.jl 26600e3 0.74 63.4 90 -90 2
```
Another interesting example for ground track would be two periods of a *Tundra * orbit, which can be plotted by running the following code.
```
julia -t "auto" main.jl 42163e3 0.27 63.4 90 -90 2
```
A simple example for ground path would be five periods of a *lower earth orbit*, as its plotted by the following code.
```
julia -t "auto" main.jl 6796e3 0.000126 51.638 90 -100 5
```
The program saves its output plot as `.png` file in the working directory.

Be aware that plotting may take some time, even on a faster computer.

## License

This project uses `BSD 3-Clause License`.
The complete text can be found in `LICENCE` file.

## Additional

This project is purely educational and it was not designed to meet any production standards for real-world usage.

I would like to thank professor [*Dušan Marčeta*](https://poincare.matf.bg.ac.rs/~dusan.marceta/) for his guidance and mentorship on this project.

<!-- полупречник Земље - 6378km
молния a=26600e3, e=0.74, i=63.4, omega=-90
тундра a=42163e3, e=0.27, i=63.4, omega=-90
супертундра a=42163e3, e=0.423, i=63.4, omega=-90
лупус a=29991.5e3, e=0.6, i=63.4, omega=-90
вирго a=20260.2, e=0.66085, i=, omega=-90
вест a=20267.1, e=0, i=75, omega=0
гео a=42163e3, e=0, i=0, omega=0
нзо0 a=8000e3, e=0, i=30, omega=30
нзо1 a=6796e3, e=0.000126, i=51.638, omega=-100

julia -t "auto" main.jl 29991.5e3 0.6 63.4 45 -90 2  -->