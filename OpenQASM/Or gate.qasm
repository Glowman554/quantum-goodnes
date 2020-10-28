OPENQASM 2.0;
include "qelib1.inc";

qreg q[3];
creg c[3];

x q[0];
barrier q[1],q[0],q[2];
x q[0];
x q[1];
x q[2];
ccx q[0],q[1],q[2];
x q[0];
x q[1];
measure q[2] -> c[2];