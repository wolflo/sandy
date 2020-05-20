requires "../prefix.k"

module PREFIX-CONTINUE-CALLDATA-SPEC
    imports PREFIX

    rule <k> #execute </k>
        <mode> NORMAL </mode>
        <schedule> ISTANBUL </schedule>
        <memoryUsed> 0 </memoryUsed>
        <localMem> .Map </localMem>
        <program> prefix </program>
        <jumpDests> #computeValidJumpDests(prefix) </jumpDests>
        <pc> 0  => 47 </pc>
        <wordStack> .WordStack </wordStack>
        <gas> VGAS => VGAS -Int 56 </gas>
        <callData> CALLDATA </callData>
        <caller> _ </caller>
    requires
        notBool #asWord(#take(32, CALLDATA)) ==Int #asWord(#take(32, killFunctionSig))
        andBool VGAS >=Int 56

endmodule
