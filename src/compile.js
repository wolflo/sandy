const path = require('path');
const fs = require('fs');
const parser = require('../huff/src/parser');
const compiler = require('../huff/src/compiler');

const OUT_FILE = '../out/sandy.bin'
const modulesPath = path.posix.resolve(__dirname, './huff_modules');

const { inputMap, macros, jumptables } = parser.parseFile('sandy.huff', modulesPath);
const main = parser.processMacro('MAIN', 0, [], macros, inputMap, jumptables).data.bytecode;

fs.writeFileSync(path.posix.resolve(__dirname, OUT_FILE), main);
console.log(`written bytecode to ${OUT_FILE}`);
