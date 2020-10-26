OPENQASM 2.0;
include "qelib1.inc";
gate cccz ( ) q0, q1, q2, q3  {
  cu1 ( pi / 4 ) q0, q3;
  cx q0, q1;
  cu1 ( - pi / 4 ) q1, q3;
  cx q0, q1;
  cu1 ( pi / 4 ) q1, q3;
  cx q1, q2;
  cu1 ( - pi / 4 ) q2, q3;
  cx q0, q2;
  cu1 ( pi / 4 ) q2, q3;
  cx q1, q2;
  cu1 ( - pi / 4 ) q2, q3;
  cx q0, q2;
  cu1 ( pi / 4 ) q2, q3;
}

gate oracal ( ) q0, q1, q2, q3  {
  x q0;
  x q1;
  cccz q0, q1, q2, q3;
  x q0;
  x q1;
}

qreg q[4];
creg c[4];

h q[0];
h q[1];
h q[2];
h q[3];
barrier q[0],q[1],q[2],q[3];
oracal q[0],q[1],q[2],q[3];
h q[0];
h q[1];
h q[2];
h q[3];
x q[0];
x q[1];
x q[2];
x q[3];
cccz q[0],q[1],q[2],q[3];
x q[0];
x q[1];
x q[2];
x q[3];
h q[0];
h q[1];
h q[2];
h q[3];
