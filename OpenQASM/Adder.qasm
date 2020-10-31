OPENQASM 2.0;
include "qelib1.inc";
gate xor ( ) a, b, out  {
  x a;
  x b;
  x out;
  ccx a, b, out;
  x a;
  x b;
  ccx a, b, out;
}

gate and ( ) a, b, out  {
  ccx a, b, out;
}

gate halfadder ( ) a, b, sum, carry  {
  xor a, b, sum;
  and a, b, carry;
}

gate or ( ) a, b, out  {
  x a;
  x b;
  x out;
  ccx a, b, out;
  x a;
  x b;
}

qreg q[10];
creg c[10];

x q[0];
x q[1];
x q[5];
halfadder q[0],q[1],q[2],q[3];
cx q[2],q[4];
halfadder q[4],q[5],q[6],q[7];
or q[3],q[7],q[9];
cx q[6],q[8];
measure q[8] -> c[8];
measure q[9] -> c[9];