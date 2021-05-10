using YaoEGraph
using Test

using Metatheory, Metatheory.EGraphs
using YaoHIR
using YaoLocations
using YaoHIR: X

@metatheory_init

naive = @theory begin
    Chain(Gate(X, locs), Gate(X, locs)) |> Chain([])
end

circ = Chain(Gate(X, Locations(1)), Gate(X, Locations(1)))
egraph = EGraph(circ)
saturate!(egraph, naive)
extract!(egraph, astsize)
