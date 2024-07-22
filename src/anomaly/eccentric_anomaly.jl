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