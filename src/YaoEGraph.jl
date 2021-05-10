module YaoEGraph

using Metatheory
using Metatheory.EGraphs
@metatheory_init

# Custom type APIs for the GATExpr
using YaoHIR
using Metatheory.TermInterface

TermInterface.gethead(t::Chain) = :call
TermInterface.getargs(t::Chain) = [:chain, t.args...]
TermInterface.gethead(t::Gate) = :call
TermInterface.getargs(t::Gate) = [:gate, t.locations]
TermInterface.gethead(t::Ctrl) = :call
TermInterface.getargs(t::Ctrl) = [:ctrl, t.gate, t.ctrl]

function EGraphs.extractnode(::EGraph, n::ENode{Chain}, extractor::Function)
    return Chain(extractor.(n.args[2:end])...)
end

end
