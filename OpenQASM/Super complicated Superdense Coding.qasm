OPENQASM 2.0;
include "qelib1.inc";

qreg q[5];
creg c[5];

x q[0];
barrier q[1],q[0],q[2],q[3];
cx q[0],q[3];
h q[1];
cx q[1],q[2];
cx q[0],q[1];
h q[0];
h q[0];
cz q[0],q[2];
cx q[1],q[2];
barrier q[1],q[0],q[2];
h q[1];
cx q[3],q[1];
cx q[3],q[0];
cu1(-pi) q[3],q[0];
swap q[2],q[4];
barrier q[2],q[1],q[0];
cx q[4],q[3];
x q[0];
barrier q[1],q[0],q[2];
cx q[0],q[3];
h q[1];
cx q[1],q[2];
cx q[0],q[1];
h q[0];
h q[0];
cz q[0],q[2];
cx q[1],q[2];
barrier q[2],q[0],q[1];
h q[1];
cx q[3],q[1];
cx q[3],q[0];
u1(-pi) q[1];
x q[3];
cu1(-pi) q[3],q[0];
x q[3];
cx q[2],q[3];
barrier q[2],q[1],q[0],q[3];
h q[0];
cx q[0],q[1];
cx q[4],q[0];
cz q[2],q[0];
cx q[0],q[1];
h q[0];
measure q[0] -> c[0];
measure q[1] -> c[1];