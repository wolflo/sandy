requires "edsl.k"
requires "../prefix.k"

module PREFIX-CONTINUE-CALLDATA-SPEC
    imports PREFIX
    imports EDSL

    rule <k> #execute </k>
        <mode> NORMAL </mode>
        <schedule> ISTANBUL </schedule>
        <memoryUsed> 0 </memoryUsed>
        <program> prefix </program>
        <jumpDests> #computeValidJumpDests(prefix) </jumpDests>
        <pc> 0  => 47 </pc>
        <wordStack> .WordStack </wordStack>
        <gas> 100000 => ?_ </gas>
        <callData> CALLDATA </callData>
        <caller> _ </caller>
    requires
        notBool #asWord(#take(32, CALLDATA)) ==Int
                #asWord(#take(32, #abiCallData("kill", .TypedArgs)))

endmodule
