function t_since_perigee(t::Float64, T::Float64)
    t < T ? t : t % T
end

function eccentric_anomaly(e::Float64, M::Float64)
    function Δ(e, E, M)
        eSinE = e*sin(E)
        eCosE = e*cos(E)

        Δ1 = (E - eSinE - M) / (1 - eCosE)
        Δ2 = (E - eSinE - M) / (1 - eCosE - Δ1*eSinE / 2)
        Δ3 = (E - eSinE - M) / (1 - eCosE - Δ2*(eSinE - Δ2*eCosE/3) / 2)

        Δ3
    end

    ϵ = 1e-14

    E::Float64 = M

    for _ in 1:4
        E = M + e*sin(E)
    end

    while true
        ΔE = Δ(e, E, M)
        E -= ΔE

        ϵ < abs(ΔE) || break
    end

    E
end

function true_anomaly(e::Float64, E::Float64)
    2*atan(tan(E/2) * sqrt((1 + e)/(1 - e)))
end

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

function spherical_coordinates(X, Y, Z)
    r::Float64 = sqrt(X^2 + Y^2 + Z^2)
    
    Φ::Float64 = asind(Z / r)                                                        # latitude
    λ::Float64 = atand(Y, X)                                                         # longitude

    (λ, Φ)
end

using Base.Threads: @threads

function ground_track(a::Float64, e::Float64, i::Float64, ω::Float64)
    G::Float64 = 6.673e-11                                                          # gravitational constant [m^3/(kg*s^2)]
    ME::Float64 = 5.9722e24                                                         # earth mass [kg]
    μ::Float64 = G*ME

    Δt::Float64 = 0.001                                                             # time step [s]
    n::Float64 = sqrt(μ / a^3)                                                      # mean motion [rad]
    T::Float64 = 2*π / n                                                            # revolution period [s]
    ΔΩ = Δt * 2*π / 86400                                                           # l. a. n. change per time step [rad]

    t::Vector{Float64} = [x for x in 0:Δt:2*T]                                      # time [s]
    Ω::Vector{Float64} = zeros(Float64, length(t))                                  # longitude of the ascending node [rad]
    λ::Vector{Float64} = zeros(Float64, length(t))                                  # longitude [deg]
    Φ::Vector{Float64} = zeros(Float64, length(t))                                  # latitude [deg]

    for x in eachindex(Ω[1:end-1])
        @inbounds Ω[x+1] = Ω[x] - ΔΩ
    end

    @threads for x in eachindex(t)
        @inbounds M::Float64 = n*t_since_perigee(t[x], T)
        E::Float64 = eccentric_anomaly(e, M)
        f::Float64 = true_anomaly(e, E)
        @inbounds (X, Y, Z) = cartesian_coordinates(a, e, i, ω, Ω[x], f)
        @inbounds (λ[x], Φ[x]) = spherical_coordinates(X, Y, Z)
    end

    (λ, Φ)
end

#= plt.plot(track_longitude, track_latitude, '.')
plt.xlabel('longitude [deg]')
plt.ylabel('latitude [deg]')
plt.xlim(-180, 180)
plt.ylim(-90, 90)
plt.title('a=' + str(a) + '; e=' + str(e) + '; i=' + str(i) + '; omega=' + str(math.degrees(omega)))
plt.grid(True)
#plt.savefig('molniya_sferne.png', dpi=900)
plt.show() =#

using Plots

function draw(a::Float64, e::Float64, i::Float64, w::Float64, λ::Vector{Float64}, Φ::Vector{Float64})
    scatter(λ, Φ, markersize=0.01, markercolor=:midnightblue)
    title!("a=$a e=$e i=$(rad2deg(i)) ω=$(rad2deg(w))")
    xlabel!("longitude [deg]")
    ylabel!("latitude [deg]")
    xlims!(-180, 180)
    ylims!(-90, 90)
    savefig("ground_track.png")
end

function main(ARGS::Vector{String})
    if length(ARGS) != 4
        error("the call should contain 4 arguments:\njulia main.jl 26600e3 0.74 63.4 -90\n")
    end

    a::Float64 = parse(Float64, ARGS[1])                                            # semi-major axis [m]
    e::Float64 = parse(Float64, ARGS[2])                                            # eccentricity [< 1]
    i::Float64 = deg2rad(parse(Float64, ARGS[3]))                                   # inclination [rad]
    ω::Float64 = deg2rad(parse(Float64, ARGS[4]))                                   # argument of periapsis [rad]

    (λ, Φ) = ground_track(a, e, i, ω)
    
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
