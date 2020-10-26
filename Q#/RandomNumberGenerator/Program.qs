namespace RandomNumberGenerator {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;

    operation GenerateRandomBit() : Result {
        using (q = Qubit()) {
            H(q);
            return MResetZ(q);
        }
    }

    operation RandomNumberInRange(max : Int) : Int {
        mutable output = 0;
        repeat{
            mutable bits = new Result[0];
            for(idxBit in 1..BitSizeI(max)){
                set bits += [GenerateRandomBit()];
            } 
            set output = ResultArrayAsInt(bits);
        } until (output <= max);
        return output;
    }

    @EntryPoint()
    operation RandomNumber() : Unit{
        let max = 50;
        let res = RandomNumberInRange(max);
        Message($"Sampling a random number between 0 and {max}: {res}");
    }
}
