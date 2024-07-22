function mean_anomaly(n::Float64, t::Float64, T::Float64)
    function t_since_perigee(t::Float64, T::Float64)
        t < T ? t : t % T
    end
    
    n*t_since_perigee(t, T)
end