requires "lemmas.k"

module PREFIX
    imports EVM-ASSEMBLY
    imports LEMMAS

    syntax ByteArray ::= "prefix"
    rule prefix => #parseByteStack("600436146000356341c0e1b560e01b1473ffffffffffffffffffffffffffffffffffffffff3314161615602f5733ff5b") [macro]

    syntax ByteArray ::= "killFunctionSig"
    rule killFunctionSig => #abiCallData("kill", .TypedArgs) [macro]

    syntax Int ::= "killer"
    rule killer => #parseAddr("0xffffffffffffffffffffffffffffffffffffffff") [macro]

endmodule
