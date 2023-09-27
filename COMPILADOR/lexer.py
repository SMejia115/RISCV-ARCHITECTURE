import ply.lex as lex
import symbols

tokens = (
  # Types
  'TYPE_R',
  'TYPE_I',
  'TYPE_LI',
  'TYPE_JI',
  'TYPE_EI',
  'TYPE_S',
  'TYPE_B',
  'TYPE_U',
  'TYPE_J',

  # Symbols
  'COMMA',
  'COLON',
  'LPAREN',
  'RPAREN',

  # Others   
  'IMMEDIATE',
  'REGISTER',
  'LABEL',
)

# Regular expressions rules for a simple tokens 
t_COMMA = r','
t_COLON = r':'
t_LPAREN = r'\('
t_RPAREN = r'\)'

def t_TYPE_R(t):
  r'and\b|sub|sll\b|slt\b|sltu|xor\b|srl\b|sra\b|or\b|add\b'
  return t

def t_TYPE_I(t):
  r'addi|slli|slti\b|sltiu|xori|srli|srai|ori|andi'
  return t

def t_TYPE_LI(t):
  r'lb\b|lh\b|lw|lbu|lhu'
  return t

def t_TYPE_JI(t):
  r'jalr'
  return t

def t_TYPE_EI(t):
  r'ecall|ebreak'
  return t

def t_TYPE_S(t):
  r'sb|sh|sw'
  return t

def t_TYPE_B(t):
  r'beq|bne|blt\b|bge\b|bltu|bgeu'
  return t

def t_TYPE_U(t):
  r'lui|auipc'
  return t

def t_TYPE_J(t):
  r'jal'
  return t

def t_IMMEDIATE(t):
  r'(-)?\d+'
  t.value = int(t.value)
  return t

def t_REGISTER(t):
  r'x((1|2)\d|30|31|\d)|zero|ra|sp|gp|tp|t0|t1|t2|s0|s1\b|a0|a1|a2|a3|a4|a5|a6|a7|s2|s3|s4|s5|s6|s7|s8|s9|s10|s11|t3|t4|t5|t6'
  if t.value[0] == 'x':
    t.value = int(t.value[1:])
  else:
    t.value = symbols.instructions['REGISTER'][t.value]
  return t

def t_LABEL(t):
  r'[a-zA-Z_][a-zA-Z_0-9]*'
  return t

t_ignore = ' \t'

def t_newline(t):
  r'\n(\s)*'
  t.lexer.lineno += 1

def t_comments(t):
  r'\#(.)*\n'
  t.lexer.lineno += 1

def t_error(t):
  print ("Lexical error: " + str(t.value))
  t.lexer.skip(1)

lexer = lex.lex()

class Lexer:
  def __init__(self):
    self.lexer = lex.lex()

  def input(self, data):
    self.lexer.input(data)

  def result_tokens(self):
    tokens = list()
    while True:
      token = self.lexer.token() # Preguntar por el .token()
      if not token:
        break
      tokens.append(token)
      
    return tokens

