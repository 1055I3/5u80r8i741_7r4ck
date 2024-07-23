include(raw"..\anomaly\eccentric_anomaly.jl")
include(raw"..\anomaly\mean_anomaly.jl")
include(raw"..\anomaly\true_anomaly.jl")
include(raw"..\coordinates\cartesian_coordinates.jl")
include(raw"..\coordinates\spherical_coordinates.jl")

# using anomaly
# using coordinates

using Base.Threads: @threads

function suborbital_track(a::Float64, e::Float64, i::Float64, Ω::Float64, ω::Float64, k::Float64)
    G::Float64 = 6.673e-11                                                          # gravitational constant [m^3/(kg*s^2)]
    ME::Float64 = 5.9722e24                                                         # earth mass [kg]
    μ::Float64 = G*ME

    i = deg2rad(i)                                                                  # inclination [rad]
    ω = deg2rad(ω)                                                                  # argument of periapsis [rad]
    Ω = deg2rad(Ω)                                                                  # longitude of the ascending node [rad]

    Δt::Float64 = 0.001                                                             # epoch step [s]
    n::Float64 = sqrt(μ / a^3)                                                      # mean motion [rad / s]
    T::Float64 = 2*π / n                                                            # revolution period [s]
    ΔΩ = Δt * 2*π / 86400                                                           # earth rotation step [rad]

    ts::Vector{Float64} = [x for x in 0:Δt:k*T]                                     # epoch series [s]
    Ωs::Vector{Float64} = zeros(Float64, length(ts))                                # longitude of the ascending node series [rad]
    λ::Vector{Float64} = zeros(Float64, length(ts))                                 # ground longitudes [deg]
    Φ::Vector{Float64} = zeros(Float64, length(ts))                                 # ground latitudes [deg]

    Ωs[1] = Ω
    for x in eachindex(Ωs[1:end-1])
        @inbounds Ωs[x+1] = Ωs[x] - ΔΩ
    end

    @threads for x in eachindex(ts)
        @inbounds M::Float64 = mean_anomaly(n, ts[x], T)
        E::Float64 = eccentric_anomaly(e, M)
        f::Float64 = true_anomaly(e, E)
        @inbounds (X, Y, Z) = cartesian_coordinates(a, e, i, ω, Ωs[x], f)
        @inbounds (λ[x], Φ[x]) = rad2deg.(spherical_coordinates(X, Y, Z))
    end

    (λ, Φ)
end
