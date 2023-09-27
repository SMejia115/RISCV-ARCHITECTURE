opcodes_types = {
  'R': '0110011',
  'I': '0010011',
  'LI': '0000011',
  'JI': '1100111',
  'EI': '1110011',
  'S': '0100011',
  'B': '1100011',
  'U': None,
  'J': '1101111',
}

instructions  = {
  'add': {'funct3': '000', 'funct7': '0000000', 'type': 'R'},
  'sub': {'funct3': '000', 'funct7': '0100000', 'type': 'R'},
  'sll': {'funct3': '001', 'funct7': '0000000', 'type': 'R'},
  'slt': {'funct3': '010', 'funct7': '0000000', 'type': 'R'},
  'sltu': {'funct3': '011', 'funct7': '0000000', 'type': 'R'},
  'xor': {'funct3': '100', 'funct7': '0000000', 'type': 'R'},
  'srl': {'funct3': '101', 'funct7': '0000000', 'type': 'R'},
  'sra': {'funct3': '101', 'funct7': '0100000', 'type': 'R'},
  'or': {'funct3': '110', 'funct7': '0000000', 'type': 'R'},
  'and': {'funct3': '111', 'funct7': '0000000', 'type': 'R'},
  
  'addi': {'funct3': '000', 'type': 'I'},
  'slli': {'funct3': '001', 'funct7': '0000000', 'type': 'I'},
  'slti': {'funct3': '010', 'type': 'I'},
  'sltiu': {'funct3': '011', 'type': 'I'},
  'xori': {'funct3': '100', 'type': 'I'},
  'srli': {'funct3': '101', 'funct7': '0000000', 'type': 'I'},
  'srai': {'funct3': '101', 'funct7': '0100000', 'type': 'I'},
  'ori': {'funct3': '110', 'type': 'I'},
  'andi': {'funct3': '111', 'type': 'I'},
  
  'lb': {'funct3': '000', 'type': 'LI'},
  'lh': {'funct3': '001', 'type': 'LI'},
  'lw': {'funct3': '010', 'type': 'LI'},
  'lbu': {'funct3': '100', 'type': 'LI'},
  'lhu': {'funct3': '101', 'type': 'LI'},
  
  'jalr': {'funct3': '000', 'type': 'JI'},
  
  'ecall': {'funct3': '000', 'funct7': '0000000', 'type': 'EI'},
  'ebreak': {'funct3': '000', 'funct7': '0000000', 'type': 'EI'},
  
  'sb': {'funct3': '000', 'type': 'S'},
  'sh': {'funct3': '001', 'type': 'S'},
  'sw': {'funct3': '010', 'type': 'S'},
  
  'beq': {'funct3': '000', 'type': 'B'},
  'bne': {'funct3': '001', 'type': 'B'},
  'blt': {'funct3': '100', 'type': 'B'},
  'bge': {'funct3': '101', 'type': 'B'},
  'bltu': {'funct3': '110', 'type': 'B'},
  'bgeu': {'funct3': '111', 'type': 'B'},

  'lui': {'opcode': '0110111', 'type': 'U'},
  'auipc': {'opcode': '0010111', 'type': 'U'},
  
  'jal': {'funct3': '000', 'type': 'J'},
  
  'REGISTER': {
    'zero': 0, 'ra': 1, 'sp': 2, 'gp': 3, 'tp': 4, 't0': 5, 't1': 6, 't2': 7,
    's0': 8, 's1': 9, 'a0': 10, 'a1': 11, 'a2': 12, 'a3': 13, 'a4': 14, 'a5': 15,
    'a6': 16, 'a7': 17, 's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23,
    's8': 24, 's9': 25, 's10': 26, 's11': 27, 't3': 28, 't4': 29, 't5': 30, 't6': 31,
  },
}

labels = {}