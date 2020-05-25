const path = require('path');
const fs = require('fs');
const parser = require('./huff/src/parser');

const modulesPath = path.posix.resolve(__dirname, './huff_modules');
const PLACEHOLDER_ADDR = '0xffffffffffffffffffffffffffffffffffffffff';
const OUT_PATH = '../out/';

const prefixParsed = parser.parseFile('prefix.huff', modulesPath);
const sandyParsed = parser.parseFile('sandy.huff', modulesPath);

const prefixHead = parser.processMacro(
  'PREFIX_HEAD',
  0,
  [],
  prefixParsed.macros,
  prefixParsed.inputMap,
  prefixParsed.jumptables
).data.bytecode;

const prefixTail = parser.processMacro(
  'PREFIX_TAIL',
  lenBytes(prefixHead) + 20,  // adjust jumpdests for prefixHead + address preceding
  [],
  prefixParsed.macros,
  prefixParsed.inputMap,
  prefixParsed.jumptables
).data.bytecode;

if(lenBytes(prefixHead) > 31) {
  throw 'ERR: prefix head size'
}
if(lenBytes(prefixTail) > 31) {
  throw 'ERR: prefix tail size'
}


const sandyArgs = {
  prefix_head: `0x${prefixHead}`,
  prefix_tail: `0x${prefixTail}`,
  prefix_head_len: toHex(lenBytes(prefixHead)),
  prefix_tail_len: toHex(lenBytes(prefixTail))
}

const sandy = parser.processMacro(
  'MAIN',
  0,
  [sandyArgs.prefix_head, sandyArgs.prefix_head_len, sandyArgs.prefix_tail, sandyArgs.prefix_tail_len],
  sandyParsed.macros,
  sandyParsed.inputMap,
  sandyParsed.jumptables
).data.bytecode;

const prefix = prefixHead + trimBytes(PLACEHOLDER_ADDR) + prefixTail;
writeBin('prefix.bin', prefix);
writeBin('prefix_head.bin', prefixHead);
writeBin('prefix_tail.bin', prefixTail);
writeBin('sandy.bin', sandy);

console.log('len(PREFIX_HEAD) :', prefixHead.length / 2, 'bytes')
console.log('PREFIX_HEAD      :', prefixHead, '\n')
console.log('len(PREFIX_TAIL) :', prefixTail.length / 2, 'bytes')
console.log('PREFIX_TAIL      :', prefixTail, '\n')
console.log('len(PREFIX)      :', prefix.length / 2, 'bytes')

console.log(`bytecode written to ${OUT_PATH}`);

function lenBytes(str) {
  return trimBytes(str).length / 2
}

function toHex(str) {
  const hexVal = str.toString(16);
  return hexVal.length % 2 !== 0 ?
    '0x0' + hexVal               :
    '0x' + hexVal;
}

function trimBytes(str) {
  if (str.length % 2 !== 0) {
    throw 'ERR: These aint bytes'
  }
  return str.replace(/^0x/,'')
}

function writeBin(filename, bytecode) {
  fs.writeFileSync(path.posix.resolve(__dirname, OUT_PATH + filename), bytecode);
}
