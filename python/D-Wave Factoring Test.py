
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


# In[7]:


def factor(P):
    bP = "{:06b}".format(P)
    csp = dbc.factories.multiplication_circuit(3)
    bqm = dbc.stitch(csp, min_classical_gap=.1)
    p_vars = ['p0', 'p1', 'p2', 'p3', 'p4', 'p5']
    fixed_variables = dict(zip(reversed(p_vars), bP))
    fixed_variables = {var: int(x) for(var, x) in fixed_variables.items()}
    for var, value in fixed_variables.items():
        bqm.fix_variable(var, value)
        
    sampler = EmbeddingComposite(DWaveSampler(solver={'qpu': True}))
    sampleset = sampler.sample(bqm, num_reads = 1000)
    a, b = to_base_ten(sampleset.first.sample)
    print("Given integer P={0}, found factors a={1} and b={2}".format(P, a, b))
    return a, b


# In[15]:


for i in range(1, 8):
    a, b = factor(i*i)
    if a*b == i*i:
        print("The solution is correct")

