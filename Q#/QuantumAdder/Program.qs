namespace QuantumAdder {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;

    operation QuantumAdd(num1 : Int, num2 : Int) : Int {
        using (q = Qubit[11]) {

            let num1_arr = IntAsBoolArray(num1, 2);
            let num2_arr = IntAsBoolArray(num2, 2);

            for(idxNum in 0 .. 1){
                if(num1_arr[idxNum] == true) {X(q[idxNum]); }
                if(num1_arr[idxNum] == true) {X(q[idxNum + 2]); }
            }

            CNOT(q[0], q[4]);
            CNOT(q[2], q[4]);
            CCNOT(q[0], q[2], q[5]);

            CNOT(q[1], q[6]);
            CNOT(q[3], q[6]);
            CCNOT(q[1], q[3], q[7]);
            CNOT(q[6], q[8]);
            CNOT(q[5], q[8]);
            CCNOT(q[4], q[5], q[8]);
            X(q[7]);
            X(q[9]);
            CCNOT(q[7], q[9], q[10]);
            X(q[10]);

            let res = [M(q[4]), M(q[8]), M(q[10])];
            let ret = ResultArrayAsInt(res);

            ResetAll(q);

            return ret;
        }        
    }
    

    @EntryPoint()
    operation Main() : Unit {
        let res = QuantumAdd(2, 2);
        Message($"{res}");
    }
}
