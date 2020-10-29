from dwave.system import DWaveSampler, EmbeddingComposite
import dwave.inspector
from dwavebinarycsp.factories import or_gate, and_gate, xor_gate
import dwavebinarycsp as dbc

bits = 10

def full_adder(c, in_a, in_b, cin, id):
    # print("Adding full-adder with id: {0}, cin: {1}, in_a: {2}, in_b: {3}".format(id, cin, in_a, in_b))
    c.add_constraint(xor_gate([in_a, in_b, id + "_sum0"]))
    c.add_constraint(and_gate([in_a, in_b, id + "_carry0"]))
    c.add_constraint(xor_gate([id + "_sum0", cin, "sum" + id]))
    c.add_constraint(and_gate([id + "_sum0", cin, id + "_carry1"]))
    c.add_constraint(or_gate([id + "_carry0", id + "_carry1", id + "_cout"]))
    return c

csp = dbc.ConstraintSatisfactionProblem("BINARY")

csp = full_adder(csp, "a1", "b1", "cin", "0")
csp.fix_variable("sum0", 1)

for i in range(1, bits):
    csp = full_adder(csp, "a" + str(i + 1), "b" + str(i + 1), str(i - 1) + "_cout", str(i))
    csp.fix_variable("sum" + str(i), 1)

csp.fix_variable(str(bits - 1) + "_cout", 1)

bqm = dbc.stitch(csp)

sampler = EmbeddingComposite(DWaveSampler(solver={"qpu" : True}))
sampleset = sampler.sample(bqm, num_reads=10000)

sample = sampleset.first.sample
a = b = ""
cin = str(sample["cin"])

for i in range(1, bits + 1):
    a += str(sample["a" + str(i)])
    b += str(sample["a" + str(i)])

print("Found a: {0}, b: {1}, cin: {2}".format(a, b, cin))

dwave.inspector.show(sampleset)