using YaoEGraph
using Test

using Metatheory, Metatheory.EGraphs
using YaoHIR
using YaoLocations
using YaoHIR: X

@metatheory_init ()

naive = @theory begin
    Chain(Gate(X, locs), Gate(X, locs)) |> Chain([])
end

circ = Chain(Gate(X, Locations(1)), Gate(X, Locations(1)))


TermInterface.getargs(circ)

egraph = EGraph(circ)
settermtype!(egraph, :Chain, 2, Chain)

display(egraph.classes); println()

saturate!(egraph, naive; mod=@__MODULE__)
x = extract!(egraph, astsize) 

@test x isa Chain 
@test x.args == [[]]