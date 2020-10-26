namespace HelloWorld {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;

    operation RandomBit() : Result {
        using (q = Qubit()) {
            H(q);
            return MResetZ(q);
        }
    }

    operation Teleport(from : Qubit, to : Qubit) : Unit {
        using (q = Qubit()) {
            H(q);
            CNOT(q, to);

            CNOT(from, q);
            H(from);

            if(M(from) == One) { Z(to); }
            if(M(q) == One) { X(to); }
            Reset(q);
        }
    }
    

    @EntryPoint()
    operation SayHello() : Unit {
        let shots = 10;
        for(idxNum in 1 .. shots) {

            mutable msg = Zero;

            using (q = Qubit[2]) {
                if(RandomBit() == One) {
                    X(q[0]);
                    set msg = One;
                }
                Teleport(q[0], q[1]);

                let r1 = MResetZ(q[0]);
                let r2 = MResetZ(q[1]);
                Message($"Qbit 1: {r1}, Qbit 2: {r2}, MSG_ORIG: {msg}");
                if(msg == r2) { Message($"Teleportation sucsesfull!\n"); }
            }
        }
    }
}
