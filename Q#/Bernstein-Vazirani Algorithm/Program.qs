namespace BVA {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    

    @EntryPoint()
    operation Main() : Unit {

        let num = [1,1,1,0,1,1,0,1,0,1];
        
        let len = 10;

        using (q = Qubit[len+1]) {

            X(q[len]);

            for(idxNum in 0 .. len) {
                H(q[idxNum]);
            }

            for(idxNum in 0 .. len -1){
                if(num[idxNum] == 1){
                    CX(q[idxNum], q[len]);
                }
            }

            for(idxNum in 0 .. len) {
                H(q[idxNum]);
            }


            for(idxNum in 0 .. len -1) {
                if(M(q[idxNum]) == One){
                    Message($"1");
                } else {
                    Message($"0");
                }
            }
            ResetAll(q);
        }
        
    }
}
