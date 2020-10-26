OPENQASM 2.0;
include "qelib1.inc";
gate entangle ( ) q1, q2  {
  h q1;
  cx q1, q2;
}

gate epayload ( ) q1, q2  {
  h q1;
  h q2;
  cx q2, q1;
  h q2;
}

gate receive ( ) q  {
  x q;
  z q;
}

qreg q[5];
creg c[5];


//create entangelt pair
entangle q[2],q[4];
barrier q;
//create payload
x q[0];
h q[0];
t q[0];
barrier q;
//entangle payload and sent
epayload q[0],q[2];
measure q[0] -> c[0];
measure q[2] -> c[2];
barrier q[3],q[4];
//recive payload
receive q[4];
//verifi payload
barrier q[3],q[4];
tdg q[4];
h q[4];
x q[4];
measure q[4] -> c[4];