namespace Grover {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation Module1(q1 : Qubit, q2 : Qubit) : Unit {
        H(q1);
        H(q2);
    }

    operation Module2(q1 : Qubit, q2 : Qubit) : Unit {
        H(q1);
        X(q2);
        CNOT(q2, q1);
        H(q1);
        X(q2);
    }

    operation Module3(q1 : Qubit, q2 : Qubit) : Unit {
        H(q2);
        CNOT(q1, q2);
        H(q2);
    }

    @EntryPoint()
    operation Grover() : Unit {
        using (q = Qubit[2]) {

            Module1(q[0], q[1]);
            Module2(q[0], q[1]);
            Module1(q[0], q[1]);
            Module3(q[0], q[1]);
            Module2(q[1], q[0]);
            Module2(q[0], q[1]);
            Module1(q[0], q[1]);


            let res1 = MResetZ(q[0]);
            let res2 = MResetZ(q[1]);
            Message($"{res1} {res2}");
        }
    }
}
