
# coding: utf-8

# In[1]:


import dwavebinarycsp as dbc
from dwave.system import EmbeddingComposite, DWaveSampler


# In[2]:


def to_base_ten(sample):
    a = b = 0
    
    # we know that multiplication_circuit() has created these variables
    a_vars = ['a0', 'a1', 'a2']
    b_vars = ['b0', 'b1', 'b2']
    
    for lbl in reversed(a_vars):
        a = (a << 1) | sample[lbl]
    for lbl in reversed(b_vars):
        b = (b << 1) | sample[lbl] 
        
    return a,b


# In[13]:


P = 0

P = int(input("Please input number lower than 63 to factor> "))

bP = "{:06b}".format(P)

print("Converting number {0} to binary {1}".format(P, bP))

csp = dbc.factories.multiplication_circuit(3)
bqm = dbc.stitch(csp, min_classical_gap=.1)

p_vars = ['p0', 'p1', 'p2', 'p3', 'p4', 'p5']

# Convert P from decimal to binary
fixed_variables = dict(zip(reversed(p_vars), bP))
fixed_variables = {var: int(x) for(var, x) in fixed_variables.items()}

for var, value in fixed_variables.items():
    bqm.fix_variable(var, value)
    print("Fixing Variable {0} to value {1}".format(var, value))


# In[16]:


sampler = EmbeddingComposite(DWaveSampler(solver={'qpu': True}))
sampleset = sampler.sample(bqm, num_reads = 5000)
print(sampleset)
print("Best solution found: \n",sampleset.first.sample)
a, b = to_base_ten(sampleset.first.sample)

print("Given integer P={0}, found factors a={1} and b={2}".format(P, a, b))
if a * b == P:
    print("The Solution is correct")
else:
    print("The Solution is not correct")

