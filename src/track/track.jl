module track
    
push!(LOAD_PATH, raw"src\anomaly")
push!(LOAD_PATH, raw"src\coordinates")

include("suborbital_track.jl")
include("draw.jl")

export suborbital_track, draw

end