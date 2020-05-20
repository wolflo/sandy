requires "../prefix.k"

module PREFIX-CONTINUE-CALLER-SPEC
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
        <callData> _ </callData>
        <caller> CALLER_ID </caller>
    requires
        notBool CALLER_ID ==Int killer
        andBool VGAS >=Int 56

endmodule
