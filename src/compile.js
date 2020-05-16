const path = require('path');
const fs = require('fs');
const parser = require('./huff/src/parser');
const compiler = require('./huff/src/compiler');

const modulesPath = path.posix.resolve(__dirname, './huff_modules');
const OUT_PATH = '../out/';
const SANDY_OUT = OUT_PATH + '../out/sandy.bin';
const KILL_PREFIX_OUT = OUT_PATH + '../out/kill_prefix.bin';

const sandy = assembleMain('sandy.huff', modulesPath);
const kill_prefix = assembleMain('kill_prefix.huff', modulesPath);

writeBin(SANDY_OUT, sandy);
writeBin(KILL_PREFIX_OUT, kill_prefix);

console.log(`bytecode written to ${OUT_PATH}`);

function assembleMain(filename, modPath) {
  const { inputMap, macros, jumptables } = parser.parseFile(filename, modPath);
  return parser.processMacro('MAIN', 0, [], macros, inputMap, jumptables).data.bytecode;
}

function writeBin(file, bytecode) {
  fs.writeFileSync(path.posix.resolve(__dirname, file), bytecode);
}
