function cartesian_coordinates(a::Float64, e::Float64, i::Float64, ω::Float64, Ω::Float64, f::Float64)
    r::Float64 = (a - a*e^2) / (1 + e*cos(f))
    sinΩ::Float64 = sin(Ω)
    cosΩ::Float64 = cos(Ω)
    sin_ω_f::Float64 = sin(ω + f)
    cos_ω_f::Float64 = cos(ω + f)
    sin_i::Float64 = sin(i)
    cos_i::Float64 = cos(i)

    X::Float64 = r * (cosΩ * cos_ω_f - sinΩ * sin_ω_f * cos_i)      # cartesian x coordinate
    Y::Float64 = r * (sinΩ * cos_ω_f + cosΩ * sin_ω_f * cos_i)      # cartesian y coordinate
    Z::Float64 = r * sin_ω_f * sin_i                                            # cartesian z coordinate

    (X, Y, Z)
end