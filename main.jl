push!(LOAD_PATH, raw"src")
using src

function main(ARGS::Vector{String})
    if length(ARGS) != 6
        error("""\nthe call should contain 6 arguments:\njulia -t "auto" main.jl [semi-major axis] [eccentricity] [inclination] [longitude of the ascending node] [argument of periapsis] [№ revolutions]\n""")
    end

    a::Float64 = parse(Float64, ARGS[1])                                            # semi-major axis [m]
    e::Float64 = parse(Float64, ARGS[2])                                            # eccentricity [< 1]
    i::Float64 = parse(Float64, ARGS[3])                                            # inclination [deg]
    Ω::Float64 = parse(Float64, ARGS[4])                                            # longitude of the ascending node [deg]
    ω::Float64 = parse(Float64, ARGS[5])                                            # argument of periapsis [deg]
    k::Float64 = parse(Float64, ARGS[6])                                            # № satelite revolutions

    (λ, Φ) = suborbital_track(a, e, i, Ω, ω, k)
    
    draw(a, e, i, Ω, ω, λ, Φ)
end

main(ARGS)
