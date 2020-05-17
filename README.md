# Sandy
Sandy enables execution of arbitrary bytecode without jeopardizing a contract's storage.

- no `delegatecall`s
- no tricky security requirements like reserving storage slots
- keep a constant execution address
  
Sandy is indeterminate init code.
When deployed, it calls back into the deploying contract with `sandyRuntime()` to get the runtime code.
Then, sandy adds a prefix that allows only the contract that deployed it to selfdestruct the runtime code.
The deploying contract's address is encoded in the runtime bytecode, so it cannot be changed and does not require reserving a storage slot.
