module YaoEGraph

using Metatheory
using Metatheory.EGraphs
@metatheory_init

# Custom type APIs for the GATExpr
using YaoHIR
using Metatheory.TermInterface

TermInterface.gethead(t::Chain) = :call
TermInterface.getargs(t::Chain) = [:chain, t.args...]
TermInterface.arity(t::Chain) = length(TermInterface.getargs(t))
TermInterface.istree(e::Chain) = true

TermInterface.gethead(t::Gate) = :call
TermInterface.getargs(t::Gate) = [:gate, t.locations]
TermInterface.arity(t::Gate) = length(TermInterface.getargs(t))
TermInterface.istree(e::Gate) = true

TermInterface.gethead(t::Ctrl) = :call
TermInterface.getargs(t::Ctrl) = [:ctrl, t.gate, t.ctrl]
TermInterface.arity(t::Ctrl) = length(TermInterface.getargs(t))
TermInterface.istree(e::Ctrl) = true


function EGraphs.extractnode(g::EGraph, n::ENode{Chain}, extractor::Function)
    return Chain(extractor.(n.args[2:end])...)
end

# function EGraphs.extractnode(g::EGraph, n::ENode{Gate}, extractor::Function)
#     return Gate(extractor.(n.args[2:end])...)
# end

# function EGraphs.extractnode(g::EGraph, n::ENode{Ctrl}, extractor::Function)
#     return Ctrl(extractor.(n.args[2:end])...)
# end

end
