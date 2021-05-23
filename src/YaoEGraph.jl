module YaoEGraph

using Metatheory
using Metatheory.EGraphs
@metatheory_init

# Custom type APIs for the GATExpr
using YaoHIR
using Metatheory.TermInterface

function TermInterface.preprocess(c::Chain)
    if length(c.args) > 2
        return Chain(c.args[1], preprocess(Chain(c.args[2:end]...)))
    end
    return c
end

TermInterface.gethead(t::Chain) = :call
TermInterface.getargs(t::Chain) = [:Chain, t.args...]
TermInterface.arity(t::Chain) = length(TermInterface.getargs(t))
TermInterface.istree(e::Chain) = true

TermInterface.gethead(t::Gate) = :call
TermInterface.getargs(t::Gate) = [:Gate, t.operation,  t.locations]
TermInterface.arity(t::Gate) = length(TermInterface.getargs(t))
TermInterface.istree(e::Gate) = true

TermInterface.gethead(t::Ctrl) = :call
TermInterface.getargs(t::Ctrl) = [:Ctrl, t.gate, t.ctrl]
TermInterface.arity(t::Ctrl) = length(TermInterface.getargs(t))
TermInterface.istree(e::Ctrl) = true

function TermInterface.similarterm(x::Type{Chain}, head, args; metadata=nothing)
    @assert head == :call && args[1] == :Chain
    Chain(args[2:end]...)
end

function TermInterface.similarterm(x::Type{Gate}, head, args; metadata=nothing)
    @assert head == :call && args[1] == :Gate
    Gate(args[2], args[3])
end

function TermInterface.similarterm(x::Type{Ctrl}, head, args; metadata=nothing)
    @assert head == :call && args[1] == :Ctrl
    Ctrl(args[2], args[3])
end

end
