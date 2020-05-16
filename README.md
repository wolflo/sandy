# Sandy
A sandbox for executing semi-trusted evm bytecode.
Enables execution of arbitrary bytecode without jeopardizing a contract's storage.

- no delegatecalls
- keep a constant address
- no tricky security requirements like reserving storage slots
  
Sandy is indeterminate init code.
When deployed with create2, it calls back into the deploying contract with `sandyRuntime()` to get the runtime code.
Then, sandy adds a prefix that allows only the contract that deployed it to selfdestruct the runtime code.
The deploying contract's address is encoded in the runtime bytecode, so it cannot be changed and does not require reserving a storage slot.
