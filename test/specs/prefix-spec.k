requires "edsl.k"
requires "lemmas.k"

module PREFIX
    imports EVM-ASSEMBLY
    imports LEMMAS
    imports EDSL

    syntax ByteArray ::= "prefix"
    rule prefix => #parseByteStack("6004361460003560e01c6341c0e1b5147305a56e2d52c817161883f50c441c3228cfe54d9f3314161615602f5733ff5b") [macro]

    syntax Int ::= "killer"
    rule killer => #parseAddr("0x05a56e2d52c817161883f50c441c3228cfe54d9f") [macro]

endmodule

module PREFIX-SPEC
    imports PREFIX

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
        <caller> CALLER_ID </caller>
    requires
        #rangeAddress(CALLER_ID)
        andBool (
            #asWord(#take(32, CALLDATA)) >>Int 224 =/=Int #asWord(#abiCallData("kill", .TypedArgs))
            orBool #sizeByteArray(CALLDATA) =/=Int 4
            orBool CALLER_ID =/=Int killer
        )

endmodule
