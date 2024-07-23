using Plots

function draw(a::Float64, e::Float64, i::Float64, Ω::Float64, w::Float64, λ::Vector{Float64}, Φ::Vector{Float64})
    plot(size=(4096, 2160), legend=false)
    scatter!(λ, Φ, markersize=0.03, markercolor=:midnightblue)
    title!("a=$(round(a; digits=3)) e=$e i=$i Ω=$Ω ω=$w")
    xlabel!("longitude [deg]")
    ylabel!("latitude [deg]")
    xlims!(-180, 180)
    ylims!(-90, 90)
    savefig("suborbital_track_$(round(a; digits=3))_$(e)_$(i)_$(Ω)_$(w).png")
end
