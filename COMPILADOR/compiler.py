'''
Realizado por:

Juan Pablo Garcia Montes
Santiago Mejia Orejuela
'''

import sys

from lexer import Lexer
from yacc import Parser
import symbols

class Compiler:
  def __init__(self):
    self.lexer = Lexer()
    self.parser = Parser()

  def complementoADos(self, numeroBinario):
    # Invertir todos los bits
    bits_invertidos = ''.join('1' if bit == '0' else '0' for bit in numeroBinario)
    
    # Convertir la cadena invertida a un entero y sumarle 1
    complemento_a_dos = bin(int(bits_invertidos, 2) + 1)[2:]
    
    return complemento_a_dos


  def convierteNum(self, num, size):
    if num >= 0:
      return bin(num)[2:].zfill(size)
    else:
      numBin = bin(num*-1)[2:].zfill(size)
      return self.complementoADos(numBin)

  
  def translate(self, index, line):
  
    inst = line[0]

    if symbols.instructions[inst]['type'] == 'R':
      inst_bin = self.translate_R(line)
    
    elif symbols.instructions[inst]['type'] == 'I':
      inst_bin = self.translate_I(line)

    elif symbols.instructions[inst]['type'] == 'LI':
      inst_bin = self.translate_LI(line)

    elif symbols.instructions[inst]['type'] == 'JI':
      inst_bin = self.translate_I(line)

    elif symbols.instructions[inst]['type'] == 'EI':
       inst_bin = self.translate_E(line)

    elif symbols.instructions[inst]['type'] == 'S':
      inst_bin = self.translate_S(line)

    elif symbols.instructions[inst]['type'] == 'U':
      inst_bin = self.translate_U(line)

    elif symbols.instructions[inst]['type'] == 'J':
      inst_bin = self.translate_J(line, index)

    elif symbols.instructions[inst]['type'] == 'B':
      inst_bin = self.translate_B(line, index)

    return inst_bin
  
  
  def translate_R(self, line):
    inst = line[0]
    rd = bin(line[1])[2:].zfill(5)
    rs1 = bin(line[2])[2:].zfill(5)
    rs2 = bin(line[3])[2:].zfill(5)
    funct7 = symbols.instructions[inst]['funct7']
    funct3 = symbols.instructions[inst]['funct3']
    opcode = symbols.opcodes_types[symbols.instructions[inst]['type']]

    inst_bin = funct7 + rs2 + rs1 + funct3 + rd + opcode

    return inst_bin
  
  
  def translate_I(self, line):
    inst = line[0]
    rd = bin(line[1])[2:].zfill(5)
    rs1 = bin(line[2])[2:].zfill(5)
    imm = self.convierteNum(line[3],12)
    funct3 = symbols.instructions[inst]['funct3']
    opcode = symbols.opcodes_types[symbols.instructions[inst]['type']]
    
    if inst == 'slli' or inst == 'srli' or inst == 'srai':
      shamt = imm[7:12]
      imm = symbols.instructions[inst]['funct7'] + shamt

    inst_bin = imm + rs1 + funct3 + rd + opcode

    return inst_bin


  def translate_LI(self, line):
    inst = line[0]
    rd = bin(line[1])[2:].zfill(5)
    imm = self.convierteNum(line[2],12)
    ra = bin(line[3])[2:].zfill(5)
    funct3 = symbols.instructions[inst]['funct3']
    opcode = symbols.opcodes_types[symbols.instructions[inst]['type']]

    inst_bin = imm + ra + funct3 + rd + opcode

    return inst_bin
  
  
  def translate_J(self, line, index):
    inst = line[0]
    rd = bin(line[1])[2:].zfill(5)
    label = line[2]
    inm_label = self.convierteNum((symbols.labels[label] - index) * 4, 21) 
    opcode = symbols.opcodes_types[symbols.instructions[inst]['type']]

    inst_bin = inm_label[0] + inm_label[10:20] + inm_label[9] + inm_label[1:9] + rd + opcode

    return inst_bin

  
  def translate_S(self, line):
    inst = line[0]
    rs = bin(line[1])[2:].zfill(5)
    inm = self.convierteNum(line[2],12)
    ra = bin(line[3])[2:].zfill(5)
    funct3 = symbols.instructions[inst]['funct3']
    opcode = symbols.opcodes_types[symbols.instructions[inst]['type']]

    inst_bin = inm[0:7] + rs + ra+funct3 + inm[7:12] + opcode

    return inst_bin

  
  def translate_U(self, line):
    inst = line[0]
    rd = bin(line[1])[2:].zfill(5)
    imm = self.convierteNum(line[2],20)
    opcode = symbols.instructions[inst]['opcode']

    inst_bin = imm + rd + opcode

    return inst_bin

  
  def translate_B(self, line, index):
    inst = line[0]
    rs1 = bin(line[1])[2:].zfill(5)
    rs2 = bin(line[2])[2:].zfill(5)
    label = line[3]
    
    imm_label = self.convierteNum(((symbols.labels[label] - index) * 4), 13)

    opcode = symbols.opcodes_types['B']
    funct3 = symbols.instructions[inst]['funct3']

    inst_binaria = imm_label[0] + imm_label[2:8] + rs2 + rs1 + funct3 + imm_label[8:12] + imm_label[1] + opcode
    
    return inst_binaria

  
  def translate_E(self, line):
    inst = line[0]
    if line[0] == 'ecall':
      imm = self.convierteNum(0,12)
    elif line[0] == 'ebreak':
      imm = self.convierteNum(1,12)
    opcode = symbols.opcodes_types['EI']
    inst_bin =  imm + '0000000000000' + opcode

    return inst_bin

  def compile(self, data):
    self.lexer.input(data)
    tokens = self.lexer.result_tokens()
        
    parsed = self.parser.parse(data)
    
    for index, line in enumerate(parsed):
      if isinstance(line, str):
        symbols.labels[line] = index
        parsed.pop(index)

    output = ''
    
    for index, line in enumerate(parsed):
      binary_inst = ''
      if isinstance(line, tuple):
        binary_inst = self.translate(index, line)
      output += binary_inst + '\n'
      
    return output


if __name__ == '__main__':
  if (len(sys.argv) > 1):
    path = sys.argv[1]
  else:
    path = 'evaluacion.s48'
    
  f = open(path, 'r')
  data = f.read()
  f.close()
  
  compiler = Compiler()
  output = compiler.compile(data)
  
  if (len(sys.argv) > 2):
    path_output = sys.argv[2]
  else:
    path_output = '..\MONOCYCLE\instructions.txt'
  f = open(path_output, 'w')
  f.write(output)
  f.close()