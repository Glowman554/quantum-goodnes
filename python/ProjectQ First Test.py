from projectq.ops import H, Measure, CX, All
from projectq import MainEngine
from projectq.backends import AQTBackend
import projectq.setups.aqt
from projectq.libs.hist import histogram
import matplotlib.pyplot as plt
from projectq.setups.default import get_engine_list

device = "aqt_simulator"
with open("tokens.txt", "r") as file:
	token = file.read().split("\n")[1]

def circuit(engine):
	q = engine.allocate_qureg(2)
	H | q[0]
	CX | (q[0], q[1])
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
	
