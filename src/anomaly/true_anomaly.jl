function true_anomaly(e::Float64, E::Float64)
    2*atan(tan(E/2) * sqrt((1 + e)/(1 - e)))
end