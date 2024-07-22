module src

# push!(LOAD_PATH, raw"src\track")
# push!(LOAD_PATH, raw"src\anomaly")
# push!(LOAD_PATH, raw"src\coordinates")

include(raw"track\suborbital_track.jl")
include(raw"track\draw.jl")

# using track

export suborbital_track, draw
    
end