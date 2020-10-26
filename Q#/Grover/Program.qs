namespace Grover {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    
    @EntryPoint()
    operation Main() : Unit {
        let num = 4;
        mutable succsess = 0;
        for(idxNum in 1 .. 100) {
            if(Grover(num) == num){
                set succsess += 1;
            }
        }
        Message($"Got the right number {succsess} times.");
    }


    operation Grover(num : Int) : Int {
        using (q = Qubit[3]) {
            H(q[0]);
            H(q[1]);
            H(q[2]);
            H(q[2]);
            CCNOT(q[0], q[1], q[2]);
            H(q[2]);

            let arr = IntAsBoolArray(num, 3);
            for(idxNum in 0 .. 2){
                if(arr[idxNum] == true){
                    X(q[idxNum]);
                }
            }

            H(q[0]);
            H(q[1]);
            H(q[2]);
            X(q[0]);
            X(q[1]);
            X(q[2]);
            H(q[2]);
            CCNOT(q[0], q[1], q[2]);
            H(q[2]);
            H(q[0]);
            H(q[1]);
            H(q[2]);
            X(q[0]);
            X(q[1]);
            X(q[2]);
            let res = [M(q[0]), M(q[1]), M(q[2])];
            let num_res = ResultArrayAsInt(res);
            Message($"Running Grover... \n Result: {num_res}\n");
            ResetAll(q);
            return num_res;
        }
    }
}
