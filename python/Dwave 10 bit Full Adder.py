from dwave.system import DWaveSampler, EmbeddingComposite
import dwave.inspector
from dwavebinarycsp.factories import or_gate, and_gate, xor_gate
import dwavebinarycsp as dbc

def full_adder(c, in_a, in_b, cin, id):
    c.add_constraint(xor_gate([in_a, in_b, id + "_sum0"]))
    c.add_constraint(and_gate([in_a, in_b, id + "_carry0"]))
    c.add_constraint(xor_gate([id + "_sum0", cin, "sum" + id]))
    c.add_constraint(and_gate([id + "_sum0", cin, id + "_carry1"]))
    c.add_constraint(or_gate([id + "_carry0", id + "_carry1", id + "_cout"]))
    return c

csp = dbc.ConstraintSatisfactionProblem("BINARY")

csp = full_adder(csp, "a1", "b1", "cin", "0")
csp = full_adder(csp, "a2", "b2", "0_cout", "1")
csp = full_adder(csp, "a3", "b3", "1_cout", "2")
csp = full_adder(csp, "a4", "b4", "2_cout", "3")
csp = full_adder(csp, "a5", "b5", "3_cout", "4")
csp = full_adder(csp, "a6", "b6", "4_cout", "5")
csp = full_adder(csp, "a7", "b7", "5_cout", "6")
csp = full_adder(csp, "a8", "b8", "6_cout", "7")
csp = full_adder(csp, "a9", "b9", "7_cout", "8")
csp = full_adder(csp, "a10", "b10", "8_cout", "9")

for i in range(0, 9):
    csp.fix_variable("sum" + str(i), 1)

csp.fix_variable("9_cout", 1)

bqm = dbc.stitch(csp)

sampler = EmbeddingComposite(DWaveSampler(solver={"qpu" : True}))
sampleset = sampler.sample(bqm, num_reads=10000)
print(sampleset)

for sample, energy in sampleset.data(["sample", "energy"]):
    string = ""
    for i in range(1, 10):
        string += "a" + str(i) + ": " + str(sample["a" + str(i)]) + ", "
        string += "b" + str(i) + ": " + str(sample["b" + str(i)]) + ", "
    string += "cin: " + str(sample["cin"]) + " energy: " + str(energy)
    print(string)

dwave.inspector.show(sampleset)