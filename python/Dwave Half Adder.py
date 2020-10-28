
# coding: utf-8

# In[16]:


from dwave.system import DWaveSampler, EmbeddingComposite
from dwavebinarycsp.factories import and_gate, xor_gate
import dwavebinarycsp as dbc
import dwave.inspector


# In[21]:


gates = []
csp = dbc.ConstraintSatisfactionProblem('BINARY')

gates.append(xor_gate(["a", "b", "sum"]))
gates.append(and_gate(["a", "b", "carry"]))

for i in gates:
    csp.add_constraint(i)
    
bqm = dbc.stitch(csp)


# In[27]:


sampler = EmbeddingComposite(DWaveSampler(solver={"qpu" : True}))
sampleset = sampler.sample(bqm, num_reads=10)
print(sampleset)

