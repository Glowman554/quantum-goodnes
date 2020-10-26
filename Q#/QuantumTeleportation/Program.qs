namespace QuantumTeleportation {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation GenerateRandomBit() : Result {
        using (q = Qubit()) {
            H(q);
            let output = M(q);
            Reset(q);
            return output;
        }
    }

    operation Teleport(msg : Qubit, there : Qubit) : Unit { 
        using (register = Qubit[1]) {
            let here = register[0];

            H(here);
            CNOT(here, there);

            CNOT(msg, here);
            H(msg);

            if(M(msg) == One) {
                Z(there);
            }
            if(M(here) == One) {
                X(there);
            }
            Reset(here);
        }
    }

    operation TeleportClassicalMessage(message : Bool) : Bool {
        mutable measurement = false;

        using (register = Qubit[2]) {
            let msg = register[0];
            let there = register[1];

            if(message) { 
                X(msg); 
            }

            Teleport(msg, there);

            if(M(there) == One) {
                set measurement = true;
            }

            ResetAll(register);
        }
        return measurement;
    }

    @EntryPoint()
    operation TeleportRandom() : Unit {
        for (idxRun in 1 .. 80){
            let msg_orig = GenerateRandomBit();
            mutable msg = false;

            if(msg_orig == One) {
                set msg = true;
            } else {
                set msg = false;
            }

            let res = TeleportClassicalMessage(msg);

            Message($"Run {idxRun} out of 80");
            Message($"Teleporting message {msg}");
            Message($"{msg} -> {res}");
            if(msg == res) {
                Message($"Teleportation Sucsesfull!\n");
            }
        }
    }
}
