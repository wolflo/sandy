requires "lemmas.k"
requires "verification.k"

module PREFIX
    imports VERIFICATION
    imports EVM-ASSEMBLY
    imports LEMMAS

    syntax ByteArray ::= "prefix"
    rule prefix => #parseByteStack("600436146000356341c0e1b560e01b147305a56e2d52c817161883f50c441c3228cfe54d9f3314161615602f5733ff5b") [macro]

    syntax Int ::= "killer"
    rule killer => #parseAddr("0x05a56e2d52c817161883f50c441c3228cfe54d9f") [macro]

endmodule
