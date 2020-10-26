OPENQASM 2.0;
include "qelib1.inc";

qreg q[3];
creg c[3];

h q[0];
h q[1];
barrier q[0],q[1];
z q[0];
barrier q[0],q[1];
cz q[0],q[1];
h q[0];
h q[1];
x q[0];
x q[1];
h q[1];
cx q[0],q[1];
barrier q[0];
h q[1];
x q[0];
x q[1];
h q[0];
h q[1];