namespace Random {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    
    operation RandomBit() : Result{
        using (q = Qubit()) {
            H(q);
            return MResetZ(q);
        }
    }

    @EntryPoint()
    operation Main() : Unit{
        let shots = 5;
        for(idxRun in 1 .. shots){
            let res = RandomBit();
            Message($"Shot {idxRun} von {shots}: {res}");
        }
    }
}
