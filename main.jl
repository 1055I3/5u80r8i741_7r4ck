push!(LOAD_PATH, raw"src")
using src

function main(ARGS::Vector{String})
    if length(ARGS) != 5
        error("\nthe call should contain 5 arguments:\njulia main.jl [semi-major axis] [eccentricity] [inclination] [argument of periapsis] [revolutions]\n")
    end

    a::Float64 = parse(Float64, ARGS[1])                                            # semi-major axis [m]
    e::Float64 = parse(Float64, ARGS[2])                                            # eccentricity [< 1]
    i::Float64 = parse(Float64, ARGS[3])                                            # inclination [deg]
    ω::Float64 = parse(Float64, ARGS[4])                                            # argument of periapsis [deg]
    k::Float64 = parse(Float64, ARGS[5])                                            # satelite revolutions

    (λ, Φ) = suborbital_track(a, e, i, ω, k)
    
    draw(a, e, i, ω, λ, Φ)
end

main(ARGS)
