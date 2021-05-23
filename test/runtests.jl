using YaoEGraph
using Test

using Metatheory, Metatheory.EGraphs
using YaoHIR
using YaoLocations
using YaoHIR: X, Y, Z

@metatheory_init ()

naive = @theory begin
    Chain(Gate(X, locs), Chain(Gate(X, locs), C)) => C
    Chain(Gate(Z, locs), Gate(Z, locs)) => Chain()
    Chain(Gate(Z, locs), Gate(Y, locs)) => Chain(Gate(X, locs))
end

circ = Chain(Gate(X, Locations(1)), Gate(X, Locations(1)), Gate(Z, Locations(1)), Gate(Y, Locations(1)))
c = TermInterface.preprocess(circ)

egraph = EGraph(c)
settermtype!(egraph, :Chain, 2, Chain)
settermtype!(egraph, :Gate, 2, Gate)
settermtype!(egraph, :Ctrl, 2, Ctrl)
display(egraph.classes); println()

saturate!(egraph, naive; mod = @__MODULE__)
x = extract!(egraph, astsize) 

@test x isa Chain 
# @test x.args == []