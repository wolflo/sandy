requires "edsl.k"
requires "../prefix.k"

module PREFIX-CONTINUE-CALLER-SPEC
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
        <callData> _ </callData>
        <caller> CALLER_ID </caller>
    requires
        notBool CALLER_ID ==Int killer

endmodule
