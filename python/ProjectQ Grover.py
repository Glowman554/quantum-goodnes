from projectq.ops import H, Measure, CZ, Z, X, All
from projectq import MainEngine
from projectq.backends import AQTBackend
import projectq.setups.aqt
from projectq.libs.hist import histogram
import matplotlib.pyplot as plt
from projectq.setups.default import get_engine_list

device = "aqt_simulator"
with open("tokens.txt", "r") as file:
	token = file.read().split("\n")[1]

def oracale(q):
	All(H) | q
	
	All(Z) | q
	
	CZ | (q[0], q[1])
	
	return q

def reflection(q):
	All(H) | q
	All(X) | q
	CZ | (q[0], q[1])
	All(H) | q
	return q

def circuit(engine):
	q = engine.allocate_qureg(2)
	
	q = oracale(q)
	q = reflection(q)
	
	
	#All(Measure) | q
	
	engine.flush()
	
	histogram(eng.backend, q)
	plt.show()
	

#engine = input("Engin> ")
engine = "aqt"

if engine == "aqt":
	backend = AQTBackend(use_hardware=True, token=token, num_runs=200, verbose=False, device=device)
	engine_list = projectq.setups.aqt.get_engine_list(token=token, device=device)
	eng = MainEngine(backend, engine_list=engine_list)
if engine == "sim":
	eng = MainEngine(engine_list=get_engine_list())
	
circuit(eng)
	
