function spherical_coordinates(X, Y, Z)
    r::Float64 = sqrt(X^2 + Y^2 + Z^2)
    
    Φ::Float64 = asin(Z / r)                                                        # latitude
    λ::Float64 = atan(Y, X)                                                         # longitude

    (λ, Φ)
end