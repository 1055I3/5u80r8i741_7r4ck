push!(LOAD_PATH, raw"src")
using src

function main(ARGS::Vector{String})
    if length(ARGS) != 4
        error("the call should contain 4 arguments:\njulia main.jl 26600e3 0.74 63.4 -90\n")
    end

    a::Float64 = parse(Float64, ARGS[1])                                            # semi-major axis [m]
    e::Float64 = parse(Float64, ARGS[2])                                            # eccentricity [< 1]
    i::Float64 = parse(Float64, ARGS[3])                                            # inclination [deg]
    ω::Float64 = parse(Float64, ARGS[4])                                            # argument of periapsis [deg]

    (λ, Φ) = suborbital_track(a, e, i, ω)
    
    draw(a, e, i, ω, λ, Φ)
end

main(ARGS)

# полупречник Земље - 6378km
# молния a=26600e3, e=0.74, i=63.4, omega=-90
# тундра a=42163e3, e=0.27, i=63.4, omega=-90
# супертундра a=42163e3, e=0.423, i=63.4, omega=-90
# лупус a=29991.5e3, e=0.6, i=63.4, omega=-90
# вирго a=20260.2, e=0.66085, i=, omega=-90
# вест a=20267.1, e=0, i=75, omega=0
# гео a=42163e3, e=0, i=0, omega=0
# нзо0 a=8000e3, e=0, i=30, omega=30
# нзо1 a=6796e3, e=0.000126, i=51.638, omega=-100

# julia -t "auto" ground_track.jl 29991.5e3 0.6 63.4 -90
