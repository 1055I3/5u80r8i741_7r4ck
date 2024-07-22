function cartesian_coordinates(a::Float64, e::Float64, i::Float64, omega::Float64, OMEGA::Float64, f::Float64)
    r::Float64 = (a - a*e^2) / (1 + e*cos(f))
    sinOMEGA::Float64 = sin(OMEGA)
    cosOMEGA::Float64 = cos(OMEGA)
    sin_omega_f::Float64 = sin(omega + f)
    cos_omega_f::Float64 = cos(omega + f)
    sin_i::Float64 = sin(i)
    cos_i::Float64 = cos(i)

    X::Float64 = r * (cosOMEGA * cos_omega_f - sinOMEGA * sin_omega_f * cos_i)      # cartesian x coordinate
    Y::Float64 = r * (sinOMEGA * cos_omega_f + cosOMEGA * sin_omega_f * cos_i)      # cartesian y coordinate
    Z::Float64 = r * sin_omega_f * sin_i                                            # cartesian z coordinate

    (X, Y, Z)
end