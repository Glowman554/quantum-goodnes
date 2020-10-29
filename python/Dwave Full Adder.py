from dwave.system import DWaveSampler, EmbeddingComposite
import dwave.inspector
from dwavebinarycsp.factories import or_gate, and_gate, xor_gate
import dwavebinarycsp as dbc

csp = dbc.ConstraintSatisfactionProblem("BINARY")

csp.add_constraint(xor_gate(["a1", "b1", "ad0_sum0"]))
csp.add_constraint(and_gate(["a1", "b1", "ad0_carry0"]))
csp.add_constraint(xor_gate(["ad0_sum0", "cin", "sum0"]))
csp.add_constraint(and_gate(["ad0_sum0", "cin", "ad0_carry1"]))
csp.add_constraint(or_gate(["ad0_carry0", "ad0_carry1", "ad0_cout"]))

csp.add_constraint(xor_gate(["a2", "b2", "ad1_sum0"]))
csp.add_constraint(and_gate(["a2", "b2", "ad1_carry0"]))
csp.add_constraint(xor_gate(["ad1_sum0", "ad0_cout", "sum1"]))
csp.add_constraint(and_gate(["ad1_sum0", "ad0_cout", "ad1_carry1"]))
csp.add_constraint(or_gate(["ad1_carry0", "ad1_carry1", "cout"]))
csp.fix_variable("sum0", 1)
csp.fix_variable("sum1", 1)
csp.fix_variable("cout", 1)

bqm = dbc.stitch(csp)

sampler = EmbeddingComposite(DWaveSampler(solver={"qpu" : True}))
sampleset = sampler.sample(bqm, num_reads=100)
print(sampleset)

for sample, energy in sampleset.data(["sample", "energy"]):
    print(sample, energy)

# dwave.inspector.show(sampleset)